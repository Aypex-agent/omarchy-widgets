# wallswap

Keeps the launcher's wallpaper fresh: once a day (or as often as you like) a new image from NASA APOD,
Bing, Wikimedia Commons, Wallhaven or a folder of your own, in the phone or in Linux, cropped to the
phone's screen. The tile shows the image's title and a next button on the same glass as home's other
tiles, at any size down to 1x1; tap it for previous, the source page, keep, pause, sources, the
interval, a Wallhaven search and a folder picker.

It's the phone sibling of [omarchy-wallswap](https://github.com/petrzpav/omarchy-wallswap), the Omarchy
shell plugin. Source, the script on its own and the changelog:
https://github.com/petrzpav/omalauncher-wallswap

- Sets the wallpaper the way the Style menu does: the image goes into
  `~/.config/omarchy/backgrounds/<theme>/` as `wallswap-*.jpg` and `background` in
  `~/.config/omalauncher/style/style.toml` names it. Keep copies it there under its own name.
- HTTPS only, no redirects, size and time limits, and each source may only return images from its own
  host. Cache in `~/.cache/wallswap/`, state in `~/.local/state/wallswap/`.
- The phone folder (`Pictures/Wallpapers` unless you pick another) is read through the launcher's
  phone folders, `omalauncher ls` and `get`: allow `Pictures` in the launcher's settings, under
  permissions. The Linux folder (`~/Pictures/Wallpapers`) works the same. Each takes turns: every
  image once, in random order, before any comes round again. The folder button on their rows picks
  the folder.
- Automatic swaps wait for Wi-Fi and while Do Not Disturb or Bedtime mode is on (both switchable);
  **next** always swaps. With only the folders on, nothing waits for Wi-Fi.
- Offline, automatic swaps try again every 10 minutes and the tile says so; **next** shows an image
  already cached. A swap uses the network for at most 15 seconds, and a download cut short by a slow
  connection goes on where it stopped at the next swap.
- Needs `curl`, `jq`, `file`, `imagemagick` with `libjpeg-turbo` and `libwebp`, `iproute2`, `findutils`
  and `util-linux`.
