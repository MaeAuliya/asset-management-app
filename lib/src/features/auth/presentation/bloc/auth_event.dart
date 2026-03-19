part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

class InitializeAuthEvent extends AuthEvent {
  const InitializeAuthEvent();
}

class RequestCameraPermissionEvent extends AuthEvent {
  const RequestCameraPermissionEvent();
}

class RequestNotificationPermissionEvent extends AuthEvent {
  const RequestNotificationPermissionEvent();
}

class OpenPermissionSettingsEvent extends AuthEvent {
  const OpenPermissionSettingsEvent();
}

class CompleteOnboardingEvent extends AuthEvent {
  const CompleteOnboardingEvent();
}

class SubmitSignInEvent extends AuthEvent {
  const SubmitSignInEvent({
    required this.identifier,
    required this.password,
    required this.role,
  });

  final String identifier;
  final String password;
  final UserRole role;

  @override
  List<Object?> get props => [identifier, password, role];
}

class SignOutEvent extends AuthEvent {
  const SignOutEvent();
}
