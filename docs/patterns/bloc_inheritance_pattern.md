# Bloc Inheritance Pattern

## Goal
Use a consistent superclass/subclass structure for Bloc event-state modeling.

## Mandatory Structure
For each feature bloc:

1. Event base class:
   - `abstract class <Feature>Event extends Equatable`
2. State base class:
   - `abstract class <Feature>State extends Equatable`
3. Concrete subclasses:
   - Event subclasses represent user/system intents.
   - State subclasses represent UI state transitions.
4. Bloc class:
   - `class <Feature>Bloc extends Bloc<<Feature>Event, <Feature>State>`
   - Register handlers in constructor using `on<Event>(_handler)`.
5. Handlers:
   - Keep handler methods private (`_on...`).
   - Emit loading/success/error states explicitly.
   - Call use cases from handlers, then `fold` left/right results into emitted states.

## File Split Pattern
- `<feature>_bloc.dart`:
  - bloc class + imports + `part` declarations
- `<feature>_event.dart`:
  - base event + concrete event subclasses
- `<feature>_state.dart`:
  - base state + concrete state subclasses

## Naming Conventions
- Event classes end with `Event`.
- State classes end with `State`.
- Use clear intent names:
  - `Load...Event`, `Refresh...Event`, `Create...Event`, `Delete...Event`
  - `Initial`, `Loading`, `Loaded`, `Error`, `Success`, etc.

## Equatable Guidance
- Base event/state usually return empty `props`.
- Subclasses override `props` only for fields that affect equality.

## Anti-Pattern
Do not use a single concrete state object with:
- a status enum
- `copyWith(...)`
- mixed loading/success/error branches inside one mutable-looking state shape

This repository uses inheritance-based bloc states instead.

## Current Project Examples
- `AuthBloc` with `AuthEvent`/`AuthState`
- `DashboardBloc` with `DashboardEvent`/`DashboardState`
- `TransactionBloc` with `TransactionEvent`/`TransactionState`

These examples are already aligned with this pattern and should remain the implementation reference.
