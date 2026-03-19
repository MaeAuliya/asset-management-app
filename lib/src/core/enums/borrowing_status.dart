enum BorrowingStatus {
  active,
  completed,
  overdue,
  pendingApproval,
}

extension BorrowingStatusX on BorrowingStatus {
  String get label => switch (this) {
    BorrowingStatus.active => 'Active',
    BorrowingStatus.completed => 'Completed',
    BorrowingStatus.overdue => 'Overdue',
    BorrowingStatus.pendingApproval => 'Pending Approval',
  };
}
