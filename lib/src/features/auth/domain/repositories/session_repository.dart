import '../../../../core/enums/user_role.dart';
import '../../../../core/utils/typedef.dart';
import '../entities/startup_session.dart';

abstract class SessionRepository {
  ResultFuture<StartupSession> getStartupSession();

  ResultVoid completeOnboarding();

  ResultVoid saveSignedInRole(UserRole role);

  ResultVoid clearSession();
}
