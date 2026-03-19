import 'package:flutter/material.dart';

import '../../../../core/enums/app_permission_status.dart';
import '../../../../core/extensions/context_extension.dart';
import '../../../../core/res/colours.dart';
import '../../../../core/res/typography.dart';
import '../../../../core/shared/widgets/core_button.dart';
import 'stitch_auth_shell.dart';

class PermissionScreenLayout extends StatelessWidget {
  const PermissionScreenLayout({
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
    return StitchAuthScaffold(
      bottomBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CoreButton(
            text: primaryLabel,
            radius: 20,
            minimumSize: 56,
            backgroundColor: Colours.primaryBlue,
            onPressed: onPrimaryPressed,
          ),
          SizedBox(height: 12 * context.heightScale),
          if (status == AppPermissionStatus.permanentlyDenied) ...[
            CoreButton(
              text: 'Open App Settings',
              radius: 20,
              minimumSize: 54,
              backgroundColor: Colours.white,
              foregroundColor: Colours.primaryBlue,
              borderColor: Colours.blueStroke,
              onPressed: onOpenSettingsPressed,
            ),
            SizedBox(height: 12 * context.heightScale),
          ],
          TextButton(
            onPressed: onContinuePressed,
            child: const CoreText('Continue'),
          ),
        ],
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 440),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const StitchBrandMark(
                    icon: Icons.inventory_2_rounded,
                    label: 'Asset Catalog',
                    subtitle: 'Permission setup',
                  ),
                  StitchStepPill(text: stepText),
                ],
              ),
              SizedBox(height: 28 * context.heightScale),
              StitchSurfaceCard(
                child: Column(
                  children: [
                    Container(
                      width: 116 * context.widthScale,
                      height: 116 * context.widthScale,
                      decoration: BoxDecoration(
                        color: Colours.blueSurfaceStrong,
                        borderRadius: BorderRadius.circular(
                          34 * context.widthScale,
                        ),
                      ),
                      child: Icon(
                        heroIcon,
                        size: 52,
                        color: Colours.primaryBlue,
                      ),
                    ),
                    SizedBox(height: 24 * context.heightScale),
                    CoreText(
                      heroTitle,
                      role: TextRole.headlineMd,
                      color: Colours.blueInk,
                      weight: FontWeight.w700,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 12 * context.heightScale),
                    CoreText(
                      description,
                      role: TextRole.bodyMd,
                      color: context.colorScheme.onSurfaceVariant,
                      height: 1.5,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 22 * context.heightScale),
                    Container(
                      padding: EdgeInsets.all(16 * context.widthScale),
                      decoration: BoxDecoration(
                        color: Colours.blueSurface,
                        borderRadius: BorderRadius.circular(
                          20 * context.widthScale,
                        ),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 38 * context.widthScale,
                            height: 38 * context.widthScale,
                            decoration: BoxDecoration(
                              color: Colours.white,
                              borderRadius: BorderRadius.circular(
                                14 * context.widthScale,
                              ),
                            ),
                            child: Icon(
                              permissionStatusIcon(status),
                              color: permissionStatusColor(status),
                            ),
                          ),
                          SizedBox(width: 12 * context.widthScale),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const CoreText(
                                  'Current status',
                                  role: TextRole.titleSm,
                                  color: Colours.blueInk,
                                  weight: FontWeight.w700,
                                ),
                                SizedBox(height: 4 * context.heightScale),
                                CoreText(
                                  status?.label ?? 'Not requested yet',
                                  role: TextRole.bodyMd,
                                  color: context.colorScheme.onSurfaceVariant,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

IconData permissionStatusIcon(AppPermissionStatus? status) {
  if (status == null) return Icons.shield_outlined;
  if (status.isGranted) return Icons.check_circle_rounded;
  if (status == AppPermissionStatus.permanentlyDenied) {
    return Icons.settings_outlined;
  }
  return Icons.info_outline_rounded;
}

Color permissionStatusColor(AppPermissionStatus? status) {
  if (status == null) return Colours.primaryBlue;
  if (status.isGranted) return Colours.successColor;
  if (status == AppPermissionStatus.permanentlyDenied) {
    return Colours.primaryOrange;
  }
  return Colours.infoColor;
}
