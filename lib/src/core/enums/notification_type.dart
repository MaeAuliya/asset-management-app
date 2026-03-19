enum NotificationType {
  dueReminder,
  overdueAlert,
  approvalApproved,
  approvalRejected,
  urgentAlert,
  generalUpdate,
}

extension NotificationTypeX on NotificationType {
  String get label => switch (this) {
    NotificationType.dueReminder => 'Upcoming Due Reminder',
    NotificationType.overdueAlert => 'Overdue Alert',
    NotificationType.approvalApproved => 'Bulk Request Approved',
    NotificationType.approvalRejected => 'Bulk Request Rejected',
    NotificationType.urgentAlert => 'Urgent Alert',
    NotificationType.generalUpdate => 'General Update',
  };
}
