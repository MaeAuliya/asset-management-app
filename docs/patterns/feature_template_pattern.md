# Feature Template Pattern

## Goal
Keep every feature aligned to the repository's intended Clean Architecture template.

This pattern works together with `core_modules_pattern.md`.

## Source of Truth
- Auth reference: `lib/src/features/auth/`
- App shell reference: `lib/src/features/app_shell/`
- Shared logic rule: `lib/src/core/modules/` is reserved for real reusable modules only
- This file is mandatory. Do not choose a flatter or alternate structure unless the docs are updated first.

## Required Feature Structure
Each feature should follow this folder shape unless there is a repo-approved reason not to:

```text
feature_name/
  data/
    datasources/
    models/
    repositories/
  domain/
    entities/
    repositories/
    usecases/
  presentation/
    bloc/
    providers/
    screens/
    views/
    widgets/
    shimmer_views/   # optional
```

Shared cross-feature logic does not belong here. Put reusable `data + domain` code in `lib/src/core/modules/`.

## Responsibilities

### `data/`
- Data sources talk to local or remote services.
- Models map raw data into domain-safe structures.
- Repository implementations bridge data sources to domain repositories.

### `domain/`
- Entities hold business-safe values.
- Repository interfaces define the feature contract.
- Use cases expose feature operations to presentation.
- Domain repositories use `ResultFuture` / `ResultVoid`, not raw `Future`.

Feature domain code should stay feature-local unless it is reused by more than one feature. Reusable domain/data logic should be promoted into `core/modules`.

### `presentation/bloc/`
- Bloc owns async work, use case execution, event handling, and emitted flow states.
- Events and states stay explicit and feature-specific.
- Side-effect-driving states such as success, error, or navigation trigger are emitted here.
- Bloc calls feature-local use cases or shared module use cases directly.
- Bloc handlers do not call repositories or datasources directly.

### `presentation/providers/`
- Provider is a lightweight binder for view-consumed state.
- Provider stores presentation values that the view reads repeatedly, such as selected data, formatted display state, or locally cached feature values.
- Provider does not replace Bloc for async/domain flow.

### `presentation/screens/`
- Screen is the entry point for the feature route.
- Screen owns lifecycle methods such as `initState`.
- Screen dispatches initial bloc events.
- Screen resets or initializes provider state.
- Screen owns `BlocListener` and route-level navigation or snack bar reactions.

### `presentation/views/`
- View renders the screen body.
- View stays focused on presentation composition.
- View reads provider state and dispatches simple UI-triggered bloc events.
- View should not take over route lifecycle or feature startup responsibilities.
- View should prefer `context.theme`, `context.widthScale`, `context.heightScale`, and other existing context helpers instead of raw theme or sizing access.
- View should prefer `CoreText` and existing `Core*` widgets in presentation code.

### `presentation/widgets/`
- Reusable pieces for the feature view.
- Widgets should stay small and presentation-focused.
- Extract helper UI here instead of creating private helper classes inside screen or view files.

### `presentation/shimmer_views/`
- Optional loading placeholders for asynchronous screens.
- Use when the feature needs layout-stable loading UI.

## Canonical Flow
The expected presentation chain is:

`Screen -> BlocListener/init -> Provider binder -> View -> Widgets/Shimmer`

Reference:
- `SplashScreen` dispatches the startup bloc event and owns route navigation reactions.
- `AuthEntryScreen` owns form lifecycle and sign-in listener side effects.
- `AppShellView` renders shell presentation while `UserShellScreen` and `AdminShellScreen` remain route entries.

## Rules
1. New features should start from this structure, not from a flatter custom structure.
2. Do not collapse `screen` and `view` responsibilities into one widget for normal feature screens.
3. Do not move async/domain flow into providers.
4. Do not use provider as a replacement for Bloc.
5. Add `shimmer_views` only when the feature has a real loading state that benefits from skeleton UI.
6. If logic will be integrated by more than one feature, move it into `lib/src/core/modules/` instead of duplicating it across features.
7. Do not keep presentation helper classes as private same-file widgets when they can live in `views/` or `widgets/`.
8. Do not bypass use cases from bloc handlers.

## Reference Baseline
Use the refactored `auth` and `app_shell` features as the living baseline for this pattern.
