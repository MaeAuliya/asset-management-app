import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/enums/user_role.dart';
import '../../../../core/extensions/context_extension.dart';
import '../bloc/auth_bloc.dart';
import '../views/auth_entry_view.dart';
import '../../../app_shell/presentation/screens/admin_shell_screen.dart';
import '../../../app_shell/presentation/screens/user_shell_screen.dart';

class AuthEntryScreen extends StatefulWidget {
  const AuthEntryScreen({super.key});

  static const routeName = '/auth-entry';

  @override
  State<AuthEntryScreen> createState() => AuthEntryScreenState();
}

class AuthEntryScreenState extends State<AuthEntryScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _showPassword = ValueNotifier<bool>(false);
  final _showDevControls = ValueNotifier<bool>(false);
  final _selectedRole = ValueNotifier<UserRole>(UserRole.user);
  final _isSubmitting = ValueNotifier<bool>(false);

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _showPassword.dispose();
    _showDevControls.dispose();
    _selectedRole.dispose();
    _isSubmitting.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listenWhen: (previous, current) =>
          current is AuthSignedInState || current is AuthFailureState,
      listener: (context, state) {
        if (state is AuthFailureState) {
          _isSubmitting.value = false;
          return;
        }

        if (state is! AuthSignedInState) {
          return;
        }

        _isSubmitting.value = false;
        Navigator.pushReplacementNamed(
          context,
          state.nextRoute == AuthRouteTarget.adminShell
              ? AdminShellScreen.routeName
              : UserShellScreen.routeName,
        );
      },
      child: AuthEntryView(
        formKey: _formKey,
        emailController: _emailController,
        passwordController: _passwordController,
        showPassword: _showPassword,
        showDevControls: _showDevControls,
        selectedRole: _selectedRole,
        isSubmitting: _isSubmitting,
        onTogglePassword: () {
          _showPassword.value = !_showPassword.value;
        },
        onToggleDevControls: () {
          _showDevControls.value = !_showDevControls.value;
        },
        onRoleChanged: (role) {
          _selectedRole.value = role;
        },
        onSubmit: () {
          if (!_formKey.currentState!.validate()) return;
          _isSubmitting.value = true;
          context.authBloc.add(
            SubmitSignInEvent(
              identifier: _emailController.text.trim(),
              password: _passwordController.text,
              role: _selectedRole.value,
            ),
          );
        },
      ),
    );
  }
}
