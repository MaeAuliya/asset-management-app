import 'package:equatable/equatable.dart';

import '../../../../core/enums/user_role.dart';
import '../../../../core/usecases/usecase.dart';
import '../../../../core/utils/typedef.dart';
import '../repositories/session_repository.dart';

class SaveSignedInRole extends UseCaseWithParams<void, SaveSignedInRoleParams> {
  const SaveSignedInRole(this._sessionRepository);

  final SessionRepository _sessionRepository;

  @override
  ResultVoid call(SaveSignedInRoleParams params) =>
      _sessionRepository.saveSignedInRole(params.role);
}

class SaveSignedInRoleParams extends Equatable {
  const SaveSignedInRoleParams({required this.role});

  final UserRole role;

  @override
  List<Object?> get props => [role];
}
