import 'package:flutter/material.dart';

import '../../../../core/extensions/context_extension.dart';
import '../../../../core/res/colours.dart';
import '../../../../core/res/typography.dart';
import '../../../../core/shared/widgets/core_button.dart';
import '../bloc/auth_bloc.dart';
import '../widgets/splash_chip.dart';
import '../widgets/stitch_auth_shell.dart';

class SplashView extends StatelessWidget {
  const SplashView({
    required this.state,
    required this.onRetry,
    super.key,
  });

  final AuthState state;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    final errorMessage = switch (state) {
      AuthFailureState(:final errorMessage) => errorMessage,
      _ => null,
    };

    return StitchAuthScaffold(
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 420),
          child: StitchSurfaceCard(
            padding: const EdgeInsets.fromLTRB(28, 32, 28, 28),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const StitchBrandMark(
                  icon: Icons.inventory_2_rounded,
                  label: 'Asset Catalog',
                  subtitle: 'Office asset lending',
                ),
                SizedBox(height: 28 * context.heightScale),
                Container(
                  width: 116 * context.widthScale,
                  height: 116 * context.widthScale,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      36 * context.widthScale,
                    ),
                    gradient: const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [Colours.primaryBlue, Colours.secondaryBlue],
                    ),
                  ),
                  child: const Icon(
                    Icons.qr_code_2_rounded,
                    size: 54,
                    color: Colours.white,
                  ),
                ),
                SizedBox(height: 28 * context.heightScale),
                const CoreText(
                  'Track, borrow, and return office assets without the operational noise.',
                  role: TextRole.headlineMd,
                  color: Colours.blueInk,
                  weight: FontWeight.w700,
                  height: 1.2,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 12 * context.heightScale),
                CoreText(
                  'The app is checking first open, onboarding status, and the saved session before routing you forward.',
                  role: TextRole.bodyMd,
                  color: context.colorScheme.onSurfaceVariant,
                  height: 1.5,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 26 * context.heightScale),
                if (errorMessage == null) ...[
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 16 * context.widthScale,
                      vertical: 14 * context.heightScale,
                    ),
                    decoration: BoxDecoration(
                      color: Colours.blueSurface,
                      borderRadius: BorderRadius.circular(
                        18 * context.widthScale,
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(
                          width: 18,
                          height: 18,
                          child: CircularProgressIndicator(strokeWidth: 2.4),
                        ),
                        SizedBox(width: 12 * context.widthScale),
                        const CoreText(
                          'Preparing your workspace',
                          role: TextRole.labelLg,
                          color: Colours.blueInk,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 14 * context.heightScale),
                  const Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    alignment: WrapAlignment.center,
                    children: [
                      SplashChip(text: 'First-open check'),
                      SplashChip(text: 'Onboarding status'),
                      SplashChip(text: 'Saved session'),
                    ],
                  ),
                ] else
                  Container(
                    padding: EdgeInsets.all(20 * context.widthScale),
                    decoration: BoxDecoration(
                      color: Colours.white,
                      borderRadius: BorderRadius.circular(
                        22 * context.widthScale,
                      ),
                      border: Border.all(color: Colours.gray200),
                    ),
                    child: Column(
                      children: [
                        CoreText(
                          errorMessage!,
                          role: TextRole.bodyLg,
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 18 * context.heightScale),
                        CoreButton(
                          text: 'Retry',
                          radius: 18,
                          minimumSize: 52,
                          backgroundColor: Colours.primaryBlue,
                          onPressed: onRetry,
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
