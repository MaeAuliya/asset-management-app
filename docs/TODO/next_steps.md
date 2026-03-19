# Next Steps

## Design Sync Baseline
- Use Google Stitch project `Asset Catalog` (`projects/13780564782865433795`) as the default UI design reference for this repo.
- Sync approved Stitch behavior back into `docs/product/` before implementation of any user-facing screen.
- Keep MVP asset scope limited to `Laptop` and `Projector`; do not implement `Peripherals` unless product scope is expanded later.
- Keep user IA barcode-first: `Home`, `Assets`, `Scan`, `History`, `Settings or More`.
- Keep admin IA request-first: `Dashboard`, `Assets`, `Requests`, `History`, `Settings`.
- Treat `AssetFlow` copy in Stitch as draft wording until product naming is finalized in the repo.

## Foundation
- Finalize product documentation in `docs/product/`
- Lock app navigation strategy for role-based entry after login using the approved Stitch and docs baseline
- Establish feature modules for auth, assets, borrowing, notifications, history, admin dashboard, and settings
- Plan Supabase schema for users, roles, assets, borrowing records, approvals, notifications, and settings
- Define asset status model: `Available`, `Borrowed`, `Overdue`, `Pending Approval`
- Define borrowing rule model for single borrow, bulk borrow, and dynamic duration
- Prepare dependency injection and repository contracts for the new features

## Designed Screens First
- Implement splash and sign-in flows after syncing their final copy from Stitch
- Implement onboarding permission screens for welcome, camera, and notifications
- Implement user home dashboard based on the approved Stitch user home screen
- Implement admin dashboard based on the approved Stitch admin home screen
- Implement asset catalog and asset detail based on the approved Stitch screens
- Implement notifications center and pending approvals based on the approved Stitch screens
- Implement asset management flow after syncing it back into product docs

## Design Gaps To Close Before UI Implementation
- Design the dedicated barcode scan screen for user single-item borrowing
- Design the return flow and success states
- Design borrowing history list and borrowing detail screens
- Design admin user management screens
- Design settings screens for dynamic borrowing duration
- Design export history and barcode generation or print screens

## MVP User
- Build login and logout flow
- Build user home dashboard with asset availability, upcoming returns, and reminder highlights
- Build asset list screen with category filter for `Laptop` and `Projector`
- Build asset detail screen with status, metadata, and borrow action
- Build single-item barcode scan flow for borrowing
- Build return flow from active borrowing detail
- Build notifications screen with reminder and status updates
- Build borrowing history list and borrowing detail/status screens

## MVP Admin
- Build admin dashboard with today stats, all-time stats, pending approvals, overdue items, and urgent alerts
- Build user management CRUD
- Build asset management CRUD
- Build add/edit asset form
- Build borrowing request approval screen for bulk requests
- Build borrowing statistics screen
- Build history screen
- Build settings screen for dynamic borrowing duration

## Notifications
- Define reminder schedule behavior for upcoming due dates
- Define overdue notification behavior for users
- Define urgent admin alert behavior for assets needed but not returned
- Connect in-app notification center to backend-driven notification records
- Plan push notification integration using Supabase-supported event flow

## Barcode
- Define barcode payload rules for single-item borrowing
- Define admin-generated barcode format for bulk borrowing
- Implement scan entry points from dashboard and borrow flow
- Implement admin barcode generation and print workflow

## Reporting
- Build admin history filtering and export requirements
- Define export format for borrowing history
- Add daily and all-time statistics summaries

## Polish
- Add empty, loading, and error states across all main screens
- Refine status chips, reminder banners, and urgent alert presentation
- Improve dashboard readability and action prioritization
- Confirm accessibility, readability, and mobile responsiveness

## First Milestone Acceptance
- User can log in, browse assets, borrow one asset by barcode, return it, and see history
- Admin can manage assets, manage users, approve bulk requests, and configure borrowing duration
- Both roles can see notification-driven status updates
- Asset availability updates reflect the latest borrowing state

## Dependencies and Order
- Auth and role mapping must exist before role-based dashboards
- Asset and borrowing domain models must exist before dashboard metrics
- Borrowing duration settings must exist before reminder timing is finalized
- Notification pipeline planning must exist before push reminders are implemented
- Barcode rules must be finalized before scan and print workflows are built

## Notes
- Use the current Flutter template stack as the implementation foundation.
- Add Supabase as a product-specific backend layer, not as a replacement for the template architecture.
- Supabase MCP can be used later during implementation for schema and backend operations.
- Stitch already covers splash, sign-in, onboarding permissions, user dashboard, admin dashboard, asset catalog, asset detail, notifications, pending approvals, and asset management flow.
