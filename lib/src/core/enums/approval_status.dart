enum ApprovalStatus {
  pending,
  approved,
  rejected,
}

extension ApprovalStatusX on ApprovalStatus {
  String get label => switch (this) {
    ApprovalStatus.pending => 'Pending',
    ApprovalStatus.approved => 'Approved',
    ApprovalStatus.rejected => 'Rejected',
  };
}
