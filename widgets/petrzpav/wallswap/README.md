# wallswap

Keeps the launcher's wallpaper fresh: once a day (or as often as you like) a new image from NASA APOD,
Bing, Wikimedia Commons, Wallhaven or a folder of your own, cropped to the phone's screen. The tile is
clear, a window onto the wallpaper with its title and a next button; tap it for previous, the source
page, keep, pause, sources, the interval and a Wallhaven search.

It's the phone sibling of [omarchy-wallswap](https://github.com/petrzpav/omarchy-wallswap), the Omarchy
shell plugin. Source, the script on its own and the changelog:
https://github.com/petrzpav/omalauncher-wallswap

- Sets the wallpaper the way the Style menu does: the image goes into
  `~/.config/omarchy/backgrounds/<theme>/` as `wallswap-*.jpg` and `background` in
  `~/.config/omalauncher/style/style.toml` names it. Keep copies it there under its own name.
- HTTPS only, no redirects, size and time limits, and each source may only return images from its own
  host. Cache in `~/.cache/wallswap/`, state in `~/.local/state/wallswap/`.
- Automatic swaps wait for Wi-Fi and while Do Not Disturb or Bedtime mode is on (both switchable);
  **next** always swaps.
- Needs `curl`, `jq`, `file`, `imagemagick` and `iproute2`.
