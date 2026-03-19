import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/enums/user_role.dart';
import '../providers/app_shell_provider.dart';
import '../views/app_shell_view.dart';

class UserShellScreen extends StatelessWidget {
  const UserShellScreen({super.key});

  static const routeName = '/user-shell';

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AppShellProvider(),
      child: const AppShellView(role: UserRole.user),
    );
  }
}
