import 'package:flutter/material.dart';

class ShellDestination {
  const ShellDestination({
    required this.label,
    required this.icon,
    required this.selectedIcon,
    required this.title,
    required this.description,
    required this.milestone,
  });

  final String label;
  final IconData icon;
  final IconData selectedIcon;
  final String title;
  final String description;
  final String milestone;
}
