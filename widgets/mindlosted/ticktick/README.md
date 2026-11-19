# TickTick

Your TickTick tasks on the home screen: grouped by date (Overdue, Today,
Tomorrow, then by day), with priority bars, filter chips, quick add, and
tap-to-complete. Tapping a task opens it in the TickTick Android app.

## Setup

1. In TickTick, generate a Personal API Token (Settings → Account → API
   Token / Developer).
2. Paste it into the widget's setup screen. The token is stored as an OWL
   `secret`: encrypted by the launcher, kept on this phone only, and sent
   only to `api.ticktick.com` in the `Authorization` header. Sign Out
   forgets it.

No Linux packages are needed — all API calls go through the launcher's own
`http()` / `post()`, so the widget also works before Linux is installed.

## How it syncs

- Inbox refreshes every 3 minutes; the project list every 10.
- TickTick's open API has no "all tasks" endpoint, so the widget walks the
  project list one project every 2 seconds and merges the tasks. A manual
  refresh (↻ or pull) starts a new walk. Tasks are matched to projects by
  `projectId`, so a slow answer still lands in the right list.
- Completing and adding go out as soon as you tap; on success the sources
  refresh. A failed write shows its HTTP code instead of failing silently.

## Notes

- "Today" chip counts today + overdue, as the list groups them.
- Demo mode (button on the setup screen) shows sample tasks without an
  account; that is what the store preview shows.
- Community integration, not affiliated with TickTick.
