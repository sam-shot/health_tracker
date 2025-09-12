import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:health_tracker/core/extension/context.extensions.dart';
import 'package:health_tracker/core/extension/datetime.extensions.dart';
import 'package:health_tracker/core/extension/others.extensions.dart';
import 'package:health_tracker/core/extension/string.extensions.dart';
import 'package:health_tracker/features/health_entry/models/health_entry_model.dart';

class EntryCard extends StatelessWidget {
  final HealthEntry entry;

  const EntryCard({
    super.key,
    required this.entry,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: entry.mood.color.withAlpha(50),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Flexible(
                fit: FlexFit.tight,
                child: Text(
                  entry.title,
                  style: context.titleSmall,
                ),
              ),
              Row(
                children: [
                  Icon(
                    entry.mood.icon,
                    color: entry.mood.color,
                    size: 20,
                  ),
                  const Gap(4),
                  Text(
                    entry.mood.name.capitalize,
                    style: context.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const Gap(12),
          if (entry.note != null) ...[
            Text(
              entry.note!,
              style: context.bodyLarge,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
            const Gap(16),
          ],
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                entry.createdAt.formattedDate,
                style: context.bodySmall,
              ),
              if (entry.isSynced == false)
                const Icon(
                  Icons.cloud_off,
                  color: Colors.grey,
                  size: 16,
                ),
            ],
          ),
        ],
      ),
    );
  }
}
