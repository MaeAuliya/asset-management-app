# Repository Guidelines

## Project Context First
- Before planning, coding, or reviewing product-facing work, read the relevant files in `docs/`.
- Treat `docs/product/` as the source of truth for product behavior, screen intent, user flows, roadmap priorities, and the repo-side UI design brief.
- Treat `docs/patterns/` as the source of truth for implementation consistency and architecture usage rules.
- `docs/patterns/` is binding implementation policy. If code and `docs/patterns/` differ, the implementation is non-compliant until the code is fixed or the docs are intentionally updated first.
- Review `docs/TODO/next_steps.md` before proposing delivery order, milestones, or future work.

## UI Design Workflow
- For any UI-facing work, always review `docs/product/mobile_app_ui_ux_spec.md` and other relevant `docs/product` files before making implementation decisions.
- UI-facing work includes screens, navigation changes, dashboards, component composition, state presentation, barcode interaction flows, notification UX, and admin or user workflow screens.
- For UI-facing work, the required sequence is: `plan -> design in Google Stitch -> sync design intent back into docs/product -> implement`.
- Do not implement user-facing UI changes before the Google Stitch design step is completed.
- If Google Stitch design changes or clarifies the product behavior, update the relevant `docs/product` files so the repository stays aligned with the latest approved design intent.
- Default Stitch project reference for this repo: `Asset Catalog` (`projects/13780564782865433795`) until a newer approved project replaces it.
- Non-UI work such as backend setup, schema work, dependency wiring, tooling, and internal refactors does not require the Google Stitch step.

## Engram Context Rule
- Before making assumptions about previous decisions, check Engram memory for relevant prior-session context.
- Use Engram only as supporting context for past discussions or decisions.
- If Engram conflicts with the current repository state or `docs/`, prefer the current repository files and `docs/`.
- If Engram memory appears empty or stale for this project, run `node scripts/engram_codex_ingest.mjs --cwd C:\Users\o-maisan.auliya\Documents\Project\asset-management-app` to ingest Codex session transcripts into the local Engram database.

## Project Structure & Module Organization
`lib/` contains application code, with `main.dart` as the entry point and feature code under `lib/src/`. Follow the existing Clean Architecture split: `core/` for shared services, resources, widgets, and utilities; `features/` for product code grouped by `data/`, `domain/`, and `presentation/`; `core/modules/` for reusable cross-feature modules. Tests mirror source paths under `test/`. Static assets live in `assets/` with separate folders for `fonts/`, `icons/`, `images/`, `vectors/`, and `animations/`. Native platform scaffolding stays in `android/` and `ios/`.

## Build, Test, and Development Commands
Run `flutter pub get` after dependency changes. Use `flutter run` to launch the app locally on a connected device or emulator. Use `flutter analyze` for static analysis and lint enforcement. Run `flutter test` for the full unit test suite; CI uses `flutter test --concurrency=4`. Before opening a PR, run `dart format .` and, when preparing release artifacts, use standard Flutter targets such as `flutter build apk` or `flutter build ios`.

## Coding Style & Naming Conventions
This repository follows `flutter_lints` plus local rules in `analysis_options.yaml`, including `prefer_relative_imports` and `prefer_const_constructors`. Keep Dart formatting consistent with `dart format`; the repo preserves trailing commas. Use 2-space indentation. Name files in `snake_case.dart`, classes and enums in `PascalCase`, methods and variables in `camelCase`, and Bloc files with explicit suffixes such as `template_bloc.dart`, `template_event.dart`, and `template_state.dart`.

## Testing Guidelines
Tests use `flutter_test`, `mocktail`, and `bloc_test`. Add tests beside the matching feature path under `test/`, for example `test/features/template/domain/usecases/get_current_template_version_test.dart`. Prefer unit tests for datasources, repositories, use cases, models, and blocs. Keep test names descriptive and focused on observable behavior.

## Commit & Pull Request Guidelines
Current history is minimal, so use short imperative commit subjects such as `Add template repository tests` or `Refactor injection setup`. Keep one logical change per commit when possible. PRs should include a concise summary, linked issue if applicable, test evidence (`flutter analyze`, `flutter test`), and screenshots or recordings for UI changes.

## CI & Configuration Notes
GitHub Actions runs on pushes and PRs targeting `master` and `develop` via `.github/workflows/flutter-ci.yml`. Do not commit local IDE files or secrets. Keep dependency, asset, and platform configuration changes in `pubspec.yaml`, `android/`, and `ios/` narrowly scoped and reviewed.
