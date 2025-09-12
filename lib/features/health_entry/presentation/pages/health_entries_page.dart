import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:health_tracker/app/router.dart';
import 'package:health_tracker/core/extension/context.extensions.dart';
import 'package:health_tracker/core/gen_assets/assets.gen.dart';
import 'package:health_tracker/core/theme/app_colors.dart';
import 'package:health_tracker/features/auth/presentation/providers/auth_providers.dart';
import 'package:health_tracker/features/health_entry/presentation/providers/health_entry_providers.dart';
import 'package:health_tracker/features/health_entry/presentation/widgets/entry_card.dart';
import 'package:health_tracker/features/health_entry/presentation/widgets/weekly_chart.dart';

@RoutePage()
class HealthEntriesPage extends ConsumerStatefulWidget {
  const HealthEntriesPage({super.key});

  @override
  ConsumerState<HealthEntriesPage> createState() => _HealthEntriesPageState();
}

class _HealthEntriesPageState extends ConsumerState<HealthEntriesPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(healthEntryNotifierProvider.notifier).getEntries();
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(healthEntryNotifierProvider);
    final authState = ref.read(authRepositoryProvider);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.pushRoute(const CreateEntryRoute());
        },
        backgroundColor: AppColors.primary,
        child: const Icon(Icons.add, color: Colors.white),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  InkWell(
                    onTap: () => context.pushRoute(const ProfileRoute()),
                    child: Material(
                      color: Colors.transparent,
                      child: Hero(
                        tag: 'profile_avatar',
                        child: CircleAvatar(
                          radius: 23,
                          backgroundImage: NetworkImage(
                            authState.avatarUrl,
                          ),
                          backgroundColor: AppColors.textSecondary,
                        ),
                      ),
                    ),
                  ),
                  const Gap(10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Hey There!', style: context.bodyMedium),
                      Text('Good Morning', style: context.displaySmall),
                    ],
                  ),
                ],
              ),
              const Gap(30),
              const WeeklyChart(),
              const Gap(30),
              Text(
                'All Entries',
                style: context.bodyLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Gap(20),
              if (state.isLoading)
                const Expanded(
                  child: Center(child: CircularProgressIndicator()),
                )
              else if (state.entries.isEmpty)
                Expanded(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(child: Assets.images.empty.image(width: 250)),
                        const Gap(60),
                        Text(
                          "You haven't added any entries yet.",
                          style: context.bodyLarge?.copyWith(
                            fontWeight: FontWeight.w600,
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              else
                Expanded(
                  child: ListView.builder(
                    itemCount: state.entries.length + 1,
                    itemBuilder: (context, index) {
                      if (index == state.entries.length) return const Gap(40);
                      final entry = state.entries[index];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 16.0),
                        child: EntryCard(
                          entry: entry,
                        ),
                      );
                    },
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
