import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:health_tracker/core/extension/context.extensions.dart';
import 'package:health_tracker/core/extension/datetime.extensions.dart';
import 'package:health_tracker/core/theme/app_colors.dart';
import 'package:health_tracker/features/health_entry/presentation/providers/health_entry_providers.dart';

class WeeklyChart extends ConsumerWidget {
  const WeeklyChart({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: AppColors.textSecondary.withAlpha(20),
            spreadRadius: 2,
            blurRadius: 20,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'This Week',
            style: context.titleSmall?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const Gap(16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(7, (index) {
              final now = DateTime.now();
              final dayDate =
                  now.subtract(Duration(days: now.weekday - 1 - index));
              final dayNames = [
                'Sun',
                'Mon',
                'Tue',
                'Wed',
                'Thu',
                'Fri',
                'Sat',
              ];
              final isToday =
                  dayDate.day == now.day && dayDate.month == now.month;
              final hasEntry =
                  ref.watch(healthEntryNotifierProvider).entries.any(
                        (element) => element.createdAt.isSameDayAs(dayDate),
                      );

              return Column(
                children: [
                  Text(
                    dayNames[dayDate.weekday % 7],
                    style: context.bodySmall?.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const Gap(8),
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: isToday ? AppColors.primary : Colors.transparent,
                      border: Border.all(
                        color:
                            isToday ? AppColors.primary : Colors.grey.shade300,
                        width: 2,
                      ),
                    ),
                    child: hasEntry
                        ? Icon(
                            Icons.check,
                            color: isToday ? Colors.white : AppColors.primary,
                            size: 20,
                          )
                        : Center(
                            child: Text(
                              '${dayDate.day}',
                              style: TextStyle(
                                color: isToday
                                    ? Colors.white
                                    : AppColors.textPrimary,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                  ),
                ],
              );
            }),
          ),
        ],
      ),
    );
  }
}
