import 'package:flutter/material.dart';

import '../../../../core/extensions/context_extension.dart';
import '../../../../core/res/colours.dart';
import '../../../../core/res/typography.dart';

class WelcomePoint extends StatelessWidget {
  const WelcomePoint({
    required this.title,
    required this.subtitle,
    super.key,
  });

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 34 * context.widthScale,
          height: 34 * context.widthScale,
          decoration: BoxDecoration(
            color: Colours.blueSurfaceStrong,
            borderRadius: BorderRadius.circular(12 * context.widthScale),
          ),
          child: const Icon(
            Icons.check_rounded,
            size: 18,
            color: Colours.primaryBlue,
          ),
        ),
        SizedBox(width: 14 * context.widthScale),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CoreText(
                title,
                role: TextRole.titleMd,
                color: Colours.blueInk,
                weight: FontWeight.w700,
              ),
              SizedBox(height: 4 * context.heightScale),
              CoreText(
                subtitle,
                role: TextRole.bodyMd,
                color: context.colorScheme.onSurfaceVariant,
                height: 1.45,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
