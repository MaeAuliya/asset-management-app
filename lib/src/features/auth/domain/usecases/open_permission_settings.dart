import '../../../../core/usecases/usecase.dart';
import '../../../../core/utils/typedef.dart';
import '../repositories/permission_repository.dart';

class OpenPermissionSettings extends UseCaseWithoutParams<void> {
  const OpenPermissionSettings(this._permissionRepository);

  final PermissionRepository _permissionRepository;

  @override
  ResultVoid call() => _permissionRepository.openSettings();
}
