enum AppPermissionStatus {
  granted,
  denied,
  permanentlyDenied,
  restricted,
  limited,
  provisional,
}

extension AppPermissionStatusX on AppPermissionStatus {
  bool get isGranted => switch (this) {
        AppPermissionStatus.granted ||
        AppPermissionStatus.limited ||
        AppPermissionStatus.provisional =>
          true,
        _ => false,
      };

  String get label => switch (this) {
        AppPermissionStatus.granted => 'Granted',
        AppPermissionStatus.denied => 'Denied',
        AppPermissionStatus.permanentlyDenied => 'Permanently denied',
        AppPermissionStatus.restricted => 'Restricted',
        AppPermissionStatus.limited => 'Limited',
        AppPermissionStatus.provisional => 'Provisional',
      };
}
