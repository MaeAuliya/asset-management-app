enum UserRole {
  user,
  admin,
}

extension UserRoleX on UserRole {
  String get label => switch (this) {
    UserRole.user => 'User',
    UserRole.admin => 'Admin',
  };

  String get shellTitle => switch (this) {
    UserRole.user => 'Asset Lending',
    UserRole.admin => 'Admin Console',
  };
}
