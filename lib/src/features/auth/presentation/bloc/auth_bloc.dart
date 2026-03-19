import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/enums/app_permission_status.dart';
import '../../../../core/enums/user_role.dart';
import '../../domain/entities/startup_session.dart';
import '../../domain/usecases/check_camera_permission.dart';
import '../../domain/usecases/check_notification_permission.dart';
import '../../domain/usecases/clear_session.dart';
import '../../domain/usecases/complete_onboarding.dart';
import '../../domain/usecases/get_startup_session.dart';
import '../../domain/usecases/open_permission_settings.dart';
import '../../domain/usecases/request_camera_permission.dart';
import '../../domain/usecases/request_notification_permission.dart';
import '../../domain/usecases/save_signed_in_role.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc(
    this._getStartupSession,
    this._checkCameraPermission,
    this._checkNotificationPermission,
    this._requestCameraPermission,
    this._requestNotificationPermission,
    this._openPermissionSettings,
    this._completeOnboarding,
    this._saveSignedInRole,
    this._clearSession,
  ) : super(const AuthInitialState()) {
    on<InitializeAuthEvent>(_initializeAuthHandler);
    on<RequestCameraPermissionEvent>(_requestCameraPermissionHandler);
    on<RequestNotificationPermissionEvent>(
      _requestNotificationPermissionHandler,
    );
    on<OpenPermissionSettingsEvent>(_openPermissionSettingsHandler);
    on<CompleteOnboardingEvent>(_completeOnboardingHandler);
    on<SubmitSignInEvent>(_submitSignInHandler);
    on<SignOutEvent>(_signOutHandler);
  }

  final GetStartupSession _getStartupSession;
  final CheckCameraPermission _checkCameraPermission;
  final CheckNotificationPermission _checkNotificationPermission;
  final RequestCameraPermission _requestCameraPermission;
  final RequestNotificationPermission _requestNotificationPermission;
  final OpenPermissionSettings _openPermissionSettings;
  final CompleteOnboarding _completeOnboarding;
  final SaveSignedInRole _saveSignedInRole;
  final ClearSession _clearSession;

  StartupSession _session = const StartupSession(
    isFirstOpen: true,
    isOnboardingCompleted: false,
    isSignedIn: false,
    role: null,
  );
  AppPermissionStatus? _cameraPermissionStatus;
  AppPermissionStatus? _notificationPermissionStatus;
  AuthRouteTarget _nextRoute = AuthRouteTarget.splash;

  Future<void> _initializeAuthHandler(
    InitializeAuthEvent event,
    Emitter<AuthState> emit,
  ) async {
    _syncResolvedState();
    emit(_loadingState());

    final sessionResult = await _getStartupSession();
    await sessionResult.fold(
      (failure) async {
        emit(_failureState(message: failure.message));
      },
      (session) async {
        _session = session;

        final cameraResult = await _checkCameraPermission();
        final notificationResult = await _checkNotificationPermission();

        cameraResult.fold(
          (_) => _cameraPermissionStatus = null,
          (status) => _cameraPermissionStatus = status,
        );
        notificationResult.fold(
          (_) => _notificationPermissionStatus = null,
          (status) => _notificationPermissionStatus = status,
        );

        _nextRoute = _resolveRoute(_session);
        emit(_readyState());
      },
    );
  }

  Future<void> _requestCameraPermissionHandler(
    RequestCameraPermissionEvent event,
    Emitter<AuthState> emit,
  ) async {
    _syncResolvedState();
    final result = await _requestCameraPermission();
    result.fold(
      (failure) => emit(_failureState(message: failure.message)),
      (status) {
        _cameraPermissionStatus = status;
        emit(_cameraPermissionUpdatedState());
      },
    );
  }

  Future<void> _requestNotificationPermissionHandler(
    RequestNotificationPermissionEvent event,
    Emitter<AuthState> emit,
  ) async {
    _syncResolvedState();
    final result = await _requestNotificationPermission();
    result.fold(
      (failure) => emit(_failureState(message: failure.message)),
      (status) {
        _notificationPermissionStatus = status;
        emit(_notificationPermissionUpdatedState());
      },
    );
  }

  Future<void> _openPermissionSettingsHandler(
    OpenPermissionSettingsEvent event,
    Emitter<AuthState> emit,
  ) async {
    _syncResolvedState();
    final result = await _openPermissionSettings();
    result.fold(
      (failure) => emit(_failureState(message: failure.message)),
      (_) {},
    );
  }

  Future<void> _completeOnboardingHandler(
    CompleteOnboardingEvent event,
    Emitter<AuthState> emit,
  ) async {
    _syncResolvedState();
    emit(_loadingState());

    final result = await _completeOnboarding();
    result.fold(
      (failure) => emit(_failureState(message: failure.message)),
      (_) {
        _session = _session.copyWith(
          isFirstOpen: false,
          isOnboardingCompleted: true,
        );
        _nextRoute = AuthRouteTarget.authEntry;
        emit(_onboardingCompletedState());
      },
    );
  }

  Future<void> _submitSignInHandler(
    SubmitSignInEvent event,
    Emitter<AuthState> emit,
  ) async {
    _syncResolvedState();
    emit(_loadingState());

    final result = await _saveSignedInRole(
      SaveSignedInRoleParams(role: event.role),
    );
    result.fold(
      (failure) => emit(_failureState(message: failure.message)),
      (_) {
        _session = _session.copyWith(
          isFirstOpen: false,
          isOnboardingCompleted: true,
          isSignedIn: true,
          role: event.role,
        );
        _nextRoute = event.role == UserRole.user
            ? AuthRouteTarget.userShell
            : AuthRouteTarget.adminShell;
        emit(_signedInState());
      },
    );
  }

  Future<void> _signOutHandler(
    SignOutEvent event,
    Emitter<AuthState> emit,
  ) async {
    _syncResolvedState();
    emit(_loadingState());

    final result = await _clearSession();
    result.fold(
      (failure) => emit(_failureState(message: failure.message)),
      (_) {
        _session = _session.copyWith(
          isSignedIn: false,
          clearRole: true,
        );
        _nextRoute = AuthRouteTarget.authEntry;
        emit(_signedOutState());
      },
    );
  }

  AuthRouteTarget _resolveRoute(StartupSession session) {
    if (session.isFirstOpen || !session.isOnboardingCompleted) {
      return AuthRouteTarget.onboardingWelcome;
    }

    if (!session.isSignedIn || session.role == null) {
      return AuthRouteTarget.authEntry;
    }

    return session.role == UserRole.user
        ? AuthRouteTarget.userShell
        : AuthRouteTarget.adminShell;
  }

  AuthLoadingState _loadingState() {
    return AuthLoadingState(
      session: _session,
      nextRoute: _nextRoute,
      cameraPermissionStatus: _cameraPermissionStatus,
      notificationPermissionStatus: _notificationPermissionStatus,
    );
  }

  AuthReadyState _readyState() {
    return AuthReadyState(
      session: _session,
      nextRoute: _nextRoute,
      cameraPermissionStatus: _cameraPermissionStatus,
      notificationPermissionStatus: _notificationPermissionStatus,
    );
  }

  AuthCameraPermissionUpdatedState _cameraPermissionUpdatedState() {
    return AuthCameraPermissionUpdatedState(
      session: _session,
      nextRoute: _nextRoute,
      cameraPermissionStatus: _cameraPermissionStatus,
      notificationPermissionStatus: _notificationPermissionStatus,
    );
  }

  AuthNotificationPermissionUpdatedState _notificationPermissionUpdatedState() {
    return AuthNotificationPermissionUpdatedState(
      session: _session,
      nextRoute: _nextRoute,
      cameraPermissionStatus: _cameraPermissionStatus,
      notificationPermissionStatus: _notificationPermissionStatus,
    );
  }

  AuthOnboardingCompletedState _onboardingCompletedState() {
    return AuthOnboardingCompletedState(
      session: _session,
      nextRoute: _nextRoute,
      cameraPermissionStatus: _cameraPermissionStatus,
      notificationPermissionStatus: _notificationPermissionStatus,
    );
  }

  AuthSignedInState _signedInState() {
    return AuthSignedInState(
      session: _session,
      nextRoute: _nextRoute,
      cameraPermissionStatus: _cameraPermissionStatus,
      notificationPermissionStatus: _notificationPermissionStatus,
    );
  }

  AuthSignedOutState _signedOutState() {
    return AuthSignedOutState(
      session: _session,
      nextRoute: _nextRoute,
      cameraPermissionStatus: _cameraPermissionStatus,
      notificationPermissionStatus: _notificationPermissionStatus,
    );
  }

  AuthFailureState _failureState({required String message}) {
    return AuthFailureState(
      session: _session,
      nextRoute: _nextRoute,
      cameraPermissionStatus: _cameraPermissionStatus,
      notificationPermissionStatus: _notificationPermissionStatus,
      errorMessage: message,
    );
  }

  void _syncResolvedState() {
    final currentState = state;
    if (currentState is! AuthResolvedState) {
      return;
    }

    _session = currentState.session;
    _nextRoute = currentState.nextRoute;
    _cameraPermissionStatus = currentState.cameraPermissionStatus;
    _notificationPermissionStatus = currentState.notificationPermissionStatus;
  }
}
