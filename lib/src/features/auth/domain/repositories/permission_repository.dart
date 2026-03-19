import '../../../../core/enums/app_permission_status.dart';
import '../../../../core/utils/typedef.dart';

abstract class PermissionRepository {
  ResultFuture<AppPermissionStatus> checkCameraPermission();

  ResultFuture<AppPermissionStatus> requestCameraPermission();

  ResultFuture<AppPermissionStatus> checkNotificationPermission();

  ResultFuture<AppPermissionStatus> requestNotificationPermission();

  ResultVoid openSettings();
}
