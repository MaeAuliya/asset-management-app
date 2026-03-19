import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/extensions/context_extension.dart';
import '../bloc/auth_bloc.dart';
import '../views/permission_view.dart';
import 'auth_entry_screen.dart';

class NotificationPermissionScreen extends StatelessWidget {
  const NotificationPermissionScreen({super.key});

  static const routeName = '/onboarding/notification-permission';

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listenWhen: (previous, current) => current is AuthOnboardingCompletedState,
      listener: (context, state) {
        Navigator.pushReplacementNamed(
          context,
          AuthEntryScreen.routeName,
        );
      },
      child: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          final status = switch (state) {
            AuthResolvedState(:final notificationPermissionStatus) =>
              notificationPermissionStatus,
            _ => null,
          };

          return PermissionView(
            stepText: 'Step 3 of 3',
            heroIcon: Icons.notifications_active_outlined,
            heroTitle: 'Notifications for reminders and alerts',
            description:
                'Notifications surface due reminders, overdue risk, and approval updates without forcing users to check the app manually.',
            status: status,
            primaryLabel: 'Allow Notifications',
            onPrimaryPressed: () {
              context.authBloc.add(
                const RequestNotificationPermissionEvent(),
              );
            },
            onContinuePressed: () {
              context.authBloc.add(const CompleteOnboardingEvent());
            },
            onOpenSettingsPressed: () {
              context.authBloc.add(const OpenPermissionSettingsEvent());
            },
          );
        },
      ),
    );
  }
}
