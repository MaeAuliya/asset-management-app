import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/extensions/context_extension.dart';
import '../bloc/auth_bloc.dart';
import '../views/splash_view.dart';
import '../../../app_shell/presentation/screens/admin_shell_screen.dart';
import '../../../app_shell/presentation/screens/user_shell_screen.dart';
import 'auth_entry_screen.dart';
import 'onboarding_welcome_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  static const routeName = '/';

  @override
  State<SplashScreen> createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  bool _navigationHandled = false;

  @override
  void initState() {
    context.authBloc.add(const InitializeAuthEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listenWhen: (previous, current) =>
          current is AuthReadyState || current is AuthFailureState,
      listener: (context, state) {
        if (_navigationHandled || state is! AuthReadyState) {
          return;
        }

        final routeName = switch (state.nextRoute) {
          AuthRouteTarget.splash => null,
          AuthRouteTarget.onboardingWelcome =>
            OnboardingWelcomeScreen.routeName,
          AuthRouteTarget.authEntry => AuthEntryScreen.routeName,
          AuthRouteTarget.userShell => UserShellScreen.routeName,
          AuthRouteTarget.adminShell => AdminShellScreen.routeName,
        };

        if (routeName == null) return;

        _navigationHandled = true;
        Navigator.pushReplacementNamed(context, routeName);
      },
      child: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          return SplashView(
            state: state,
            onRetry: () {
              _navigationHandled = false;
              context.authBloc.add(const InitializeAuthEvent());
            },
          );
        },
      ),
    );
  }
}
