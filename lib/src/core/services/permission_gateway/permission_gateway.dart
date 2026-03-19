import 'package:permission_handler/permission_handler.dart';

import '../../enums/app_permission_status.dart';

abstract class PermissionGateway {
  Future<AppPermissionStatus> checkCameraPermission();

  Future<AppPermissionStatus> requestCameraPermission();

  Future<AppPermissionStatus> checkNotificationPermission();

  Future<AppPermissionStatus> requestNotificationPermission();

  Future<bool> openSettings();
}

class PermissionGatewayImpl implements PermissionGateway {
  @override
  Future<AppPermissionStatus> checkCameraPermission() async {
    final status = await Permission.camera.status;
    return _mapStatus(status);
  }

  @override
  Future<AppPermissionStatus> requestCameraPermission() async {
    final status = await Permission.camera.request();
    return _mapStatus(status);
  }

  @override
  Future<AppPermissionStatus> checkNotificationPermission() async {
    final status = await Permission.notification.status;
    return _mapStatus(status);
  }

  @override
  Future<AppPermissionStatus> requestNotificationPermission() async {
    final status = await Permission.notification.request();
    return _mapStatus(status);
  }

  @override
  Future<bool> openSettings() => openAppSettings();

  AppPermissionStatus _mapStatus(PermissionStatus status) {
    switch (status) {
      case PermissionStatus.granted:
        return AppPermissionStatus.granted;
      case PermissionStatus.denied:
        return AppPermissionStatus.denied;
      case PermissionStatus.permanentlyDenied:
        return AppPermissionStatus.permanentlyDenied;
      case PermissionStatus.restricted:
        return AppPermissionStatus.restricted;
      case PermissionStatus.limited:
        return AppPermissionStatus.limited;
      case PermissionStatus.provisional:
        return AppPermissionStatus.provisional;
    }
  }
}
