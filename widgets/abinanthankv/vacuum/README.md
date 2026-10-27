# vacuum

A Xiaomi robot vacuum tile for [Omalauncher](https://github.com/SimonSchubert/omalauncher).
It talks to the robot directly over your own Wi-Fi for status and control, and reads
the robot's floor plan from the signed Xiaomi map blob so the rooms can be tapped and
cleaned individually.

**This widget does not contain an account, a token, an address or a floor plan.** The
config and all map data are created on the phone at runtime.

## What it shows

- battery, charging state and the current cleaning mode
- start, stop, dock, locate, sweep-only, sweep + mop, and mop
- suction, water and mop-route settings
- a drive pad for manual movement
- the robot's floor plan, room names, cleaned path, charger and live pose
- per-room selection, then a room clean; or clean everything
- Mi account login from the setup tab, only when a new cloud map is needed

## Requirements

- `python` and `openssl` on the phone
- the robot and the phone on the same LAN
- the robot's 32-character miIO token

`requires` installs `python`, `openssl` and `ca-certificates` if they are missing.

## First run

The widget creates a config on first run:

```sh
~/.config/omarchy-proot/vacuum
```

```ini
ip = auto
token = PASTE-THE-32-HEX-TOKEN-HERE
did = auto
```

Open the tile and use the **setup** half to paste the token. Leave the address as
`auto`; the widget sweeps the local `/24` once and remembers what it finds. The robot
ignores broadcast discovery, so this unicast sweep is the discovery route used here.

The file is written with mode `600`. The token is never put in the widget, the store
listing or a log line.

### Getting the token

The robot never returns its token over the LAN. Get it once from the Xiaomi cloud or
from a Mi Home backup, using any Xiaomi token extractor, then paste it into setup. The
token is per device and does not rotate on its own.

## Floor plan

Status and control stay on the LAN. The floor plan is the one part that needs the
account: Xiaomi stores the map blob behind a signed URL. Tap **log in** in setup, then
**fetch**. The widget decrypts the blob locally, crops it to the plan, and writes the
resulting geometry to:

```sh
~/.cache/omarchy-vacuum/map.json
```

and the floor plan itself as a picture beside it:

```sh
~/.cache/omarchy-vacuum/plan-<stamp>.png
```

That picture is drawn from the robot's own grid on the phone: walls, doorways, the real
room shapes and the cells it has already cleaned, in the theme's room colours. Nothing
is rendered by a server, and no imaging library is installed — the PNG is written with
`zlib`, which Python already has. The map tab shows it at the plan's own proportions
with the room names, the cleaned path and the two poses over it. After a widget update
the cached blob is re-decoded once and the picture redrawn by itself; `mapdata --refit`
does the same from the command line.

The Mi password itself is not written to disk. During a login step the widget keeps
temporary state in `~/.config/omarchy-proot/vacuum-login.json` (mode `600`), including a
password hash needed for the Mi challenge; it is removed when login completes. The
resulting account session is stored at `~/.config/omarchy-proot/vacuum-session.json` with
mode `600`, because the signed map URL is account-wide. Delete that file to sign out.

If you already render a map picture on a computer, `map_url` can point at that PNG
instead. This is optional and does not affect LAN control.

## Notes

- Room clean uses the robot's `7/3` action with the room ids from the map.
- The map is read-only; cleaning only starts when you tap a control.
- The widget is tested against the `ijai.vacuum` family. Other models may expose a
  different room list or map schema.
- No cloud account is needed for status, manual control or cleaning. The account is
  only used to download the signed map blob.
