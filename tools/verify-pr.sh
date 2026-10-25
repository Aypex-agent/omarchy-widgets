#!/usr/bin/env bash
# Checks a pull request's widgets, faces and apps with this checkout's tools/owl.jar and
# the levels in owl.txt. Nothing from the pull request is checked out or run: its
# folders are read out of git as data into a scratch folder, and the checkers read
# them there.
#
#   tools/verify-pr.sh <pr number> [out dir]
#
# CI sets BASE (the base commit), LOGIN and ROLE (the author's login and
# association); run by hand, they come from origin/main and the GitHub CLI.
set -euo pipefail

pr=$1
cd "$(dirname "$0")/.."
out=${2:-$(mktemp -d)}
mkdir -p "$out/base"

git fetch -q origin "+refs/pull/$pr/head:refs/verify/pr-$pr"
head=$(git rev-parse "refs/verify/pr-$pr")
base=$(git merge-base "${BASE:-origin/main}" "$head")
login=$(echo "${LOGIN:-$(gh pr view "$pr" --json author --jq .author.login)}" | tr 'A-Z' 'a-z')
role=${ROLE:-$(gh api "repos/{owner}/{repo}/pulls/$pr" --jq .author_association)}
trusted() { [ "$role" = OWNER ] || [ "$role" = MEMBER ]; }

echo "pull request #$pr at $head, by @$login ($role)" >&2
bad=0
fail() { echo "::error file=$1::$2"; bad=1; }

# The level in a file's meta { owl: N }, 1 without one; owl.txt says which levels the store takes.
level() { awk 'match($0, /(^|[^A-Za-z0-9_])owl:[ \t]*[0-9]+/) { s = substr($0, RSTART, RLENGTH); sub(/.*:[ \t]*/, "", s); print s; found = 1; exit } END { if (!found) print 1 }' "$1"; }
levels=$(sed 's/#.*//' owl.txt | awk 'NF >= 2')
newest=$(echo "$levels" | sort -n | tail -1)
oldest=$(echo "$levels" | awk '$2 == "supported" { print $1 }' | sort -n | head -1)

# Every file the pull request touches, not only those under widgets/, faces/ and apps/.
folders=""
while read -r f; do
  case "$f" in
    widgets/*/*/* | faces/*/*/* | apps/*/*/*) ;;
    *) trusted || fail "$f" "a pull request only changes files under widgets/<you>/<name>/, faces/<you>/<name>/ or apps/<you>/<name>/"; continue ;;
  esac
  top=$(echo "$f" | cut -d/ -f1)
  author=$(echo "$f" | cut -d/ -f2)
  if [ "$author" != "$login" ] && ! trusted; then
    fail "$f" "$top/$author/ belongs to @$author; put yours under $top/$login/"
  fi
  folders="$folders $(echo "$f" | cut -d/ -f1-3)"
done < <(git diff --name-only --no-renames "$base" "$head")

# The whole folder of each widget, face or app it touches, as it would be after the merge.
owls=""
apps=""
for dir in $(echo "$folders" | tr ' ' '\n' | sort -u); do
  case "$dir" in
    apps/*)
      kind=app
      # Both are installed as market-<author>-<name>.owl, so an app can't take a widget's name.
      if git cat-file -e "$head:widgets/${dir#apps/}/widget.owl" 2>/dev/null; then
        fail "$dir/app.owl" "widgets/${dir#apps/} is a widget already; give the app another name"
      fi ;;
    # A face is installed as market-face-<author>-<name>.owl, so it can share a widget's name.
    faces/*) kind=face ;;
    *) kind=widget ;;
  esac
  while read -r mode type _ path; do
    case "$path" in
      */$kind.owl|*/preview.png|*/README.md|*/previews/*.webp) ;;
      # A face's other pages, and their pictures in each theme.
      faces/*/page-[2-9].owl|faces/*/page-[1-9][0-9].owl|faces/*/screens/[0-9]*/*.webp) ;;
      faces/*) fail "$path" "a face folder holds only face.owl, page-2.owl, page-3.owl, ..., preview.png, README.md, previews/<theme>.webp and screens/<page>/<theme>.webp"; continue ;;
      *) fail "$path" "a $kind folder holds only $kind.owl, preview.png, README.md and previews/<theme>.webp"; continue ;;
    esac
    # Symlinks and submodules would publish whatever they point at.
    if [ "$type" != blob ] || [ "$mode" != 100644 ]; then
      fail "$path" "only plain files, no symlinks, executables or submodules"
      continue
    fi
    mkdir -p "$out/$(dirname "$path")"
    git cat-file blob "$head:$path" > "$out/$path"
    size=$(wc -c < "$out/$path" | tr -d ' ')
    magic=$(head -c 12 "$out/$path" | od -An -c | tr -d ' \n')
    case "$path" in
      *.png)
        [ "$size" -le 307200 ] || fail "$path" "preview.png is over 300 KB"
        case "$magic" in 211PNG*) ;; *) fail "$path" "preview.png isn't a PNG image" ;; esac ;;
      *.webp)
        [ "$size" -le 102400 ] || fail "$path" "a themed preview is over 100 KB"
        case "$magic" in RIFF*WEBP) ;; *) fail "$path" "$(basename "$path") isn't a WebP image" ;; esac ;;
      */widget.owl | */face.owl | */app.owl | faces/*/page-*.owl)
        case "$path" in apps/*) apps="$apps $path" ;; *) owls="$owls $path" ;; esac
        if git cat-file -e "$base:$path" 2>/dev/null; then
          mkdir -p "$out/base/$(dirname "$path")"
          git cat-file blob "$base:$path" > "$out/base/$path"
        fi
        # Only a new or changed file has to move off a deprecated level.
        if ! cmp -s "$out/$path" "$out/base/$path"; then
          lv=$(level "$out/$path")
          case $(echo "$levels" | awk -v l="$lv" '$1 == l { print $2 }') in
            supported) ;;
            deprecated) fail "$path" "owl $lv is deprecated: a new $kind or an update needs owl $oldest or newer (see owl.txt)" ;;
            *) fail "$path" "the store takes up to owl $(echo "$newest" | awk '{ print $1 " (launcher " $3 ")" }'), and this needs owl $lv (see owl.txt)" ;;
          esac
        fi ;;
    esac
  done < <(git ls-tree -r "$head" -- "$dir/")
  # A face's page that's gone: review says so, and that face.owl's version has to go up for it.
  if [ "$kind" = face ]; then
    while read -r _ _ _ path; do
      case "$path" in faces/*/page-*.owl) ;; *) continue ;; esac
      git cat-file -e "$head:$path" 2>/dev/null && continue
      mkdir -p "$out/base/$(dirname "$path")"
      git cat-file blob "$base:$path" > "$out/base/$path"
      owls="$owls $path"
    done < <(git ls-tree -r "$base" -- "$dir/")
  fi
done

if [ -n "$owls$apps" ]; then
  java -jar tools/owl.jar review "$out" $owls $apps --base "$out/base" || bad=1
fi

# Themed previews come from the launcher, which runs the widget to draw them: an emulator's job, after
# this review, never a phone's. In the summary, so the maintainer sees what's left before merging.
for owl in $owls $apps; do
  case "$owl" in faces/*/page-*.owl) continue ;; esac
  dir=$(dirname "$out/$owl")
  n=$({ ls "$dir/previews" 2>/dev/null || true; } | wc -l | tr -d ' ')
  if [ "$n" -lt 22 ]; then
    echo "- 🎨 \`$(basename "$dir")\` has $n of the 22 themed previews; on an emulator, render them with omarchy-proot's \`scripts/store-previews.sh <this repo> $(basename "$dir")\`"
  fi
done
# A grid row or column is a different number of dp on every phone, so a layout picked by comparing
# rows or cols leaves a gap on tall screens or cuts off on short ones. A warning, since a game board
# sized in cells can mean it.
grid='(^|[^A-Za-z0-9_.])(rows|cols)([ \t]*\?\?[ \t]*[0-9]+\))?[ \t]*([<>]=?|[=!]=)[ \t]*[0-9]|[0-9][ \t]*([<>]=?|[=!]=)[ \t]*\(?(rows|cols)([^A-Za-z0-9_]|$)'
for owl in $owls $apps; do
  [ -f "$out/$owl" ] || continue
  cmp -s "$out/$owl" "$out/base/$owl" && continue
  n=$(grep -nE "$grid" "$out/$owl" | head -1 | cut -d: -f1 || true)
  if [ -n "$n" ]; then
    echo "::warning file=$owl,line=$n::picks its layout by rows or cols; compare tileHeight or tileWidth (dp) instead, since a row's height differs by phone"
  fi
done

# The files there are, for the package check after this; a removed page isn't.
for owl in $owls $apps; do [ -f "$out/$owl" ] && echo "$owl"; done > "$out/owls.txt"
echo "files are in $out" >&2
exit $bad
