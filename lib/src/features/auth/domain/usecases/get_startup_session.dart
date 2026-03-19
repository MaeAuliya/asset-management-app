import '../../../../core/usecases/usecase.dart';
import '../../../../core/utils/typedef.dart';
import '../entities/startup_session.dart';
import '../repositories/session_repository.dart';

class GetStartupSession extends UseCaseWithoutParams<StartupSession> {
  const GetStartupSession(this._sessionRepository);

  final SessionRepository _sessionRepository;

  @override
  ResultFuture<StartupSession> call() => _sessionRepository.getStartupSession();
}
