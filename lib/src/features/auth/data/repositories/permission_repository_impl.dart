import 'package:dartz/dartz.dart';

import '../../../../core/errors/exception.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/services/permission_gateway/permission_gateway.dart';
import '../../../../core/utils/typedef.dart';
import '../../../../core/enums/app_permission_status.dart';
import '../../domain/repositories/permission_repository.dart';

class PermissionRepositoryImpl implements PermissionRepository {
  const PermissionRepositoryImpl(this._permissionGateway);

  final PermissionGateway _permissionGateway;

  @override
  ResultFuture<AppPermissionStatus> checkCameraPermission() async {
    try {
      final status = await _permissionGateway.checkCameraPermission();
      return Right(status);
    } catch (_) {
      return const Left(
        LocalFailure(
          message: 'Unable to read camera permission status.',
          statusCode: 500,
        ),
      );
    }
  }

  @override
  ResultFuture<AppPermissionStatus> requestCameraPermission() async {
    try {
      final status = await _permissionGateway.requestCameraPermission();
      return Right(status);
    } catch (_) {
      return const Left(
        LocalFailure(
          message: 'Unable to request camera permission.',
          statusCode: 500,
        ),
      );
    }
  }

  @override
  ResultFuture<AppPermissionStatus> checkNotificationPermission() async {
    try {
      final status = await _permissionGateway.checkNotificationPermission();
      return Right(status);
    } catch (_) {
      return const Left(
        LocalFailure(
          message: 'Unable to read notification permission status.',
          statusCode: 500,
        ),
      );
    }
  }

  @override
  ResultFuture<AppPermissionStatus> requestNotificationPermission() async {
    try {
      final status = await _permissionGateway.requestNotificationPermission();
      return Right(status);
    } catch (_) {
      return const Left(
        LocalFailure(
          message: 'Unable to request notification permission.',
          statusCode: 500,
        ),
      );
    }
  }

  @override
  ResultVoid openSettings() async {
    try {
      final opened = await _permissionGateway.openSettings();
      if (!opened) {
        throw const LocalException(
          message: 'Unable to open app settings.',
        );
      }

      return const Right(null);
    } on LocalException catch (exception) {
      return Left(LocalFailure.fromException(exception));
    } catch (_) {
      return const Left(
        LocalFailure(
          message: 'Unable to open app settings.',
          statusCode: 500,
        ),
      );
    }
  }
}
