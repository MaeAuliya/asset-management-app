import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../../lib/src/core/enums/app_permission_status.dart';
import '../../../../../lib/src/core/enums/user_role.dart';
import '../../../../../lib/src/core/errors/failure.dart';
import '../../../../../lib/src/features/auth/domain/entities/startup_session.dart';
import '../../../../../lib/src/features/auth/domain/usecases/check_camera_permission.dart';
import '../../../../../lib/src/features/auth/domain/usecases/check_notification_permission.dart';
import '../../../../../lib/src/features/auth/domain/usecases/clear_session.dart';
import '../../../../../lib/src/features/auth/domain/usecases/complete_onboarding.dart';
import '../../../../../lib/src/features/auth/domain/usecases/get_startup_session.dart';
import '../../../../../lib/src/features/auth/domain/usecases/open_permission_settings.dart';
import '../../../../../lib/src/features/auth/domain/usecases/request_camera_permission.dart';
import '../../../../../lib/src/features/auth/domain/usecases/request_notification_permission.dart';
import '../../../../../lib/src/features/auth/domain/usecases/save_signed_in_role.dart';
import '../../../../../lib/src/features/auth/presentation/bloc/auth_bloc.dart';

class MockGetStartupSession extends Mock implements GetStartupSession {}

class MockCheckCameraPermission extends Mock implements CheckCameraPermission {}

class MockCheckNotificationPermission extends Mock
    implements CheckNotificationPermission {}

class MockRequestCameraPermission extends Mock
    implements RequestCameraPermission {}

class MockRequestNotificationPermission extends Mock
    implements RequestNotificationPermission {}

class MockOpenPermissionSettings extends Mock
    implements OpenPermissionSettings {}

class MockCompleteOnboarding extends Mock implements CompleteOnboarding {}

class MockSaveSignedInRole extends Mock implements SaveSignedInRole {}

class MockClearSession extends Mock implements ClearSession {}

void main() {
  late GetStartupSession getStartupSession;
  late CheckCameraPermission checkCameraPermission;
  late CheckNotificationPermission checkNotificationPermission;
  late RequestCameraPermission requestCameraPermission;
  late RequestNotificationPermission requestNotificationPermission;
  late OpenPermissionSettings openPermissionSettings;
  late CompleteOnboarding completeOnboarding;
  late SaveSignedInRole saveSignedInRole;
  late ClearSession clearSession;

  const session = StartupSession(
    isFirstOpen: false,
    isOnboardingCompleted: true,
    isSignedIn: false,
    role: null,
  );

  setUpAll(() {
    registerFallbackValue(
      const SaveSignedInRoleParams(role: UserRole.user),
    );
  });

  setUp(() {
    getStartupSession = MockGetStartupSession();
    checkCameraPermission = MockCheckCameraPermission();
    checkNotificationPermission = MockCheckNotificationPermission();
    requestCameraPermission = MockRequestCameraPermission();
    requestNotificationPermission = MockRequestNotificationPermission();
    openPermissionSettings = MockOpenPermissionSettings();
    completeOnboarding = MockCompleteOnboarding();
    saveSignedInRole = MockSaveSignedInRole();
    clearSession = MockClearSession();
  });

  AuthBloc buildBloc() {
    return AuthBloc(
      getStartupSession,
      checkCameraPermission,
      checkNotificationPermission,
      requestCameraPermission,
      requestNotificationPermission,
      openPermissionSettings,
      completeOnboarding,
      saveSignedInRole,
      clearSession,
    );
  }

  blocTest<AuthBloc, AuthState>(
    'InitializeAuthEvent emits loading then ready state',
    build: () {
      when(() => getStartupSession()).thenAnswer((_) async => const Right(session));
      when(
        () => checkCameraPermission(),
      ).thenAnswer((_) async => const Right(AppPermissionStatus.granted));
      when(
        () => checkNotificationPermission(),
      ).thenAnswer((_) async => const Right(AppPermissionStatus.denied));
      return buildBloc();
    },
    act: (bloc) => bloc.add(const InitializeAuthEvent()),
    expect: () => [
      const AuthLoadingState(
        session: StartupSession(
          isFirstOpen: true,
          isOnboardingCompleted: false,
          isSignedIn: false,
          role: null,
        ),
        nextRoute: AuthRouteTarget.splash,
        cameraPermissionStatus: null,
        notificationPermissionStatus: null,
      ),
      const AuthReadyState(
        session: session,
        nextRoute: AuthRouteTarget.authEntry,
        cameraPermissionStatus: AppPermissionStatus.granted,
        notificationPermissionStatus: AppPermissionStatus.denied,
      ),
    ],
  );

  blocTest<AuthBloc, AuthState>(
    'CompleteOnboardingEvent emits loading then onboarding completed state',
    build: () {
      when(() => completeOnboarding()).thenAnswer((_) async => const Right(null));
      return buildBloc();
    },
    seed: () => const AuthReadyState(
      session: StartupSession(
        isFirstOpen: true,
        isOnboardingCompleted: false,
        isSignedIn: false,
        role: null,
      ),
      nextRoute: AuthRouteTarget.onboardingWelcome,
      cameraPermissionStatus: AppPermissionStatus.granted,
      notificationPermissionStatus: AppPermissionStatus.denied,
    ),
    act: (bloc) => bloc.add(const CompleteOnboardingEvent()),
    expect: () => [
      const AuthLoadingState(
        session: StartupSession(
          isFirstOpen: true,
          isOnboardingCompleted: false,
          isSignedIn: false,
          role: null,
        ),
        nextRoute: AuthRouteTarget.onboardingWelcome,
        cameraPermissionStatus: AppPermissionStatus.granted,
        notificationPermissionStatus: AppPermissionStatus.denied,
      ),
      const AuthOnboardingCompletedState(
        session: StartupSession(
          isFirstOpen: false,
          isOnboardingCompleted: true,
          isSignedIn: false,
          role: null,
        ),
        nextRoute: AuthRouteTarget.authEntry,
        cameraPermissionStatus: AppPermissionStatus.granted,
        notificationPermissionStatus: AppPermissionStatus.denied,
      ),
    ],
  );

  blocTest<AuthBloc, AuthState>(
    'SubmitSignInEvent emits loading then signed in state',
    build: () {
      when(
        () => saveSignedInRole(any()),
      ).thenAnswer((_) async => const Right(null));
      return buildBloc();
    },
    act: (bloc) => bloc.add(
      const SubmitSignInEvent(
        identifier: 'admin@company.com',
        password: 'secret',
        role: UserRole.admin,
      ),
    ),
    expect: () => [
      const AuthLoadingState(
        session: StartupSession(
          isFirstOpen: true,
          isOnboardingCompleted: false,
          isSignedIn: false,
          role: null,
        ),
        nextRoute: AuthRouteTarget.splash,
        cameraPermissionStatus: null,
        notificationPermissionStatus: null,
      ),
      const AuthSignedInState(
        session: StartupSession(
          isFirstOpen: false,
          isOnboardingCompleted: true,
          isSignedIn: true,
          role: UserRole.admin,
        ),
        nextRoute: AuthRouteTarget.adminShell,
        cameraPermissionStatus: null,
        notificationPermissionStatus: null,
      ),
    ],
  );

  blocTest<AuthBloc, AuthState>(
    'SignOutEvent emits failure state when clear session fails',
    build: () {
      when(
        () => clearSession(),
      ).thenAnswer(
        (_) async => const Left(
          LocalFailure(message: 'Unable to sign out.', statusCode: 500),
        ),
      );
      return buildBloc();
    },
    act: (bloc) => bloc.add(const SignOutEvent()),
    expect: () => [
      const AuthLoadingState(
        session: StartupSession(
          isFirstOpen: true,
          isOnboardingCompleted: false,
          isSignedIn: false,
          role: null,
        ),
        nextRoute: AuthRouteTarget.splash,
        cameraPermissionStatus: null,
        notificationPermissionStatus: null,
      ),
      const AuthFailureState(
        session: StartupSession(
          isFirstOpen: true,
          isOnboardingCompleted: false,
          isSignedIn: false,
          role: null,
        ),
        nextRoute: AuthRouteTarget.splash,
        cameraPermissionStatus: null,
        notificationPermissionStatus: null,
        errorMessage: 'Unable to sign out.',
      ),
    ],
  );
}
