import 'package:flutter/material.dart';

import '../../../../core/extensions/context_extension.dart';
import '../../../../core/res/colours.dart';
import '../../../../core/res/typography.dart';
import '../../../../core/shared/widgets/core_button.dart';
import '../widgets/stitch_auth_shell.dart';
import '../widgets/welcome_point.dart';

class OnboardingWelcomeView extends StatelessWidget {
  const OnboardingWelcomeView({
    required this.onContinue,
    super.key,
  });

  final VoidCallback onContinue;

  @override
  Widget build(BuildContext context) {
    return StitchAuthScaffold(
      bottomBar: CoreButton(
        text: 'Continue',
        radius: 20,
        minimumSize: 56,
        backgroundColor: Colours.primaryBlue,
        onPressed: onContinue,
      ),
      child: SingleChildScrollView(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 440),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    StitchBrandMark(
                      icon: Icons.inventory_2_rounded,
                      label: 'Asset Catalog',
                      subtitle: 'First-time setup',
                    ),
                    StitchStepPill(text: 'Step 1 of 3'),
                  ],
                ),
                SizedBox(height: 28 * context.heightScale),
                Container(
                  height: 300 * context.heightScale,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      32 * context.widthScale,
                    ),
                    gradient: const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [Colours.primaryBlue, Colours.darkBlue],
                    ),
                  ),
                  child: Stack(
                    children: [
                      Positioned(
                        top: -18,
                        right: -12,
                        child: Container(
                          width: 122 * context.widthScale,
                          height: 122 * context.widthScale,
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.12),
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: -40,
                        left: -22,
                        child: Container(
                          width: 140 * context.widthScale,
                          height: 140 * context.widthScale,
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.08),
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(28 * context.widthScale),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 12 * context.widthScale,
                                vertical: 8 * context.heightScale,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white.withValues(alpha: 0.14),
                                borderRadius: BorderRadius.circular(999),
                              ),
                              child: const CoreText(
                                'Mobile-first borrowing',
                                role: TextRole.labelLg,
                                color: Colours.white,
                              ),
                            ),
                            const Spacer(),
                            const Icon(
                              Icons.qr_code_scanner_rounded,
                              color: Colours.white,
                              size: 42,
                            ),
                            SizedBox(height: 12 * context.heightScale),
                            const CoreText(
                              'Fast office asset borrowing, built for daily operations.',
                              role: TextRole.headlineMd,
                              color: Colours.white,
                              weight: FontWeight.w700,
                              maxLines: 4,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 28 * context.heightScale),
                CoreText(
                  'Scan-first navigation, clear reminders, and structured approvals are already reflected in the approved Stitch flow.',
                  role: TextRole.bodyLg,
                  color: context.colorScheme.onSurfaceVariant,
                  height: 1.5,
                ),
                SizedBox(height: 20 * context.heightScale),
                const StitchSurfaceCard(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    children: [
                      WelcomePoint(
                        title: 'Borrow faster',
                        subtitle:
                            'Use barcode scan as the shortest path to a single-item borrowing flow.',
                      ),
                      SizedBox(height: 16),
                      WelcomePoint(
                        title: 'Stay informed',
                        subtitle:
                            'Receive due reminders, overdue alerts, and approval updates in one mobile experience.',
                      ),
                      SizedBox(height: 16),
                      WelcomePoint(
                        title: 'Keep operations clear',
                        subtitle:
                            'Separate user and admin experiences without losing visibility into status and urgency.',
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
