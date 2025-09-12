import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:health_tracker/core/extension/context.extensions.dart';

class StatCard extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final Color color;

  const StatCard({
    super.key,
    required this.label,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Card(
        elevation: 0,
        color: color.withAlpha(25),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(icon, color: color, size: 28),
              const Gap(16),
              Text(label, style: context.bodyMedium),
              const Gap(4),
              Text(value, style: context.displaySmall),
            ],
          ),
        ),
      ),
    );
  }
}
