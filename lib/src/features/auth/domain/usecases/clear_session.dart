import '../../../../core/usecases/usecase.dart';
import '../../../../core/utils/typedef.dart';
import '../repositories/session_repository.dart';

class ClearSession extends UseCaseWithoutParams<void> {
  const ClearSession(this._sessionRepository);

  final SessionRepository _sessionRepository;

  @override
  ResultVoid call() => _sessionRepository.clearSession();
}
