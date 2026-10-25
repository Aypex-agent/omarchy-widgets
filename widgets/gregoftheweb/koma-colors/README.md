# kOMA colors

The kOMA Colors panel widget from [kOMA-desktop-theme](https://github.com/gregoftheweb/kOMA-desktop-theme), for the launcher.
A 1x1 tile with the four palette dots; tap it to pick Tron Aqua, McLaren, Ferrari or Lambo, or the theme's own color.

Picking a color sets the current theme's accent (highlights, titles, the focused outline, check marks) and the
widgets' borders. Nothing else changes: wallpaper, background and text stay the theme's.

How: the stock theme is left as it is. The widget copies it to `~/.config/omarchy/themes/<theme>-koma-<rrggbb>`
with the new accent, switches `theme` in `~/.config/omalauncher/style/style.toml` to that copy, and sets
`[widgets] border` there to the color. **theme default** switches back and removes both; only the copy in use is
kept. Needs Linux; uses only base tools (bash, awk, sed, coreutils).

MIT licensed.
