import '../../../../core/enums/app_permission_status.dart';
import '../../../../core/usecases/usecase.dart';
import '../../../../core/utils/typedef.dart';
import '../repositories/permission_repository.dart';

class RequestNotificationPermission
    extends UseCaseWithoutParams<AppPermissionStatus> {
  const RequestNotificationPermission(this._permissionRepository);

  final PermissionRepository _permissionRepository;

  @override
  ResultFuture<AppPermissionStatus> call() =>
      _permissionRepository.requestNotificationPermission();
}
