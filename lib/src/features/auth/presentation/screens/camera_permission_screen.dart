import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/extensions/context_extension.dart';
import '../bloc/auth_bloc.dart';
import '../views/permission_view.dart';
import 'notification_permission_screen.dart';

class CameraPermissionScreen extends StatelessWidget {
  const CameraPermissionScreen({super.key});

  static const routeName = '/onboarding/camera-permission';

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        final status = switch (state) {
          AuthResolvedState(:final cameraPermissionStatus) =>
            cameraPermissionStatus,
          _ => null,
        };

        return PermissionView(
          stepText: 'Step 2 of 3',
          heroIcon: Icons.qr_code_scanner_rounded,
          heroTitle: 'Camera access for barcode scan',
          description:
              'Camera access powers fast asset lookup for borrowing and return flows. You can continue even if you deny it for now.',
          status: status,
          primaryLabel: 'Allow Camera Access',
          onPrimaryPressed: () {
            context.authBloc.add(const RequestCameraPermissionEvent());
          },
          onContinuePressed: () {
            Navigator.pushReplacementNamed(
              context,
              NotificationPermissionScreen.routeName,
            );
          },
          onOpenSettingsPressed: () {
            context.authBloc.add(const OpenPermissionSettingsEvent());
          },
        );
      },
    );
  }
}
