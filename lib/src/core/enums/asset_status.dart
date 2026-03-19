enum AssetStatus {
  available,
  borrowed,
  overdue,
  pendingApproval,
}

extension AssetStatusX on AssetStatus {
  String get label => switch (this) {
    AssetStatus.available => 'Available',
    AssetStatus.borrowed => 'Borrowed',
    AssetStatus.overdue => 'Overdue',
    AssetStatus.pendingApproval => 'Pending Approval',
  };
}
