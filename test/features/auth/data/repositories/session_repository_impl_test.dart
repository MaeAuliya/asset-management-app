import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../../lib/src/core/enums/user_role.dart';
import '../../../../../lib/src/core/errors/exception.dart';
import '../../../../../lib/src/core/errors/failure.dart';
import '../../../../../lib/src/features/auth/data/datasources/session_local_data_source.dart';
import '../../../../../lib/src/features/auth/data/repositories/session_repository_impl.dart';
import '../../../../../lib/src/features/auth/domain/entities/startup_session.dart';

class MockSessionLocalDataSource extends Mock implements SessionLocalDataSource {}

void main() {
  late SessionLocalDataSource localDataSource;
  late SessionRepositoryImpl repository;

  setUp(() {
    localDataSource = MockSessionLocalDataSource();
    repository = SessionRepositoryImpl(localDataSource);
  });

  group('getStartupSession', () {
    test('returns Right when local reads succeed', () async {
      when(() => localDataSource.isFirstOpen()).thenAnswer((_) async => false);
      when(
        () => localDataSource.isOnboardingCompleted(),
      ).thenAnswer((_) async => true);
      when(() => localDataSource.isSignedIn()).thenAnswer((_) async => true);
      when(
        () => localDataSource.getSignedInRole(),
      ).thenAnswer((_) async => UserRole.admin);

      final result = await repository.getStartupSession();

      expect(
        result,
        const Right(
          StartupSession(
            isFirstOpen: false,
            isOnboardingCompleted: true,
            isSignedIn: true,
            role: UserRole.admin,
          ),
        ),
      );
    });

    test('returns Left(LocalFailure) when local read throws', () async {
      when(
        () => localDataSource.isFirstOpen(),
      ).thenThrow(const LocalException(message: 'boom'));

      final result = await repository.getStartupSession();

      expect(result, const Left(LocalFailure(message: 'boom', statusCode: 500)));
    });
  });

  group('completeOnboarding', () {
    test('returns Right(null) when local save succeeds', () async {
      when(() => localDataSource.completeOnboarding()).thenAnswer((_) async {});

      final result = await repository.completeOnboarding();

      expect(result, const Right(null));
    });
  });

  group('saveSignedInRole', () {
    test('returns Left(LocalFailure) when local save throws', () async {
      when(
        () => localDataSource.saveSignedInRole(UserRole.user),
      ).thenThrow(const LocalException(message: 'save failed'));

      final result = await repository.saveSignedInRole(UserRole.user);

      expect(
        result,
        const Left(LocalFailure(message: 'save failed', statusCode: 500)),
      );
    });
  });

  group('clearSession', () {
    test('returns Right(null) when local clear succeeds', () async {
      when(() => localDataSource.clearSession()).thenAnswer((_) async {});

      final result = await repository.clearSession();

      expect(result, const Right(null));
    });
  });
}
