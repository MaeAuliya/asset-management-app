import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/enums/user_role.dart';
import '../providers/app_shell_provider.dart';
import '../views/app_shell_view.dart';

class AdminShellScreen extends StatelessWidget {
  const AdminShellScreen({super.key});

  static const routeName = '/admin-shell';

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AppShellProvider(),
      child: const AppShellView(role: UserRole.admin),
    );
  }
}
