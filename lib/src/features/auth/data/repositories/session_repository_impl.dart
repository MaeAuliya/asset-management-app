import 'package:dartz/dartz.dart';

import '../../../../core/errors/exception.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/enums/user_role.dart';
import '../../../../core/utils/typedef.dart';
import '../../domain/entities/startup_session.dart';
import '../../domain/repositories/session_repository.dart';
import '../datasources/session_local_data_source.dart';

class SessionRepositoryImpl implements SessionRepository {
  const SessionRepositoryImpl(this._localDataSource);

  final SessionLocalDataSource _localDataSource;

  @override
  ResultFuture<StartupSession> getStartupSession() async {
    try {
      final isFirstOpen = await _localDataSource.isFirstOpen();
      final isOnboardingCompleted = await _localDataSource
          .isOnboardingCompleted();
      final isSignedIn = await _localDataSource.isSignedIn();
      final role = await _localDataSource.getSignedInRole();

      return Right(
        StartupSession(
          isFirstOpen: isFirstOpen,
          isOnboardingCompleted: isOnboardingCompleted,
          isSignedIn: isSignedIn,
          role: role,
        ),
      );
    } on LocalException catch (exception) {
      return Left(LocalFailure.fromException(exception));
    }
  }

  @override
  ResultVoid completeOnboarding() async {
    try {
      await _localDataSource.completeOnboarding();
      return const Right(null);
    } on LocalException catch (exception) {
      return Left(LocalFailure.fromException(exception));
    }
  }

  @override
  ResultVoid saveSignedInRole(UserRole role) async {
    try {
      await _localDataSource.saveSignedInRole(role);
      return const Right(null);
    } on LocalException catch (exception) {
      return Left(LocalFailure.fromException(exception));
    }
  }

  @override
  ResultVoid clearSession() async {
    try {
      await _localDataSource.clearSession();
      return const Right(null);
    } on LocalException catch (exception) {
      return Left(LocalFailure.fromException(exception));
    }
  }
}
