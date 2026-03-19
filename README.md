# Office Asset Lending App

Mobile-first office asset lending application for managing laptop and projector borrowing in a structured, trackable, and notification-centered way.

## Product Overview
- Digitizes office borrowing and return workflows that are currently handled manually.
- Focuses on real-time asset availability, clear borrowing status, and reminder-driven return management.
- Supports two roles:
  - `User`: employee borrowing and returning assets
  - `Admin`: operator managing assets, approvals, monitoring, and alerts

## Main Problems Solved
- Borrowing and return schedules are disorganized.
- Asset availability is hard to track in real time.
- There is no reliable reminder flow for overdue or upcoming returns.

## Core Features

### User
- Login and logout
- Browse assets by category
- Borrow single assets through barcode scanning
- Submit bulk borrowing requests
- Return borrowed assets
- View notifications and return reminders
- View borrowing history and borrowing status detail

### Admin
- Manage users
- Manage assets
- Configure borrowing duration rules
- Approve bulk borrowing requests
- Monitor availability, overdue items, and pending approvals
- View and export history
- Generate and print barcodes
- Receive urgent alerts when assets are overdue or needed for priority use

## Business Rules
- Asset scope is limited to `Laptop` and `Projector`.
- Single-item borrowing can be completed by scanning the physical barcode attached to the asset.
- Bulk borrowing requires admin approval.
- Bulk borrowing uses an admin-generated barcode.
- Laptop borrowing commonly supports training sessions and medium-to-large batch requests.
- Borrowing duration is configurable by admin.

## Product Direction
- Mobile-first user experience
- Clean, professional enterprise utility design
- Fast barcode-based actions
- Strong reminders, overdue alerts, and urgent notifications
- Clear status communication: `Available`, `Borrowed`, `Overdue`, `Pending Approval`

## Tech Stack

### Existing Template Foundation
This project started from a Flutter Clean Architecture template and keeps its current base dependencies and architecture direction:
- Flutter
- Dart
- Bloc / flutter_bloc
- Provider
- get_it
- Equatable
- Dartz
- Dio
- Shared Preferences
- flutter_svg
- lottie
- url_launcher
- package_info_plus
- flutter_test
- mocktail
- bloc_test

### Planned Product Additions
- Supabase for primary database
- Supabase-backed authentication and role mapping
- Supabase real-time updates for asset availability and request status
- Supabase-supported push notification integration strategy

## Project Structure
```text
docs/
  patterns/   implementation conventions and architecture usage rules
  product/    product strategy, UI/UX specification, and user flows
  TODO/       execution roadmap and next implementation steps

lib/
  main.dart
  src/
    core/
    features/

test/
```

## Documentation Index
- `docs/product/strategy_roadmap.md`: product strategy, scope, roadmap, and success metrics
- `docs/product/mobile_app_ui_ux_spec.md`: mobile screen specifications and UI behavior
- `docs/product/user_flows.md`: end-to-end user and admin flows
- `docs/patterns/README.md`: engineering convention index
- `docs/TODO/next_steps.md`: implementation backlog and milestone ordering

## Current Status
- Repository structure is already prepared with Clean Architecture conventions.
- Product documentation is being used to convert the template into an office asset lending application.
- Supabase integration is planned but not yet implemented in this documentation pass.

## Development Workflow
- For UI-facing work, the expected sequence is: `plan -> design in Google Stitch -> sync design intent back into docs/product -> implement`.
- `docs/product/` remains the repository source of truth for product and UI intent.
- Google Stitch is the design workspace to use before implementing user-facing screens and flows.
- Current approved default Stitch project for this repo: `Asset Catalog` (`projects/13780564782865433795`).

## Development Commands
- `flutter pub get`
- `flutter run`
- `flutter analyze`
- `flutter test`
- `dart format .`

## Notes
- Check `docs/` before starting product-facing implementation work.
- Treat `docs/product/` as the product source of truth.
- Treat `docs/patterns/` as the implementation-convention source of truth.

## Engram Memory
- To ingest Codex session history into the local Engram database for this project, run: `node scripts/engram_codex_ingest.mjs --cwd C:\Users\o-maisan.auliya\Documents\Project\asset-management-app`
- This writes session-derived memory into `~/.engram/default.db` and tracks progress in `~/.config/engram/codex-ingest-state.json`.
