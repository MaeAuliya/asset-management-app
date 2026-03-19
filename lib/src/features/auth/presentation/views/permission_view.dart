import 'package:flutter/material.dart';

import '../../../../core/enums/app_permission_status.dart';
import '../widgets/permission_screen_layout.dart';

class PermissionView extends StatelessWidget {
  const PermissionView({
    required this.stepText,
    required this.heroIcon,
    required this.heroTitle,
    required this.description,
    required this.status,
    required this.primaryLabel,
    required this.onPrimaryPressed,
    required this.onContinuePressed,
    required this.onOpenSettingsPressed,
    super.key,
  });

  final String stepText;
  final IconData heroIcon;
  final String heroTitle;
  final String description;
  final AppPermissionStatus? status;
  final String primaryLabel;
  final VoidCallback onPrimaryPressed;
  final VoidCallback onContinuePressed;
  final VoidCallback onOpenSettingsPressed;

  @override
  Widget build(BuildContext context) {
    return PermissionScreenLayout(
      stepText: stepText,
      heroIcon: heroIcon,
      heroTitle: heroTitle,
      description: description,
      status: status,
      primaryLabel: primaryLabel,
      onPrimaryPressed: onPrimaryPressed,
      onContinuePressed: onContinuePressed,
      onOpenSettingsPressed: onOpenSettingsPressed,
    );
  }
}
