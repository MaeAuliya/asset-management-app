# Mobile App UI UX Specification

## Design Direction
- Professional and modern enterprise mobile app
- Clean layout with strong visual hierarchy
- Minimal but polished presentation
- Practical, trustworthy, and organized tone
- Barcode actions should be highly visible and quick to access

## Approved Stitch Reference
- Approved default UI design workspace: Google Stitch project `Asset Catalog` (`projects/13780564782865433795`)
- Use this Stitch project as the primary visual reference for user-facing UI decisions before implementation.
- Keep `docs/product/` as the repository source of truth; sync approved Stitch decisions back into these docs before building screens.
- Preserve the approved design system direction from Stitch: deep blue primary surfaces, tonal layering, soft status chips, no hard divider lines, and premium glass or gradient treatment for floating actions.
- Treat the `AssetFlow` label visible in some Stitch screens as draft copy, not final product naming.

## Visual System
- Use structured cards for dashboards and summaries
- Use status chips consistently: `Available`, `Borrowed`, `Overdue`, `Pending Approval`
- Use notification badges for unread reminders and urgent alerts
- Use reminder banners for upcoming returns and overdue warnings
- Use clear primary CTAs for `Scan Barcode`, `Borrow`, `Return`, `Approve`, and `Export`

## Information Architecture

### User Navigation
- Home
- Assets
- Scan
- History
- Settings or More

User navigation notes:
- `Scan` is a primary destination in the user shell and should remain persistently accessible.
- Notifications remain a first-class screen, but should be entered from the app header badge, reminder banners, or secondary settings or more entry rather than a primary bottom-nav tab.

### Admin Navigation
- Dashboard
- Assets
- Requests
- History
- Settings

Admin navigation notes:
- Admin request handling remains a primary destination.
- Admin scan actions should surface as dashboard or screen-level quick actions, not as a primary bottom-nav tab.

## Shared Components
- App header with role-specific title and notification badge
- Summary cards for counts and operational status
- Status chips for asset and request states
- Category chips for `Laptop` and `Projector`
- Search and filter bar
- Persistent user scan entry in the primary app shell
- Action sheet for export, print, and secondary actions
- Empty state block with short explanation and CTA
- Confirmation bottom sheet for borrow, return, and approval actions

## User Screens

### 1. Login Screen
Purpose: authenticate users and route them to the correct role-based experience.

Main content:
- App logo and product title
- Email or employee ID field
- Password field
- Login button
- Optional support/help link

States:
- Loading while signing in
- Error banner for invalid credentials

### 2. Home Dashboard
Purpose: give the user an immediate summary of what needs action.

Main content:
- Greeting and role label
- Summary cards: active borrowings, upcoming returns, overdue items
- Quick actions: `Scan Barcode`, `Browse Assets`, `Return Asset`
- Reminder banner for due-soon items
- Short list of current borrowings

### 3. Asset List Screen
Purpose: let users find assets by category and availability.

Main content:
- Search bar
- Category tabs or chips: `Laptop`, `Projector`
- Availability filter
- Asset cards showing name, code, status, and short metadata

States:
- Empty state when no matching assets exist
- Pull-to-refresh or refresh action for latest availability

### 4. Asset Detail Screen
Purpose: show asset details and the next valid action.

Main content:
- Asset identity section
- Status chip
- Borrowing rules or duration summary
- Asset notes, location, and barcode ID
- Primary CTA changes by state:
  - `Borrow Now` when available
  - `Unavailable` or info-only when borrowed

### 5. Borrow Asset Flow
Purpose: confirm asset borrowing with a clear, short sequence.

Main steps:
- Select asset or scan asset barcode
- Review asset and borrowing duration
- Confirm borrow action
- Show success state with due date and reminder note

### 6. Barcode Scan Screen for Single Borrowing
Purpose: make single borrowing the fastest path in the app.

Main content:
- Large scan frame
- Flashlight and manual entry options
- Short helper text
- Result card after successful scan

Priority:
- This screen should be accessible directly from the primary user navigation and from dashboard quick actions.

### 7. Return Asset Flow
Purpose: complete return quickly and accurately.

Main steps:
- Start from active borrowing detail or scan return barcode
- Confirm asset identity and borrowing record
- Submit return
- Show success confirmation and refreshed asset status

### 8. Notifications Screen
Purpose: centralize reminders and status updates.

Content types:
- Upcoming return reminders
- Overdue alerts
- Borrow approval results
- General account or asset activity notices

UI behavior:
- Unread badge indicators
- Filters by notification type
- Tap-through to borrowing detail

Entry points:
- Header notification badge
- Reminder and overdue banners
- Secondary settings or more entry when needed

### 9. Borrowing History Screen
Purpose: let users review past and active borrowing records.

Main content:
- Filters for active, completed, overdue
- Borrowing record list cards
- Asset type, borrow date, due date, and status chip

### 10. Borrowing Detail and Status Screen
Purpose: provide one place for the full borrowing record.

Main content:
- Asset summary
- Borrow date, due date, return date
- Current status
- Reminder or overdue banner
- Return CTA when still active

## Admin Screens

### 1. Admin Dashboard
Purpose: provide an operational overview.

Main content:
- Summary cards for available assets, borrowed assets, overdue assets, pending approvals
- Today stats and all-time stats
- Urgent alert banner when assets are overdue and needed
- Quick actions for `Add Asset`, `Approve Requests`, `Generate Barcode`

### 2. User Management Screen
Purpose: manage employee accounts and access.

Main content:
- Search and filter
- User list with role, status, department if used later
- Actions for add, edit, deactivate, and delete

### 3. Asset Management Screen
Purpose: monitor and manage the inventory.

Main content:
- Search and category filters
- Asset cards or compact list with status chip
- Actions for add, edit, archive, print barcode

### 4. Add/Edit Asset Screen
Purpose: create or update asset records.

Fields:
- Asset name
- Asset code
- Category
- Barcode value
- Availability or operational note
- Optional location and condition fields

### 5. Borrowing Request Approval Screen
Purpose: process bulk borrowing requests efficiently.

Main content:
- Request cards with requester, quantity, purpose, duration, and status
- Approve and reject actions
- Request detail view for full context

### 6. Borrowing Statistics Screen
Purpose: show operational metrics clearly.

Main content:
- Today vs all-time summaries
- Category breakdown
- Overdue count
- Approval trend or request load summary

### 7. History Screen
Purpose: review completed and active transaction records.

Main content:
- Search, date range, status, and category filters
- History list with drill-down detail

### 8. Export History Screen
Purpose: let admins export filtered records.

Main content:
- Selected filters summary
- Export scope options
- Export action CTA
- Success message with file/export status

### 9. Barcode Generation and Print Screen
Purpose: create and distribute barcodes for assets or bulk borrowing flows.

Main content:
- Choose target type: single asset or bulk request
- Generated barcode preview
- Print and share actions

### 10. Settings Screen for Dynamic Borrowing Duration
Purpose: control operational borrowing rules.

Main content:
- Category-specific borrowing duration settings
- Optional rule toggles for reminder timing
- Save confirmation state

### 11. Urgent Alerts / Overdue Assets Screen
Purpose: help admin react to risk quickly.

Main content:
- Overdue records sorted by urgency
- Asset need or shortage indicator
- Quick actions to contact, remind, or escalate

## UX Behavior Rules
- Real-time availability should refresh key lists and dashboards after borrow, return, and approval actions.
- Reminder banners should appear on dashboards and borrowing detail screens when due dates are near.
- Overdue records should always be visually stronger than normal reminders.
- Pending approval should block direct bulk borrowing completion until admin approval is granted.
- Barcode scan should always be available as a top-priority action for fast operational use.
- User shell navigation should prioritize `Scan` over a primary notifications tab.
- Admin shell navigation should prioritize `Requests` over a primary scan tab.

## Notification Types
- Upcoming due reminder
- Overdue alert
- Bulk request approved
- Bulk request rejected
- Urgent admin shortage alert
- General status update

## Empty, Loading, and Error States
- Empty states should explain why no data is shown and offer a direct next action.
- Loading states should keep the layout stable with skeletons or progress indicators.
- Error states should offer retry and keep critical actions accessible where possible.
