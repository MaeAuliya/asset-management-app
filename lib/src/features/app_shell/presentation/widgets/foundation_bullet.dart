import 'package:flutter/material.dart';

import '../../../../core/extensions/context_extension.dart';
import '../../../../core/res/typography.dart';

class FoundationBullet extends StatelessWidget {
  const FoundationBullet({
    required this.text,
    super.key,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8 * context.heightScale),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 3 * context.heightScale),
            child: const Icon(Icons.check_circle_outline_rounded, size: 18),
          ),
          SizedBox(width: 10 * context.widthScale),
          Expanded(
            child: CoreText(
              text,
              role: TextRole.bodyMd,
            ),
          ),
        ],
      ),
    );
  }
}
