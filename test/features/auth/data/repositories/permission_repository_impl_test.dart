import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../../lib/src/core/enums/app_permission_status.dart';
import '../../../../../lib/src/core/errors/failure.dart';
import '../../../../../lib/src/core/services/permission_gateway/permission_gateway.dart';
import '../../../../../lib/src/features/auth/data/repositories/permission_repository_impl.dart';

class MockPermissionGateway extends Mock implements PermissionGateway {}

void main() {
  late PermissionGateway permissionGateway;
  late PermissionRepositoryImpl repository;

  setUp(() {
    permissionGateway = MockPermissionGateway();
    repository = PermissionRepositoryImpl(permissionGateway);
  });

  test('requestCameraPermission returns Right when gateway succeeds', () async {
    when(
      () => permissionGateway.requestCameraPermission(),
    ).thenAnswer((_) async => AppPermissionStatus.granted);

    final result = await repository.requestCameraPermission();

    expect(result, const Right(AppPermissionStatus.granted));
  });

  test('openSettings returns Left(LocalFailure) when gateway returns false', () async {
    when(() => permissionGateway.openSettings()).thenAnswer((_) async => false);

    final result = await repository.openSettings();

    expect(
      result,
      const Left(
        LocalFailure(
          message: 'Unable to open app settings.',
          statusCode: 500,
        ),
      ),
    );
  });
}
