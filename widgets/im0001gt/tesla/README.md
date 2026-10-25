# Tesla

Read-only home tile for a Tesla. It shows battery, range, lock, climate, tires, and the charge limit. A parked car is left alone for 15 minutes, and the tile never sends a wake request.

The picture is a made-up car named Bluebird, parked at 54% with an 80% charge limit. It is sample data for the store listing.

## Sign in

The tile needs a refresh token from [Tesla Auth](https://github.com/adriankumpf/tesla_auth/releases/latest). That token covers the whole Tesla account. Sign in on Tesla's own page, on a computer, or with the optional phone helper from the [project page](https://github.com/IM0001GT/omalauncher-tesla). Paste the refresh token into the tile. It is stored only at `~/.config/omarchy-tesla/refresh-token` (mode 600).

The first numbers wait until the car is already awake. Refresh asks for one new reading only when the car is already awake.

Copying the phone, or restoring a backup, does not bring `~/.config/omarchy-tesla/refresh-token`. The tile then says **no key** instead of looking offline. **Reset key** deletes the refresh token, the access token, and its expiry on this device only. It does not wake the car, and it does not remove a key that is still paired on the car. After that, paste a new refresh token.

Miles or kilometers, Fahrenheit or Celsius, and psi or bar follow the car's own settings. Model 3, Y, S, X, Cybertruck, and Semi names are translated when Tesla sends a known type, and the raw trim code stays after a dash. Several cars on one account can be picked from the detail screen.

## What the review will flag

Build on this file's `owl: 6`. Before the 1.5 update was approved, the launcher owner said the store review rejects a command built from widget values unless each value is `${sh(value)}`, outside any quotes. `sh()` keeps the value one shell word, so it cannot break out and run as code. A widget that fails that check is left out of the store. The VIN picker already passes the VIN that way. The new key check and the reset command are fixed shell text, with no widget values in them. Future changes need the same `sh()` form, and launchers older than 0.6.0 show "needs a newer launcher" until they update.

The status command is the whole reader, inlined so the tile works on its own. Three warnings are expected:

- `openssl base64 -d` reads the refresh token's issuer claim, and only that claim, to choose Tesla's China servers or the global ones. It does not decode a downloaded program.
- `chmod 700` is on the config and cache directories, so only the owner can read the token. `chmod 755` is on `~/.local/bin/tesla-status` so the tile can run it. The token file itself is mode 600.
- Choosing a car builds one command at runtime. It writes a VIN that already matched 17 letters and digits (no I, O, or Q) into `~/.config/omarchy-tesla/which`, then touches `~/.cache/omarchy-tesla/force`. The reader checks that pattern again before using the VIN. Refresh only creates that force file.

Packages: curl, jq, openssl. The tile installs `~/.local/bin/tesla-status` itself, so that name is not an Arch package.

## License

MIT
