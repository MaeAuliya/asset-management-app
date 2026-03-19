import 'package:flutter/material.dart';

import '../../../../core/enums/user_role.dart';
import '../../../../core/extensions/context_extension.dart';
import '../../../../core/res/colours.dart';
import '../../../../core/res/typography.dart';
import '../../../../core/shared/widgets/core_button.dart';
import '../widgets/auth_field.dart';
import '../widgets/stitch_auth_shell.dart';

class AuthEntryView extends StatelessWidget {
  const AuthEntryView({
    required this.formKey,
    required this.emailController,
    required this.passwordController,
    required this.showPassword,
    required this.showDevControls,
    required this.selectedRole,
    required this.isSubmitting,
    required this.onTogglePassword,
    required this.onToggleDevControls,
    required this.onRoleChanged,
    required this.onSubmit,
    super.key,
  });

  final GlobalKey<FormState> formKey;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final ValueNotifier<bool> showPassword;
  final ValueNotifier<bool> showDevControls;
  final ValueNotifier<UserRole> selectedRole;
  final ValueNotifier<bool> isSubmitting;
  final VoidCallback onTogglePassword;
  final VoidCallback onToggleDevControls;
  final ValueChanged<UserRole> onRoleChanged;
  final VoidCallback onSubmit;

  @override
  Widget build(BuildContext context) {
    return StitchAuthScaffold(
      child: SingleChildScrollView(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 430),
            child: StitchSurfaceCard(
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    StitchBrandMark(
                      icon: Icons.inventory_2_rounded,
                      label: 'Asset Catalog',
                      subtitle: 'Sign in to continue',
                      onLongPress: onToggleDevControls,
                    ),
                    SizedBox(height: 28 * context.heightScale),
                    const CoreText(
                      'Welcome back',
                      role: TextRole.headlineMd,
                      color: Colours.blueInk,
                      weight: FontWeight.w700,
                    ),
                    SizedBox(height: 10 * context.heightScale),
                    CoreText(
                      'Use your office account to access borrowing, reminders, and asset activity.',
                      role: TextRole.bodyMd,
                      color: context.colorScheme.onSurfaceVariant,
                      height: 1.5,
                    ),
                    SizedBox(height: 24 * context.heightScale),
                    AuthField(
                      controller: emailController,
                      label: 'Email or employee ID',
                      hintText: 'name@company.com',
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Enter your email or employee ID.';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16 * context.heightScale),
                    ValueListenableBuilder<bool>(
                      valueListenable: showPassword,
                      builder: (context, isVisible, _) {
                        return AuthField(
                          controller: passwordController,
                          label: 'Password',
                          hintText: 'Enter your password',
                          obscureText: !isVisible,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Enter your password.';
                            }
                            return null;
                          },
                          suffixIcon: IconButton(
                            onPressed: onTogglePassword,
                            icon: Icon(
                              isVisible
                                  ? Icons.visibility_off_outlined
                                  : Icons.visibility_outlined,
                            ),
                          ),
                        );
                      },
                    ),
                    SizedBox(height: 20 * context.heightScale),
                    ValueListenableBuilder<bool>(
                      valueListenable: showDevControls,
                      builder: (context, isVisible, _) {
                        if (!isVisible) return const SizedBox.shrink();

                        return ValueListenableBuilder<UserRole>(
                          valueListenable: selectedRole,
                          builder: (context, role, _) {
                            return Container(
                              margin: EdgeInsets.only(
                                bottom: 20 * context.heightScale,
                              ),
                              padding: EdgeInsets.all(16 * context.widthScale),
                              decoration: BoxDecoration(
                                color: Colours.blueSurface,
                                borderRadius: BorderRadius.circular(
                                  20 * context.widthScale,
                                ),
                                border: Border.all(color: Colours.blueStroke),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const CoreText(
                                    'Local development role',
                                    role: TextRole.titleSm,
                                    color: Colours.blueInk,
                                    weight: FontWeight.w700,
                                  ),
                                  SizedBox(height: 10 * context.heightScale),
                                  SegmentedButton<UserRole>(
                                    segments: const [
                                      ButtonSegment<UserRole>(
                                        value: UserRole.user,
                                        label: CoreText('User'),
                                        icon: Icon(
                                          Icons.person_outline_rounded,
                                        ),
                                      ),
                                      ButtonSegment<UserRole>(
                                        value: UserRole.admin,
                                        label: CoreText('Admin'),
                                        icon: Icon(
                                          Icons.admin_panel_settings_outlined,
                                        ),
                                      ),
                                    ],
                                    selected: {role},
                                    onSelectionChanged: (selection) {
                                      onRoleChanged(selection.first);
                                    },
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      },
                    ),
                    ValueListenableBuilder<bool>(
                      valueListenable: isSubmitting,
                      builder: (context, submitting, _) {
                        return CoreButton(
                          text: submitting ? 'Signing in...' : 'Sign In',
                          radius: 20,
                          minimumSize: 56,
                          backgroundColor: Colours.primaryBlue,
                          isDisable: submitting,
                          onPressed: onSubmit,
                        );
                      },
                    ),
                    SizedBox(height: 14 * context.heightScale),
                    CoreText(
                      'Long-press the app mark to reveal the temporary local role switch used before backend auth is connected.',
                      role: TextRole.bodySm,
                      color: context.colorScheme.onSurfaceVariant,
                      height: 1.45,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
