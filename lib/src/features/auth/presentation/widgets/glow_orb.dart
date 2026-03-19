import 'package:flutter/material.dart';

class GlowOrb extends StatelessWidget {
  const GlowOrb({
    required this.size,
    required this.color,
    super.key,
  });

  final double size;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: color,
        ),
      ),
    );
  }
}
