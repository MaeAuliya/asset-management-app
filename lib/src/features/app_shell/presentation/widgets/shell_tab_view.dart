import 'package:flutter/material.dart';

import '../../../../core/extensions/context_extension.dart';
import '../../../../core/res/typography.dart';
import 'foundation_bullet.dart';
import 'shell_destination.dart';

class ShellTabView extends StatelessWidget {
  const ShellTabView({
    required this.shellTitle,
    required this.destination,
    super.key,
  });

  final String shellTitle;
  final ShellDestination destination;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(24 * context.widthScale),
      children: [
        CoreText(
          shellTitle,
          role: TextRole.labelLg,
          color: context.colorScheme.primary,
        ),
        SizedBox(height: 8 * context.heightScale),
        CoreText(
          destination.title,
          role: TextRole.headlineMd,
        ),
        SizedBox(height: 12 * context.heightScale),
        CoreText(
          destination.description,
          role: TextRole.bodyLg,
          color: context.colorScheme.onSurfaceVariant,
        ),
        SizedBox(height: 24 * context.heightScale),
        Card(
          child: Padding(
            padding: EdgeInsets.all(20 * context.widthScale),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CoreText(
                  'Current foundation state',
                  role: TextRole.titleMd,
                ),
                SizedBox(height: 12 * context.heightScale),
                const FoundationBullet(
                  text: 'Feature module folder structure is already in place.',
                ),
                const FoundationBullet(
                  text: 'Route entry points now reflect the approved roadmap.',
                ),
                const FoundationBullet(
                  text:
                      'Shared enums exist for role, assets, borrowing, approvals, and notifications.',
                ),
                SizedBox(height: 16 * context.heightScale),
                Container(
                  padding: EdgeInsets.all(12 * context.widthScale),
                  decoration: BoxDecoration(
                    color: context.colorScheme.surfaceContainerLow,
                    borderRadius: BorderRadius.circular(
                      12 * context.widthScale,
                    ),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.flag_outlined,
                        color: context.colorScheme.primary,
                      ),
                      SizedBox(width: 12 * context.widthScale),
                      Expanded(
                        child: CoreText(
                          destination.milestone,
                          role: TextRole.bodyMd,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
