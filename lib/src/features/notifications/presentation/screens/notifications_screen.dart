import 'package:flutter/material.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  static const routeName = '/notifications';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Notifications')),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          Text(
            'Notification Center',
            style: theme.textTheme.headlineSmall,
          ),
          const SizedBox(height: 12),
          Text(
            'This route is now part of the app foundation. It will become the secondary entry point for reminders, overdue alerts, approval updates, and general activity.',
            style: theme.textTheme.bodyLarge?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 20),
          ...const [
            _NotificationPreviewTile(
              title: 'Upcoming due reminder',
              subtitle: 'MacBook Pro needs to be returned in 2 days.',
              icon: Icons.schedule_rounded,
            ),
            _NotificationPreviewTile(
              title: 'Overdue alert',
              subtitle: 'Projector asset is overdue and needs attention.',
              icon: Icons.warning_amber_rounded,
            ),
            _NotificationPreviewTile(
              title: 'Bulk request approved',
              subtitle: 'Training team request is approved and ready for pickup.',
              icon: Icons.check_circle_outline_rounded,
            ),
          ],
        ],
      ),
    );
  }
}

class _NotificationPreviewTile extends StatelessWidget {
  const _NotificationPreviewTile({
    required this.title,
    required this.subtitle,
    required this.icon,
  });

  final String title;
  final String subtitle;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: Icon(icon),
        title: Text(title),
        subtitle: Text(subtitle),
      ),
    );
  }
}
