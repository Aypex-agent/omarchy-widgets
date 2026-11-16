# Omagara v1.8

Niagara-inspired OWL 21 home face for [Omalauncher](https://github.com/SimonSchubert/omalauncher). No additional packages required.

## Features

- **Alphabet:** Elastic A–Z navigation, frequently launched app previews, hide apps from the worm without hiding them from Search, optional launch-score sorting within letters, a Settings cog, optional opposite-edge input, and configurable haptics.
- **Apps:** Buffered full-height browser with elastic ends, adjustable scale, padded A–Z headings, and two compact bottom settings actions without a separate heading. Holding the cog previews only Omagara settings and Omalauncher settings. Empty Search places the most recently opened app first.
- **Notifications:** Grouped cards, optional per-app hiding (Omagara only) and alert compression, adjustable start height with automatic space recovery, optional timestamps, swipe feedback, expandable actions/replies, and native scrolling.
- **Appearance:** Clock, date and event alignment with the notification column (or screen center), automatic centering when the home alphabet is hidden, adjustable text/shade colors, opacity, and corners.
- **Settings:** Home, Clock, Apps, Alphabet, Notifications, Appearance, Holidays, and Backup; 12/24-hour time, icons, fonts, and Reduce Motion.
- **Media:** Optional compact native playback controls and expandable, user-selected music-app launch shortcuts on external audio devices.
- **Utilities:** Calculator in Search, calendar, next alarm, timer, stopwatch, and world clocks.

Slide onto the cog below the last alphabet letter (with haptic feedback) to navigate to the bottom settings menu. Select Omagara settings or Omalauncher settings there. Long-press Search still opens Omagara settings directly.

Time format is selected under **Clock** in Omagara settings; OWL does not expose Android's system format. **Home** offers two buttons to set the persistent default: Omagara (`home.home-page = 0`) or the original tile home (`home.home-page = 1`). An optional background command changes `~/.config/omalauncher/style/style.toml` without opening a terminal. Omagara displays success or failure in Home settings and saves a backup. Omalauncher Linux is required for these two buttons, not for the face itself. Separate page-navigation buttons do not change the default. World clocks appear under Clock, corner rounding under Appearance, and export/import/reset under Backup.

## v1.8 changes

- Hide apps from the alphabetical worm while keeping them accessible in normal Search. Sort apps within letters by recent launcher usage.
- Adjust notification start height automatically or manually. Hide selected apps' notifications only in Omagara, or compress repetitive alerts. Hidden notifications remain in Android's shade and are unaffected by Omagara Clear all.
- Add a compact media player with two-line song titles, fixed play/pause control and simple chevrons. Expand music-app shortcuts manually when external audio is connected.
- Align the clock, date and event with the media/notification column by default, or choose screen center. Hiding the home alphabet centers the content automatically.
- Keep left/right alphabet input independently configurable. Identify duplicate app names by icon, package ID and profile in settings.
- Preserve older settings backups and the existing notification gestures, holidays and Reduce Motion support.

## v1.7 changes

- **Shading:** Independent opacity for the clock/header, alphabet, notification headings/cards, app labels, and Search/X buttons. Theme, grey, black, white, or custom hex shade color.
- **Text:** Custom hex text colors and readable high-contrast defaults.
- **Corners:** Restored compact header and notification-card rounding, refined alphabet-worm caps, and added an all-on/all-off rounding control.
- **Gestures:** Passive L-shaped six-dot swipe hint (optional), better separation from notification scrolling, and scrollable empty footer area.
- **Controls:** Independent Left/Right placement for alphabet and Search, plus X position (follow Search, Left, or Right). X aligns with Search when placed on the opposite side.
- **Settings:** Save/export the new appearance and navigation preferences, while retaining compatibility with older backups.
- **Default-home command:** Retains the upstream v1.6.1 inline command for transparent store review.
- **Holiday Easter eggs:** Enabled by default on Halloween (Oct 31), Christmas (Dec 25), and New Year's Day (Jan 1), using the phone's local date. Tap the small decoration near Search for a one-time animation (rolling pumpkin, snowfall, or fading gold sparkle). Opening the alphabet re-arms it. Preview each holiday or turn off the feature under Holidays. Reduce Motion skips the animations.

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
