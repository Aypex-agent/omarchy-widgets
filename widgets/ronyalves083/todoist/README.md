# Todoist for Omalauncher — beta

A community widget for your Todoist tasks. Not affiliated with or endorsed by Todoist.

## Setup

Requires Omalauncher with OWL 12 support, a Todoist account, and an internet connection. No Linux environment, terminal commands, or extra packages are required.

1. Install the widget and tap **Connect**.
2. In Todoist, open **Settings → Integrations → Developer** and copy your personal API token.
3. Paste the token into the widget's password field and submit with the keyboard.
4. Tap the list title or **⋮ → Settings** to choose your view.

The token is encrypted by Omalauncher on the phone. It is not written into `widget.owl` or included when sharing the widget. The widget sends authenticated requests only to `https://api.todoist.com`. It also reads the installed Android app list to open Todoist; if the app is absent, **Open Todoist** opens its website. Task links can open external websites when you tap them.

## Use

- Choose **Today & overdue**, **Inbox**, **Next 7 days**, or an English Todoist filter, e.g. `today & p1` or `#Work | #Personal`.
- Use `|` for OR, `&` for AND, and parentheses for grouping. Comma-separated queries are unsupported by the API endpoint.
- Tap a circle to complete a task. Recurring tasks use Todoist's close operation, which advances their next occurrence.
- Tap a title to read its full text, description, priority, and links.
- Tap **+** to add a plain-text task to Inbox. Dates and `#projects` are not parsed from its title.
- **⋮ → Refresh** requests fresh data. Sources update every minute while the widget is active.

## Personalization

**List:** view, custom filter, and optional custom name. A blank name uses the automatic title.

**Appearance:** compact/comfortable density; small/standard/large text; dates shown/hidden; and Automatic/Português/English language. Automatic uses Portuguese for Portuguese phone locales and English otherwise. Task content, custom list names, and saved filter syntax are never translated. Font and colors follow the launcher's theme.

**Account:** connect, replace the token, inspect API errors, or disconnect.

The default tile is 6×5, with a minimum of 4×4. It scrolls; large text at the minimum size intentionally shows fewer tasks. Long titles use up to three lines in the tile and can be read in the detail view.

## Limits and troubleshooting

- The API returns pages of 15 tasks. **More tasks** and **Previous** navigate them. Groups, counts, and date sorting apply to the current page, not the complete account.
- This is an online widget: no offline edit queue or cross-device local cache. A failed operation is not automatically retried; refresh before retrying an ambiguous failure to avoid duplicates.
- HTTP 429 (rate limiting) shows a translated message asking you to wait before refreshing. Read/write failures and recovery were simulated without deliberately exhausting the API quota.
- Invalid tokens and connection/API errors appear in the widget or Account section. If Inbox cannot load, check Account for the user-info request result.
- Markdown links in titles are simplified for display; this is not a full Markdown renderer. HTTPS links are offered in details.
- Icon actions have translated screen-reader labels. TalkBack was reported working in Portuguese. English TalkBack remains unverified. Widget-defined text colors were checked numerically in 22 installed palettes on solid backgrounds, and five themes were visually reviewed. Transparent wallpapers and platform-owned controls are outside that check; please report issues.
- The package preview uses demonstration tasks, not a real account.

## Contributing translations

Contributions and corrections are welcome through the [widget store repository](https://github.com/SimonSchubert/omarchy-widgets).

The `translations` map inside `widget.owl` contains matching `pt` and `en` catalogs. Copy all keys when proposing another language, preserve literal placeholders such as `${query}`, and update language selection, locale mapping, and date formatting. Filter values stay in English. Never translate task content or include a token or personal tasks in a contribution. Run `owl-check` and inspect both tile and screen previews, including 4×4 and large text.

License: MIT, as declared in the widget metadata.

---

## Português

Widget comunitário, sem vínculo oficial com o Todoist. Funciona pelo Android, sem Linux ou pacotes adicionais. Requer Omalauncher com OWL 12, internet e uma conta Todoist.

Toque em **Conectar** e cole seu token de **Configurações → Integrações → Desenvolvedor** no campo protegido. Ele fica criptografado no celular e não acompanha o arquivo compartilhado.

Em **Lista**, escolha a visualização e um nome opcional. Em **Aparência**, ajuste idioma, densidade, texto e datas. Em **Conta**, gerencie a conexão. Os filtros usam inglês, mesmo com a interface em português. Use o círculo para concluir, o título para ver detalhes e **+** para adicionar texto simples à Caixa de entrada.

A lista carrega 15 tarefas por página; agrupamentos e contagens são da página atual. Não há fila de alterações offline. O modo compacto e o tamanho pequeno preservam o visual original; tamanhos maiores podem exigir rolagem. O TalkBack foi validado pelo usuário em português; em inglês, permanece sem teste.

Novas traduções e melhorias são bem-vindas no repositório da loja. As traduções ficam no mapa `translations` do arquivo. Preserve os marcadores e não inclua credenciais nem tarefas pessoais.
