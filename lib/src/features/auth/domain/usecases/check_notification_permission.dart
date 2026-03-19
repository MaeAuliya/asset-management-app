import '../../../../core/enums/app_permission_status.dart';
import '../../../../core/usecases/usecase.dart';
import '../../../../core/utils/typedef.dart';
import '../repositories/permission_repository.dart';

class CheckNotificationPermission
    extends UseCaseWithoutParams<AppPermissionStatus> {
  const CheckNotificationPermission(this._permissionRepository);

  final PermissionRepository _permissionRepository;

  @override
  ResultFuture<AppPermissionStatus> call() =>
      _permissionRepository.checkNotificationPermission();
}
