# Omagara v1.6

Niagara-inspired OWL 21 home face for [Omalauncher](https://github.com/SimonSchubert/omalauncher). No additional packages required.

## Features

- **Alphabet:** Elastic A–Z navigation with app previews biased toward frequently launched apps (less aggressively near A), a letter-sized Settings cog in the shaded worm tail, distance/speed-sensitive wiggle, optional opposite-edge input, and configurable haptics.
- **Apps:** Buffered full-height browser with elastic ends, adjustable scale, padded A–Z headings, and two compact bottom settings actions without a separate heading. Holding the cog previews only Omagara settings and Omalauncher settings. Empty Search places the most recently opened app first.
- **Notifications:** Compact grouped cards with consistently aligned optional timestamps, magnetic swipe feedback, expandable actions/replies, native list scrolling, bottom clearance, and matching rubber-band rebound when pulling the top header or bottom footer.
- **Appearance:** Connected, content-fitted shade for the clock, date, and event, with theme-aware alphabet, notification, and app-label shades. Optional shading and independent corner rounding.
- **Settings:** Seven clear tabs: Home, Clock, Apps, Alphabet, Notifications, Appearance, and Backup. All controls appear directly under their tab, with no nested expanders. Manual 12-hour/24-hour format (24-hour default), text colors, contrast, icons, fonts, and Reduce Motion.
- **Utilities:** Calendar, next alarm, timer, stopwatch, and world clocks.

Slide onto the cog below the last alphabet letter (with haptic feedback) to navigate to the bottom settings menu. Select Omagara settings or Omalauncher settings there. Long-press Search still opens Omagara settings directly.

Time format is selected under **Clock** in Omagara settings; OWL does not expose Android's system format. **Home** offers two buttons to set the persistent default: Omagara (`home.home-page = 0`) or the original tile home (`home.home-page = 1`). An optional background command changes `~/.config/omalauncher/style/style.toml` without opening a terminal. Omagara displays success or failure in Home settings and saves a backup. Omalauncher Linux is required for these two buttons, not for the face itself. Separate page-navigation buttons do not change the default. World clocks appear under Clock, corner rounding under Appearance, and export/import/reset under Backup.

## v1.6 changes

- **Clock:** Added manual 12-hour and 24-hour display (24-hour default) for the home clock, alarms, calendar, and world clocks. Removed the unsupported System option; older System preferences import as 24-hour.
- **Notification timestamps:** Added a show/hide toggle and formatting that follows Omagara's clock choice.
- **Notification alignment:** Reserved the expand arrow's 44dp slot so timestamps stay put for both expandable and ordinary notifications.
- **Notification pull:** Added matching 64dp rubber-band resistance and 240ms rebound at the header and scroll footer, respecting Reduce Motion. Native scrolling and swipe actions remain intact.
- **Settings layout:** Replaced the long settings page with Home, Clock, Apps, Alphabet, Notifications, Appearance, and Backup categories. Added clear ON/OFF states, selected options, and live clock-format examples.
- **Settings navigation:** Removed nested expanding menus. World clocks live under Clock, corner rounding under Appearance, and import/export/reset under Backup.
- **Default home:** Distinguished temporary page navigation from the persistent Omagara (page 0) or original tile home (page 1) setting.
- **Default-home actions:** Replaced clipboard-only and full-screen terminal controls with optional background updates to `style.toml`, backup creation, and in-page success/error feedback. Omalauncher Linux is required only for those actions.

## Limitation

OWL animations are capped at 60 FPS, including on 90/120 Hz displays. Higher frame rates require an Omalauncher engine change.
