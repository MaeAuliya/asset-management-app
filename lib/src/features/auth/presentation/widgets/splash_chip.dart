import 'package:flutter/material.dart';

import '../../../../core/extensions/context_extension.dart';
import '../../../../core/res/colours.dart';
import '../../../../core/res/typography.dart';

class SplashChip extends StatelessWidget {
  const SplashChip({
    required this.text,
    super.key,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 12 * context.widthScale,
        vertical: 8 * context.heightScale,
      ),
      decoration: BoxDecoration(
        color: Colours.white.withValues(alpha: 0.9),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: Colours.blueStroke),
      ),
      child: CoreText(
        text,
        role: TextRole.labelMd,
        color: Colours.blueInk,
      ),
    );
  }
}
