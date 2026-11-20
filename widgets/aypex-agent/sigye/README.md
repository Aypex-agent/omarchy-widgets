# sigye

[sigye](https://github.com/am2rican5/sigye) (MIT), the animated terminal clock with FIGlet fonts, color
themes and backgrounds, live in a home tile that sizes its font to fit the tile. Tap the tile for the full
screen: sigye itself, in any of its modes (clock, pomodoro, timer, stopwatch, world clock, countdown), with
buttons for its keys (start/pause, reset, skip, lap, ±1 minute, previous/next event, and arrows, Enter, Esc and
a box to type into its dialogs), so you don't need the keyboard, and every setting under it as buttons: font, color, animation, background, 12/24 hour, seconds, pomodoro and
timer lengths, and world clock zones.

## Before you install it: please read

**sigye is downloaded.** It isn't in Arch's package repositories, so this widget can't declare it in
`requires`. Until sigye is on the PATH (`~/.local/bin` counts), the tile asks you to set it up, and the
screen's **install sigye 0.7.0** button:

1. downloads the official v0.7.0 release for the phone's architecture (aarch64 or x86_64) from
   `https://github.com/am2rican5/sigye/releases/download/v0.7.0/`, over HTTPS only;
2. checks it against the SHA-256 checksum written into the widget, and stops if it doesn't match;
3. extracts the one `sigye` program to `~/.local/bin/sigye`.

The install downloads and runs nothing else, and nothing happens until you tap the button. Downloading the
release was the best option we had: sigye isn't packaged for Arch (it's in the AUR, which `requires` can't use), and building
it from source with cargo takes a long time and a lot of battery on a phone. **If you're at all concerned
about it, have your agent tear this widget apart before you install it.** Every command is in the one file.

**Expect more battery use than a plain clock.** sigye redraws all the time while it runs. Measured on one
phone, the tile's sigye used about 5–20% of one CPU core while the phone was awake (Android pauses it while
the phone sleeps). The "time only" tile view uses the least.

## What it runs and writes

- **The tile:** sigye with a copy of its config in `~/.cache/sigye-owl/tile/`, so the tile's own view (time
  only, or time, date and background) never changes your config.
- **The screen:** sigye in the mode you pick, inside its own tmux session (socket `sigye-owl`, session
  `screen`), so the buttons can press its keys with `tmux send-keys`. The session ends with the screen's
  terminal. tmux adds a little CPU of its own while the screen's clock runs. The launcher keeps a screen's terminal running after the screen
  closes, so a small background loop ends that copy about a minute after you leave home or lock the phone
  (it watches `~/.cache/sigye-owl/beat`, which the widget touches every 15 seconds while it's showing). A
  screen opened in pomodoro, timer or stopwatch is left running, so it doesn't lose its time.
- **Settings** go into sigye's own `~/.config/sigye/config.toml` through a Python command that only writes
  the keys and values the buttons offer, one edit at a time. It never writes sigye's hook commands
  (`on_complete`, `on_start`, `on_break`) and keeps every other setting, countdown events included. It does
  write the file anew, so comments in it are lost; a symlinked config.toml stays a symlink. A config it can't
  read or rewrite is left alone, with a message saying why. Changing a setting restarts the screen's sigye,
  which resets a running pomodoro or timer.
- **The network:** besides the one-time install, sigye itself goes online only with the **Weather (live)**
  background, which fetches the weather from `wttr.in` every so often. With no city set, wttr.in works out
  where you are from your connection.

Files it writes: `~/.local/bin/sigye` (only when you tap install), `~/.config/sigye/config.toml` (when you
change a setting) and an empty `~/.config/sigye/.owl-lock` beside it, and `~/.cache/sigye-owl/` (the tile's
config copy, `beat` and `screen.ends`).

Needs Linux, and the packages `python`, `curl`, `tar`, `gzip`, `tzdata` and `tmux`.
