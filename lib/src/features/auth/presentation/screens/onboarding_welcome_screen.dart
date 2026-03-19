import 'package:flutter/material.dart';

import '../views/onboarding_welcome_view.dart';
import 'camera_permission_screen.dart';

class OnboardingWelcomeScreen extends StatelessWidget {
  const OnboardingWelcomeScreen({super.key});

  static const routeName = '/onboarding/welcome';

  @override
  Widget build(BuildContext context) {
    return OnboardingWelcomeView(
      onContinue: () {
        Navigator.pushReplacementNamed(
          context,
          CameraPermissionScreen.routeName,
        );
      },
    );
  }
}
