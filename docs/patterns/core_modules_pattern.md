# Core Modules Pattern

## Goal
Use `lib/src/core/modules/` for reusable business logic that will be integrated by more than one feature.

## Source of Truth
- Structural reference: `lib/src/core/modules/`
- Supporting rule: feature `Bloc` may call module use cases directly

## What Belongs In `core/modules`
Put code in `core/modules` when:
- the same domain/data logic is needed by multiple features
- extracting it reduces duplicated repositories, models, entities, or use cases
- the code is not tied to one feature's presentation layer

Do not use `core/modules` for:
- screen-specific UI state
- route-specific presentation code
- feature-only widgets, views, screens, blocs, or providers

## Required Module Structure
Each module should follow this structure:

```text
module_name/
  data/
    datasources/
    models/
    repositories/
  domain/
    entities/
    repositories/
    usecases/
```

## Hard Rule
`core/modules` is `data + domain` only.

Do not add:
- `presentation/`
- `screens/`
- `views/`
- `widgets/`
- `providers/`
- `bloc/`

Presentation stays in `lib/src/features/`.

## Integration Rule
The integration point is the feature `Bloc`.

Expected usage:
1. Shared logic is implemented in `core/modules`.
2. A feature `Bloc` receives the module use case through dependency injection.
3. The `Bloc` calls the use case directly.
4. The feature `Provider` remains a binder for view state.
5. The feature `View` and `Screen` stay focused on presentation.

## Responsibilities

### `data/`
- Shared data sources for logic reused by multiple features
- Shared models and repository implementations

### `domain/`
- Shared entities
- Shared repository contracts
- Shared use cases consumed by feature blocs

## Decision Rule
- If logic is used by one feature only, keep it inside that feature.
- If logic will be used by more than one feature, promote it into `core/modules`.
- If the code contains presentation concerns, it does not belong in `core/modules`.

## Example Intent
A feature `Bloc` should depend on a module use case instead of duplicating the same use case in multiple features.

That keeps:
- shared business/data logic in `core/modules`
- feature composition and presentation in `features`
- boilerplate lower across the repo
