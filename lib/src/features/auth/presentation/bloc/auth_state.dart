part of 'auth_bloc.dart';

enum AuthRouteTarget {
  splash,
  onboardingWelcome,
  authEntry,
  userShell,
  adminShell,
}

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

abstract class AuthResolvedState extends AuthState {
  const AuthResolvedState({
    required this.session,
    required this.nextRoute,
    required this.cameraPermissionStatus,
    required this.notificationPermissionStatus,
  });

  final StartupSession session;
  final AuthRouteTarget nextRoute;
  final AppPermissionStatus? cameraPermissionStatus;
  final AppPermissionStatus? notificationPermissionStatus;

  @override
  List<Object?> get props => [
    session,
    nextRoute,
    cameraPermissionStatus,
    notificationPermissionStatus,
  ];
}

class AuthInitialState extends AuthResolvedState {
  const AuthInitialState()
    : super(
        session: const StartupSession(
          isFirstOpen: true,
          isOnboardingCompleted: false,
          isSignedIn: false,
          role: null,
        ),
        nextRoute: AuthRouteTarget.splash,
        cameraPermissionStatus: null,
        notificationPermissionStatus: null,
      );
}

class AuthLoadingState extends AuthResolvedState {
  const AuthLoadingState({
    required super.session,
    required super.nextRoute,
    required super.cameraPermissionStatus,
    required super.notificationPermissionStatus,
  });
}

class AuthReadyState extends AuthResolvedState {
  const AuthReadyState({
    required super.session,
    required super.nextRoute,
    required super.cameraPermissionStatus,
    required super.notificationPermissionStatus,
  });
}

class AuthCameraPermissionUpdatedState extends AuthResolvedState {
  const AuthCameraPermissionUpdatedState({
    required super.session,
    required super.nextRoute,
    required super.cameraPermissionStatus,
    required super.notificationPermissionStatus,
  });
}

class AuthNotificationPermissionUpdatedState extends AuthResolvedState {
  const AuthNotificationPermissionUpdatedState({
    required super.session,
    required super.nextRoute,
    required super.cameraPermissionStatus,
    required super.notificationPermissionStatus,
  });
}

class AuthOnboardingCompletedState extends AuthResolvedState {
  const AuthOnboardingCompletedState({
    required super.session,
    required super.nextRoute,
    required super.cameraPermissionStatus,
    required super.notificationPermissionStatus,
  });
}

class AuthSignedInState extends AuthResolvedState {
  const AuthSignedInState({
    required super.session,
    required super.nextRoute,
    required super.cameraPermissionStatus,
    required super.notificationPermissionStatus,
  });
}

class AuthSignedOutState extends AuthResolvedState {
  const AuthSignedOutState({
    required super.session,
    required super.nextRoute,
    required super.cameraPermissionStatus,
    required super.notificationPermissionStatus,
  });
}

class AuthFailureState extends AuthResolvedState {
  const AuthFailureState({
    required super.session,
    required super.nextRoute,
    required super.cameraPermissionStatus,
    required super.notificationPermissionStatus,
    required this.errorMessage,
  });

  final String errorMessage;

  @override
  List<Object?> get props => [...super.props, errorMessage];
}
