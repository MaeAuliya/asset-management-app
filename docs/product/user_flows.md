# User Flows

## 1. Login Flow
Actor: User or Admin

Trigger:
- User opens the app and needs to access the system

Flow:
1. User enters credentials.
2. System validates account and role.
3. User is routed to the correct dashboard.

End state:
- Authenticated session on either the user or admin experience

## 2. Logout Flow
Actor: User or Admin

Trigger:
- User selects logout from profile or settings

Flow:
1. User taps logout.
2. System confirms intent if needed.
3. Session is ended.
4. App returns to login screen.

End state:
- User is signed out

## 3. Browse Asset and Borrow from Detail
Actor: User

Trigger:
- User needs an asset and opens the asset list

Flow:
1. User filters assets by `Laptop` or `Projector`.
2. User opens asset detail.
3. System shows real-time availability.
4. User taps `Borrow Now`.
5. System presents borrowing summary and due date.
6. User confirms.

Decision:
- If asset is not available, borrowing action is blocked.

End state:
- Borrowing record is created and asset status becomes `Borrowed`

## 4. Single Borrow by Barcode Scan
Actor: User

Trigger:
- User taps `Scan Barcode` from primary navigation, dashboard, or borrow flow

Flow:
1. Scanner opens.
2. User scans physical asset barcode.
3. System validates asset and checks availability.
4. Borrowing summary is shown.
5. User confirms borrow.
6. System creates borrowing record and schedules reminder logic.

Decision:
- If barcode is invalid or asset is unavailable, show clear failure state.

End state:
- Single-item borrowing completed

## 5. Bulk Borrowing Request and Approval
Actor: User then Admin

Trigger:
- User needs multiple assets, commonly laptops for training

Flow:
1. User starts bulk request.
2. User selects or specifies needed assets and borrowing reason.
3. System creates a `Pending Approval` request.
4. Admin receives request notification.
5. Admin reviews quantity, purpose, and duration.
6. Admin approves or rejects.
7. If approved, admin-generated barcode is used for the bulk borrowing process.
8. User receives approval result notification.

End state:
- Request is approved or rejected

## 6. Return Flow
Actor: User

Trigger:
- User opens active borrowing detail or starts return action

Flow:
1. User selects active borrowing record or scans for return.
2. System shows borrowed asset information.
3. User confirms return.
4. System closes borrowing record.
5. Asset status returns to `Available`.

End state:
- Return completed and availability updated

## 7. Reminder-to-Return Flow
Actor: User

Trigger:
- System sends upcoming due or overdue notification

Flow:
1. User receives notification.
2. User opens notification.
3. App routes to borrowing detail.
4. User reviews due status.
5. User completes return if ready.

End state:
- User is redirected from reminder into the correct return path

## 8. Notifications Review Flow
Actor: User or Admin

Trigger:
- User opens notification center from the header badge, reminder banner, or secondary entry

Flow:
1. System shows notifications ordered by priority and recency.
2. User filters by type if needed.
3. User opens a notification.
4. App routes to the related asset, borrowing record, approval, or alert detail.

End state:
- Notification is understood and linked action can be taken

## 9. Borrowing History and Detail Flow
Actor: User or Admin

Trigger:
- User needs to review past or current borrowing activity

Flow:
1. User opens history screen.
2. User filters by status, category, or date if needed.
3. User opens a specific record.
4. System shows full borrowing detail and status timeline.

End state:
- Borrowing record is reviewed with complete context

## 10. Admin Approval Management Flow
Actor: Admin

Trigger:
- Admin opens pending request list

Flow:
1. Admin reviews pending bulk requests.
2. Admin opens request detail.
3. Admin evaluates asset availability and borrowing need.
4. Admin approves or rejects.
5. System updates request status and sends user notification.

End state:
- Pending request is resolved

## 11. Admin Urgent Alert Response Flow
Actor: Admin

Trigger:
- System flags overdue items that are urgently needed

Flow:
1. Admin receives urgent alert.
2. Admin opens overdue alert detail.
3. System highlights affected assets and current borrowers.
4. Admin reviews priority and shortage impact.
5. Admin triggers follow-up action such as reminder or escalation.

End state:
- Admin has acted on the urgent case

## 12. Admin Export History Flow
Actor: Admin

Trigger:
- Admin needs operational records outside the app

Flow:
1. Admin opens history or export screen.
2. Admin applies date, status, or category filters.
3. Admin confirms export.
4. System prepares export output.

End state:
- Filtered history is exported successfully

## Flow Notes
- Real-time availability should be reflected after borrow, return, and approval actions.
- Reminder and alert events are expected to be backed by Supabase-driven data and notification processes later.
- If historical Engram context exists for product decisions, it should be treated as supporting context only and validated against current docs.
