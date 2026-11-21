# Todoist for Omalauncher — 0.7.1 beta

A community Todoist widget for Omalauncher. Not affiliated with or endorsed by Todoist.

> **Beta scope: one fixed Todoist account.** This release improves everyday list use and local state handling; it does not claim complete cross-device synchronization. Read the known limitations below before relying on write actions.

## Requirements and setup

Requires **OWL 17 support** (Omalauncher 0.16.0 or newer), a Todoist account and an internet connection. No guest Linux setup, shell commands or extra packages are required.

1. Install or update the widget through the store, then open **Account**.
2. In Todoist, open **Settings → Integrations → Developer** and copy your personal API token.
3. Paste it only into the widget's password field and submit with the keyboard.
4. Use the list title or **⋮ → Settings** to configure the view.

Keep the existing widget when updating. Do not delete it, disconnect the account or reinstall Omalauncher as an update procedure. An update can request approval again because this release has a different command/language surface from 0.5.1.

## What's new in 0.7.1 (since 0.7.0)

- **Priority order:** within each section, higher-priority tasks come first. Overdue and Upcoming sort by day, then priority (P1 first), then time; Today and No date sort by priority, then time.
- **Six new UI languages:** French, Japanese, Russian, Turkish, Ukrainian and Italian, following the launcher language. Filters typed in French, Japanese, Russian, Turkish and Italian were checked against Todoist; Todoist does not interpret Ukrainian filters, so Ukrainian uses English filters, explained next to the filter field, as Indonesian does.

## What's new since 0.5.1

- **Filters:** local named shortcuts, independent removal and Undo; saved queries retain their interpretation language.
- **Languages:** native English, Portuguese, Spanish, German, Simplified Chinese, Indonesian, French, Japanese, Russian, Turkish, Ukrainian and Italian UI, with English fallback. New filters follow the supported UI language; Indonesian and Ukrainian filters use English, as explained next to that field.
- **Task context and presentation:** optional projects, labels and times; fixed priority-circle colors; cleaner settings; compact/comfortable spacing and text sizes.
- **Complete supported result sets:** one API response of up to 200 tasks, sorted (section, day, priority, time) before local pages of 30. Partial/continued results are hidden rather than presented as complete. Pull to refresh joins the menu action.
- **Local correctness:** details read the current local task, removed/changed occurrences invalidate old completion controls, replies preserve newer drafts and selections, and replies from a prior account session do not overwrite the new session's local feedback.

These are local corrections, not a claim of atomic writes against changes made in another Todoist client.

## Everyday use

- Choose **Today & overdue**, **Inbox**, **Next 7 days**, or a custom filter. Use `|`, `&` and parentheses; the API endpoint does not support comma-separated query lists.
- Save a custom query with an optional name. Removing a local shortcut does not delete any Todoist account filter; Undo restores the shortcut.
- Tap a task title for details and a priority circle to complete it. Priority is shown by circle color, without an extra priority label in the list.
- Tap **+** to create a plain-text task in Inbox. Dates and `#projects` are not parsed from its title.
- Pull the list or use **⋮ → Refresh** to request an update. Sources poll while the widget is active; refreshing does not itself prove that an uncertain write failed or a reopened task has been reconciled.

Appearance settings independently control projects, labels, dates and times. The default tile is 6×5, minimum 4×4; large text can require more scrolling. Long titles can be opened in details.

## Known limitations — accepted beta boundaries

1. **Account switching is not supported by this beta's operating scope.** Use one fixed account. Do not use **Replace token** to switch to a different account: old tasks or in-flight reads can remain visible, and an action can target an old task with the new credential. The controls are not an enforced security boundary. Updating credentials is not a guarantee that retained reads were isolated.
2. **Reopening a completed task can leave it hidden locally**, even when it appears in the API response. Refresh does not reliably remove that local mask. Use Todoist itself to view/manage a reopened task; do not treat a missing widget row as proof that it is completed or absent.
3. **An unconfirmed write is not a confirmed failure.** The server may have accepted it even if the reply was lost. Check the task in Todoist before repeating a creation or completion. There is no offline write queue, automatic retry or idempotent retry guarantee in this release.
4. **Other-client changes are not atomic with widget actions.** A shared or recurring task can change remotely while old local data is visible. The detail/occurrence guards reduce local stale-control errors, but do not provide a server-side conditional completion.
5. **Narrow large filters.** If the API reports continuation or more than 200 tasks, the widget hides the partial list and asks for a narrower query. Local pagination does not fetch more remote batches.

The experimental Sync creation flow with a persistent pending-creation lock is **not included**. This release therefore does not strand new creations behind that experimental lock, but it retains the unconfirmed-write limitation above.

For deadlines or operations where a missed/duplicate action would matter, use the official Todoist app and verify its result there. Neither the beta label nor this notice fixes the documented limitations.

## Privacy and dependencies

The token is encrypted by Omalauncher on the phone. It is not embedded in `widget.owl` or exported with the shared widget. Authenticated widget requests go directly to `https://api.todoist.com`; there is no intermediary service operated by the widget author.

The widget reads the installed Android app list locally to find Todoist for **Open Todoist**. It does not send that app list to Todoist. Task links and help/settings buttons can open websites when tapped. No shell programs, guest packages or analytics endpoints are declared by this widget.

## Verification and previews

Release checks cover the official store checker/reviewer, OWL evaluator actions, the pinned official JVM runtime with simulated network/peripheral services, state migration and the official sharing codec. They do not establish new Android rendering, touch, keystore or live Todoist validation for 0.7.1. Earlier device checks are not described as a full test of this release.

The existing store previews are retained as **legacy demo illustrations**, not newly captured screenshots of 0.7.1; some colors and details may differ. No token or real-account task is shown in the demo preview. Translations are model-assisted contributions with cross-review by a second model; there was no native-speaker review in any language.

## Contributing

Changes belong at `widgets/<your GitHub username>/<name>/` according to the store's ownership rules. For this widget, propose changes through the [store repository](https://github.com/SimonSchubert/omarchy-widgets).

Translations use OWL's native `strings` blocks in `widget.owl`, not the older custom `translations` map. Preserve keys, function parameters and interpolation markers. Never translate user task content, project names, label names or saved filter expressions, and never include a personal token or task data in a contribution.

License: MIT, as declared in the widget metadata.

---

## Português

**0.7.1 beta para uma conta fixa**, com OWL 17 (Omalauncher 0.16.0 ou posterior). Atualiza filtros salvos, idiomas, contexto das tarefas, paginação local e configurações; incorpora os consertos locais de detalhes, rascunhos e respostas antigas. Novidades da 0.7.1: tarefas de maior prioridade aparecem primeiro dentro de cada seção, e a interface ganhou francês, japonês, russo, turco, ucraniano e italiano (traduções por modelo, sem revisão de falante nativo).

Atualize a instância existente pela mesma origem de instalação, sem apagá-la ou desconectar a conta. Cole o token somente no campo protegido do aplicativo. A instalação compartilhada e a instalação da loja têm identidades diferentes: importar um compartilhamento não atualiza automaticamente a instância da loja.

Limitações: não trocar de conta nesta beta; tarefas reabertas podem continuar ocultas; falha de rede não prova que uma criação/conclusão foi recusada. Confira no Todoist antes de repetir uma ação incerta. Não há fila offline, retentativa idempotente nem o bloqueio experimental de criação. A proteção dos detalhes se limita aos dados locais, sem operação atômica contra mudanças em outro aparelho.

Para operações críticas, use o aplicativo oficial. As verificações automatizadas não substituem homologação Android desta versão; as imagens da loja são ilustrações de demonstração preservadas da versão anterior.
