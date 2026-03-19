import '../../../../core/usecases/usecase.dart';
import '../../../../core/utils/typedef.dart';
import '../repositories/session_repository.dart';

class CompleteOnboarding extends UseCaseWithoutParams<void> {
  const CompleteOnboarding(this._sessionRepository);

  final SessionRepository _sessionRepository;

  @override
  ResultVoid call() => _sessionRepository.completeOnboarding();
}
