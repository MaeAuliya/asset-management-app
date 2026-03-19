# Presentation State Ownership Pattern

## Goal
Keep presentation state predictable and reusable by avoiding `setState` for feature state changes.

This document does not replace the feature template pattern. Read it together with:
- `feature_template_pattern.md`
- `presentation_flow_pattern.md`

## Mandatory Rules
1. Do not use `setState` for feature presentation state.
2. Use `Bloc` for async or domain-driven feature flow.
3. Use `Provider` as a lightweight binder for screen-consumed presentation state.
4. If the state is strictly local to one widget or one screen and will not be reused elsewhere, use `ValueNotifier` instead of `setState`.
5. Keep business or flow state out of widgets and out of providers when it belongs in Bloc or domain contracts.
6. When using `Provider`, expose access through typed `BuildContext` extensions only.
7. For layout and styling, use existing context extensions and core widgets before raw Flutter primitives.
8. Do not use private helper classes to hide presentation complexity inside one file; extract them into `views/` or `widgets/`.

## Decision Rule
- Use `Bloc` for:
  - startup/auth async flow
  - loading, success, and error states
  - use case execution
  - side-effect-driving feature state
- Use `Provider` for:
  - values the feature view reads repeatedly
  - display-ready selections, filters, and binder state
  - presentation state shared across the feature view and its widgets
- Use `ValueNotifier` for:
  - one-widget toggle
  - simple temporary local state that never becomes feature flow state
  - screen-local interaction state that does not need a feature provider

## Disallowed Pattern
Do not introduce new code like this in feature presentation layers:

```dart
setState(() {
  currentIndex = index;
});
```

## Preferred Patterns

### Provider Binder Example
```dart
class AppShellProvider extends ChangeNotifier {
  int _currentIndex = 0;

  int get currentIndex => _currentIndex;

  void selectTab(int index) {
    if (_currentIndex == index) return;
    _currentIndex = index;
    notifyListeners();
  }
}
```

### Bloc Flow Example
```dart
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    context.authBloc.add(const InitializeAuthEvent());
    super.initState();
  }
}
```

### ValueNotifier Example
```dart
final selectedFilter = ValueNotifier<AssetFilter>(AssetFilter.all);
```

## Validation Command
Use this check to detect new `setState` usage in feature code:

```bash
rg "setState\\(" lib/src/features -n
```

Expected result: no matches.

## Temporary Drift
Some current features do not yet fully follow the restored feature template pattern. Do not treat those implementations as the default coding style for future work.
