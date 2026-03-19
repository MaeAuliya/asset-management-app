import 'package:flutter/material.dart';

import '../../../../core/enums/user_role.dart';
import '../../../../core/extensions/context_extension.dart';
import '../../../../core/res/typography.dart';
import '../../../notifications/presentation/screens/notifications_screen.dart';
import '../widgets/shell_destination.dart';
import '../widgets/shell_tab_view.dart';

class AppShellView extends StatelessWidget {
  const AppShellView({
    required this.role,
    super.key,
  });

  final UserRole role;

  List<ShellDestination> get _destinations => switch (role) {
    UserRole.user => const [
      ShellDestination(
        label: 'Home',
        icon: Icons.home_outlined,
        selectedIcon: Icons.home_rounded,
        title: 'User Dashboard',
        description:
            'Barcode-first user shell is ready. This tab will become the Stitch-based dashboard with reminders, borrowed-item cards, and quick actions.',
        milestone: 'Next slice: User dashboard implementation.',
      ),
      ShellDestination(
        label: 'Assets',
        icon: Icons.inventory_2_outlined,
        selectedIcon: Icons.inventory_2_rounded,
        title: 'Asset Catalog',
        description:
            'This tab will host laptop and projector browsing, category filtering, and asset detail entry points.',
        milestone: 'Next slice: Asset catalog and detail.',
      ),
      ShellDestination(
        label: 'Scan',
        icon: Icons.qr_code_scanner_outlined,
        selectedIcon: Icons.qr_code_scanner_rounded,
        title: 'Barcode Scan',
        description:
            'Scan is already a primary destination in the shell. The dedicated Stitch screen still needs to be finalized before the borrow flow is built.',
        milestone: 'Design gap: dedicated barcode scan screen.',
      ),
      ShellDestination(
        label: 'History',
        icon: Icons.history_outlined,
        selectedIcon: Icons.history_rounded,
        title: 'Borrowing History',
        description:
            'This will become the user history list and detail flow once the Stitch history screens are finalized.',
        milestone: 'Design gap: history list and borrowing detail.',
      ),
      ShellDestination(
        label: 'Settings',
        icon: Icons.settings_outlined,
        selectedIcon: Icons.settings_rounded,
        title: 'Settings / More',
        description:
            'This secondary tab is reserved for profile, settings, and notification entry points that do not belong in the primary navigation.',
        milestone: 'Later slice: settings and secondary actions.',
      ),
    ],
    UserRole.admin => const [
      ShellDestination(
        label: 'Dashboard',
        icon: Icons.dashboard_outlined,
        selectedIcon: Icons.dashboard_rounded,
        title: 'Admin Dashboard',
        description:
            'Admin shell uses request-first navigation. This dashboard will show stats, urgent alerts, and quick actions from the approved Stitch design.',
        milestone: 'Next slice: admin dashboard implementation.',
      ),
      ShellDestination(
        label: 'Assets',
        icon: Icons.inventory_2_outlined,
        selectedIcon: Icons.inventory_2_rounded,
        title: 'Asset Management',
        description:
            'Admin asset inventory and CRUD flows will live here, aligned to the Stitch asset management flow.',
        milestone: 'Later slice: asset management.',
      ),
      ShellDestination(
        label: 'Requests',
        icon: Icons.assignment_outlined,
        selectedIcon: Icons.assignment_rounded,
        title: 'Pending Approvals',
        description:
            'Requests stay primary for admins. This tab is reserved for bulk borrowing approvals and status actions.',
        milestone: 'Later slice: pending approvals.',
      ),
      ShellDestination(
        label: 'History',
        icon: Icons.history_outlined,
        selectedIcon: Icons.history_rounded,
        title: 'Operational History',
        description:
            'This tab will contain admin transaction history, filtering, and export entry points.',
        milestone: 'Later slice: reports and history.',
      ),
      ShellDestination(
        label: 'Settings',
        icon: Icons.settings_outlined,
        selectedIcon: Icons.settings_rounded,
        title: 'Admin Settings',
        description:
            'Settings will control borrowing duration, reminder timing, and other operational rules.',
        milestone: 'Later slice: settings and rule configuration.',
      ),
    ],
  };

  @override
  Widget build(BuildContext context) {
    final currentIndex = context.selectAppShellProvider(
      (provider) => provider.currentIndex,
    );
    final destination = _destinations[currentIndex];

    return Scaffold(
      appBar: AppBar(
        title: CoreText(destination.label),
        actions: [
          if (role == UserRole.user)
            IconButton(
              tooltip: 'Notifications',
              onPressed: () {
                Navigator.pushNamed(context, NotificationsScreen.routeName);
              },
              icon: Badge.count(
                count: 3,
                child: const Icon(Icons.notifications_none_rounded),
              ),
            ),
          Padding(
            padding: EdgeInsets.only(right: 12 * context.widthScale),
            child: Center(
              child: Chip(
                label: CoreText(role.label),
                avatar: Icon(
                  role == UserRole.user
                      ? Icons.person_outline_rounded
                      : Icons.admin_panel_settings_outlined,
                  size: 18,
                ),
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: IndexedStack(
          index: currentIndex,
          children: _destinations
              .map(
                (entry) => ShellTabView(
                  shellTitle: role.shellTitle,
                  destination: entry,
                ),
              )
              .toList(),
        ),
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: currentIndex,
        onDestinationSelected: context.appShellProvider.selectTab,
        destinations: _destinations
            .map(
              (entry) => NavigationDestination(
                icon: Icon(entry.icon),
                selectedIcon: Icon(entry.selectedIcon),
                label: entry.label,
              ),
            )
            .toList(),
      ),
    );
  }
}
