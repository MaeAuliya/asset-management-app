# Patterns

This folder is the source of truth for implementation consistency rules.

It is binding implementation policy. If code and `docs/patterns/` differ, the implementation is wrong until the code is corrected or the pattern docs are intentionally updated first.

## Current Patterns
- `core_modules_pattern.md`: reusable cross-feature `data + domain` modules under `lib/src/core/modules/`.
- `feature_template_pattern.md`: canonical feature folder and presentation structure based on the refactored `auth` and `app_shell` features.
- `presentation_flow_pattern.md`: standard `Screen -> BlocListener/init -> Provider binder -> View -> Widgets/Shimmer` flow.
- `context_access_pattern.md`: typed `BuildContext` access for Bloc and Provider.
- `bloc_inheritance_pattern.md`: superclass/subclass Event-State pattern for Bloc.
- `presentation_state_ownership_pattern.md`: state ownership rules inside the feature template pattern.

## Usage Rule
Before adding or refactoring implementation code, read the relevant pattern file here and follow it.

Mandatory architecture rules:
- `Bloc` handlers call use case classes, not repositories or datasources.
- Domain repositories return `ResultFuture` / `ResultVoid`.
- Datasources may use plain `Future`.
- `Bloc` event/state flow uses inheritance-based classes, not a single state object with a status enum.

Baseline presentation style:
- use `context.theme`, `context.textTheme`, `context.colorScheme`, `context.widthScale`, and `context.heightScale`
- prefer `CoreText` and existing `Core*` widgets before raw Flutter widgets
- do not keep helper UI as private classes inside a large file; move it to `views/` or `widgets/`

Start with:
1. `core_modules_pattern.md`
2. `feature_template_pattern.md`
3. `presentation_flow_pattern.md`
4. `context_access_pattern.md`
5. more specific pattern files as needed

## Maintenance Rule
When adding a new `Bloc` or `Provider`:
1. Add typed accessors to `lib/src/core/extensions/context_extension.dart`.
2. Use only those typed accessors in presentation code.
3. Update `context_access_pattern.md` with the new accessor names.

## Reference Baseline
Use the refactored `auth` and `app_shell` features as the current living reference for these patterns.
