# Context Access Pattern

## Goal
Keep presentation-layer state access consistent and easy to read by routing all `Bloc` and `Provider` access through `BuildContext` extensions.

This pattern supports the standard feature template:
- `Screen` uses typed accessors for startup dispatch and listener reactions
- `View` uses typed accessors for reading provider state and dispatching bloc events
- `View` and `Widget` should also prefer existing context helpers such as `context.theme`, `context.textTheme`, `context.colorScheme`, `context.widthScale`, and `context.heightScale`

## Source of Truth
- File: `lib/src/core/extensions/context_extension.dart`

## Mandatory Rules
1. Do not call generic context access directly in feature presentation code:
   - `context.read<T>()`
   - `context.watch<T>()`
   - `context.select<T, R>(...)`
2. Use typed accessors from `ContextExtension` only.
3. Prefer existing non-state helpers from `ContextExtension` for theming and sizing instead of raw `Theme.of(context)` or custom size helpers.
4. Accessor names use direct names (no prefix), for example:
   - `context.authBloc`
   - `context.budgetBloc`
   - `context.dashboardBloc`
   - `context.transactionBloc`
   - `context.navigationProvider`
5. Local variable names should match direct accessor names:
   - `final authBloc = context.authBloc;`
   - `final navigationProvider = context.navigationProvider;`
   - `final appShellProvider = context.appShellProvider;`

## Typed Accessor Naming

### Bloc Accessors
- Read: `<name>Bloc` getter
- Watch: `watch<Name>Bloc()`
- Select: `select<Name>Bloc<R>(...)`

Examples:
- `authBloc`, `watchAuthBloc()`, `selectAuthBloc(...)`
- `budgetBloc`, `watchBudgetBloc()`, `selectBudgetBloc(...)`
- `dashboardBloc`, `watchDashboardBloc()`, `selectDashboardBloc(...)`
- `transactionBloc`, `watchTransactionBloc()`, `selectTransactionBloc(...)`

### Provider Accessors
- Read: `<name>Provider` getter
- Watch: `watch<Name>Provider()`
- Select: `select<Name>Provider<R>(...)`

Examples:
- `navigationProvider`, `watchNavigationProvider()`, `selectNavigationProvider(...)`
- `transactionFormProvider`, `watchTransactionFormProvider()`, `selectTransactionFormProvider(...)`
- `transactionListProvider`, `watchTransactionListProvider()`, `selectTransactionListProvider(...)`
- `appShellProvider`, `watchAppShellProvider()`, `selectAppShellProvider(...)`

## Adding New Bloc/Provider
When adding a new `Bloc` or `Provider`:
1. Add imports and typed accessors in `context_extension.dart`.
2. Use only those accessors in screens/views/widgets.
3. Update this file with the new accessor names.

## Expected Usage By Layer
- `Screen`: dispatch initial bloc events and react to listener states through typed accessors
- `View`: read provider values and dispatch user-triggered bloc events through typed accessors
- `Widget`: may use typed accessors only when the widget is still feature-specific and lives under that feature
- `Bloc` itself still calls use cases; typed context access does not replace the `Bloc -> UseCase` rule

## Validation Command
Use this check to detect direct generic calls:

```bash
rg "context\.(read|watch|select)<" lib/src/features -n
```

Expected result: no matches.
