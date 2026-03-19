import 'package:flutter/material.dart';

import '../../../../core/extensions/context_extension.dart';
import '../../../../core/res/colours.dart';
import '../../../../core/res/typography.dart';
import 'glow_orb.dart';

class StitchAuthScaffold extends StatelessWidget {
  const StitchAuthScaffold({
    required this.child,
    super.key,
    this.bottomBar,
  });

  final Widget child;
  final Widget? bottomBar;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DecoratedBox(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colours.gray50,
              Colours.blueSurface,
              Colours.white,
            ],
          ),
        ),
        child: Stack(
          children: [
            const Positioned(
              top: -70,
              right: -32,
              child: GlowOrb(
                size: 196,
                color: Colours.blueSurfaceStrong,
              ),
            ),
            const Positioned(
              top: 112,
              left: -54,
              child: GlowOrb(
                size: 146,
                color: Color(0xB5EAF2FF),
              ),
            ),
            const Positioned(
              bottom: -38,
              right: 28,
              child: GlowOrb(
                size: 138,
                color: Color(0x66DDE8FF),
              ),
            ),
            SafeArea(
              child: Column(
                children: [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 24 * context.widthScale,
                        vertical: 20 * context.heightScale,
                      ),
                      child: child,
                    ),
                  ),
                  if (bottomBar != null)
                    SafeArea(
                      top: false,
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(
                          24 * context.widthScale,
                          0,
                          24 * context.widthScale,
                          24 * context.heightScale,
                        ),
                        child: bottomBar!,
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class StitchSurfaceCard extends StatelessWidget {
  const StitchSurfaceCard({
    required this.child,
    super.key,
    this.padding = const EdgeInsets.all(24),
  });

  final Widget child;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.92),
        borderRadius: BorderRadius.circular(28 * context.widthScale),
        border: Border.all(color: Colours.blueStroke.withValues(alpha: 0.55)),
        boxShadow: const [
          BoxShadow(
            color: Color(0x12052A68),
            blurRadius: 32,
            offset: Offset(0, 18),
          ),
        ],
      ),
      child: child,
    );
  }
}

class StitchBrandMark extends StatelessWidget {
  const StitchBrandMark({
    required this.icon,
    required this.label,
    super.key,
    this.subtitle,
    this.onLongPress,
  });

  final IconData icon;
  final String label;
  final String? subtitle;
  final VoidCallback? onLongPress;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: onLongPress,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 52 * context.widthScale,
            height: 52 * context.widthScale,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18 * context.widthScale),
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Colours.primaryBlue, Colours.secondaryBlue],
              ),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x220047AB),
                  blurRadius: 20,
                  offset: Offset(0, 10),
                ),
              ],
            ),
            child: Icon(icon, color: Colours.white, size: 28),
          ),
          SizedBox(width: 14 * context.widthScale),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CoreText(
                label,
                role: TextRole.titleMd,
                color: Colours.blueInk,
                weight: FontWeight.w700,
              ),
              if (subtitle != null)
                CoreText(
                  subtitle!,
                  role: TextRole.bodySm,
                  color: context.colorScheme.onSurfaceVariant,
                ),
            ],
          ),
        ],
      ),
    );
  }
}

class StitchStepPill extends StatelessWidget {
  const StitchStepPill({
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
        color: Colours.white.withValues(alpha: 0.82),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: Colours.blueStroke),
      ),
      child: CoreText(
        text,
        role: TextRole.labelMd,
        color: Colours.blueInk,
        weight: FontWeight.w700,
      ),
    );
  }
}
