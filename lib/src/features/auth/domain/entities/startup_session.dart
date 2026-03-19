import 'package:equatable/equatable.dart';

import '../../../../core/enums/user_role.dart';

class StartupSession extends Equatable {
  const StartupSession({
    required this.isFirstOpen,
    required this.isOnboardingCompleted,
    required this.isSignedIn,
    required this.role,
  });

  final bool isFirstOpen;
  final bool isOnboardingCompleted;
  final bool isSignedIn;
  final UserRole? role;

  StartupSession copyWith({
    bool? isFirstOpen,
    bool? isOnboardingCompleted,
    bool? isSignedIn,
    UserRole? role,
    bool clearRole = false,
  }) {
    return StartupSession(
      isFirstOpen: isFirstOpen ?? this.isFirstOpen,
      isOnboardingCompleted:
          isOnboardingCompleted ?? this.isOnboardingCompleted,
      isSignedIn: isSignedIn ?? this.isSignedIn,
      role: clearRole ? null : role ?? this.role,
    );
  }

  @override
  List<Object?> get props => [
    isFirstOpen,
    isOnboardingCompleted,
    isSignedIn,
    role,
  ];
}
