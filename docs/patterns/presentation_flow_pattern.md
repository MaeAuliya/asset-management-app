# Presentation Flow Pattern

## Goal
Keep feature presentation predictable by separating route lifecycle, async flow, binder state, and rendering.

This flow assumes shared reusable logic may come from `lib/src/core/modules/`, while presentation stays inside `lib/src/features/`.

## Standard Flow
Use this flow for feature presentation:

1. `Screen` enters from the router.
2. `Screen` initializes provider state if needed.
3. `Screen` dispatches the initial bloc event in `initState`.
4. `Screen` owns `BlocListener` for snack bars, navigation, and side effects.
5. `View` renders the screen body.
6. `View` reads provider state and dispatches user-triggered bloc events.
7. `widgets/` holds smaller reusable presentation pieces.
8. `shimmer_views/` holds optional loading placeholders.

## Screen Rules
- Use `StatefulWidget` when lifecycle hooks are needed.
- Initialize provider state in `initState` when the feature needs a fresh binder state.
- Dispatch startup events from the screen, not from the view.
- Keep route-level side effects in `BlocListener`.

## View Rules
- Views should be presentation-first and route-agnostic.
- Views can use `Consumer`, typed provider accessors, and typed bloc accessors.
- Views should not own startup event dispatch for the feature.
- Views should not own route navigation side effects that depend on bloc state changes.
- Views should use existing `BuildContext` helpers for theme and sizing.
- Views should prefer `CoreText` and existing `Core*` widgets over raw Flutter presentation primitives when equivalents already exist.

## Bloc vs Provider
- Use `Bloc` for:
  - async work
  - use case execution
  - calling feature-local or shared module use cases
  - error/success/loading flow
  - side-effect-driving state
- Use `Provider` for:
  - display-ready values read repeatedly by the view
  - selection/filter/form binder state shared across widgets in the same feature
  - simple UI state that belongs to the feature presentation layer
- Use `ValueNotifier` only for tightly local widget state that does not deserve a feature provider.

## Example Pattern
From the refactored `auth` and `app_shell` features:
- `SplashScreen` dispatches the startup event in `initState`
- `SplashScreen` listens for route decisions and navigates accordingly
- `SplashView` renders the startup body only
- `AuthEntryScreen` owns form lifecycle and listens for sign-in completion
- `AuthEntryView` renders the form and forwards user actions
- `UserShellScreen` and `AdminShellScreen` remain route entries while `AppShellView` renders the shell UI

When the same business logic is needed by multiple features:
- move that logic into `lib/src/core/modules/`
- inject the module use case into each feature bloc
- keep the screen, view, provider, and widgets inside the feature

Handler rule:
- each bloc handler should call the matching use case class for that behavior
- handlers fold `Either` into left/right state emissions
- handlers do not call repositories or datasources directly

When a presentation file starts growing multiple helper classes:
- move those helpers into `widgets/` or another `views/` file
- avoid private helper-class stacking inside one file

## Reference Rule
Use the refactored `auth` and `app_shell` features as the current example of this pattern.
