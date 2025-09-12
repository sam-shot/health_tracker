import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:health_tracker/core/extension/context.extensions.dart';
import 'package:health_tracker/core/extension/datetime.extensions.dart';
import 'package:health_tracker/core/theme/app_colors.dart';
import 'package:health_tracker/core/widgets/app_button.dart';
import 'package:health_tracker/features/auth/presentation/providers/auth_providers.dart';
import 'package:health_tracker/features/health_entry/presentation/providers/health_entry_providers.dart';
import 'package:health_tracker/features/profile/presentation/widgets/stats_card.dart';

@RoutePage()
class ProfilePage extends ConsumerWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authRepositoryProvider);

    final totalCount = ref.watch(healthEntryNotifierProvider).entries.length;
    final todayCount = ref
        .watch(healthEntryNotifierProvider)
        .entries
        .where((entry) => entry.createdAt.isSameDayAs(DateTime.now()))
        .length;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                onPressed: () => context.back(),
                icon: const Icon(
                  Icons.arrow_back_ios_new_rounded,
                  size: 20,
                ),
              ),
              const Gap(30),
              Text(
                'Profile & Stats',
                style: context.titleMedium,
              ),
              const Gap(40),
              Center(
                child: Material(
                  type: MaterialType.transparency,
                  child: Hero(
                    tag: 'profile_avatar',
                    child: CircleAvatar(
                      radius: 50,
                      backgroundColor: AppColors.primaryLight.withAlpha(50),
                      backgroundImage: NetworkImage(
                        authState.avatarUrl,
                      ),
                    ),
                  ),
                ),
              ),
              const Gap(16),
              Center(
                child: Text(
                  authState.currentUser?.email ?? 'Loading...',
                  style: context.displaySmall
                      ?.copyWith(fontWeight: FontWeight.w600),
                  textAlign: TextAlign.center,
                ),
              ),
              const Gap(32),
              Row(
                children: [
                  StatCard(
                    label: 'Total Entries',
                    value: totalCount.toString(),
                    icon: Icons.calendar_month,
                    color: AppColors.primary,
                  ),
                  const Gap(16),
                  StatCard(
                    label: 'Today Entries',
                    value: todayCount.toString(),
                    icon: Icons.today,
                    color: AppColors.moodHappy,
                  ),
                ],
              ),
              const Spacer(),
              AppButton(
                buttonText: 'Logout',
                width: double.infinity,
                onPressed: () => ref.read(authRepositoryProvider).signOut(),
                icon: Icons.logout,
                hasIcon: true,
                buttonColor: AppColors.error,
              ),
              const Gap(20),
            ],
          ),
        ),
      ),
    );
  }
}
