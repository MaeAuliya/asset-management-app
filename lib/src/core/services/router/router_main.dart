part of 'router.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case SplashScreen.routeName:
      return _pageBuilder(
        (_) => const SplashScreen(),
        settings: settings,
      );
    case OnboardingWelcomeScreen.routeName:
      return _pageBuilder(
        (_) => const OnboardingWelcomeScreen(),
        settings: settings,
      );
    case CameraPermissionScreen.routeName:
      return _pageBuilder(
        (_) => const CameraPermissionScreen(),
        settings: settings,
      );
    case NotificationPermissionScreen.routeName:
      return _pageBuilder(
        (_) => const NotificationPermissionScreen(),
        settings: settings,
      );
    case AuthEntryScreen.routeName:
      return _pageBuilder(
        (_) => const AuthEntryScreen(),
        settings: settings,
      );
    case UserShellScreen.routeName:
      return _pageBuilder(
        (_) => const UserShellScreen(),
        settings: settings,
      );
    case AdminShellScreen.routeName:
      return _pageBuilder(
        (_) => const AdminShellScreen(),
        settings: settings,
      );
    case NotificationsScreen.routeName:
      return _pageBuilder(
        (_) => const NotificationsScreen(),
        settings: settings,
      );
    default:
      return _pageBuilder(
        (_) => const PageUnderConstruction(
          title: 'Unknown route',
          message:
              'The requested route is not mapped yet. Add it to the router as the next feature slice is implemented.',
        ),
        settings: settings,
      );
  }
}

PageRouteBuilder<dynamic> _pageBuilder(
  Widget Function(BuildContext) page, {
  required RouteSettings? settings,
}) {
  return PageRouteBuilder(
    settings: settings,
    pageBuilder: (context, _, __) => page(context),
    barrierDismissible: false,
  );
}
