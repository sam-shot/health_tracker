// ignore_for_file: use_build_context_synchronously

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:health_tracker/core/extension/context.extensions.dart';
import 'package:health_tracker/core/extension/others.extensions.dart';
import 'package:health_tracker/core/extension/string.extensions.dart';
import 'package:health_tracker/core/theme/app_colors.dart';
import 'package:health_tracker/core/widgets/app_button.dart';
import 'package:health_tracker/core/widgets/app_snackbar.dart';
import 'package:health_tracker/core/widgets/app_text_field.dart';
import 'package:health_tracker/features/health_entry/models/health_entry_model.dart';
import 'package:health_tracker/features/health_entry/presentation/providers/health_entry_providers.dart';

@RoutePage()
class CreateEntryPage extends ConsumerStatefulWidget {
  const CreateEntryPage({super.key});

  @override
  ConsumerState<CreateEntryPage> createState() => _CreateEntryPageState();
}

class _CreateEntryPageState extends ConsumerState<CreateEntryPage> {
  @override
  void initState() {
    super.initState();
    _noteController = TextEditingController();
    _titleController = TextEditingController();
    _formKey = GlobalKey<FormState>();

    // Listeners
    _noteController.addListener(() => setState(() {}));
    _titleController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _noteController.dispose();
    _titleController.dispose();
    super.dispose();
  }

  Mood? _selectedMood;
  late final TextEditingController _noteController;
  late final TextEditingController _titleController;
  late final GlobalKey<FormState> _formKey;

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(healthEntryNotifierProvider);
    final notifier = ref.read(healthEntryNotifierProvider.notifier);

    return Scaffold(
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(24),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () => context.router.pop(),
                      icon: const Icon(Icons.close),
                    ),
                    Text(
                      'Create Entry',
                      style: context.bodyLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const Gap(48),
                  ],
                ),
              ),
              const Gap(20),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Gap(10),
                      Text(
                        'How are you feeling?',
                        style: context.displaySmall
                            ?.copyWith(fontWeight: FontWeight.w600),
                      ),
                      const Gap(20),
                      _buildMoodSelector(),
                      const Gap(40),
                      AppTextField(
                        controller: _titleController,
                        label: 'Title',
                        hint: 'Entry Title',
                        validator: validateRequiredField,
                      ),
                      const Gap(20),
                      AppTextField(
                        controller: _noteController,
                        maxLines: 5,
                        label: 'Add Note (Optional)',
                        hint: 'Write more about your mood...',
                      ),
                      const Gap(40),
                      _buildPreviewCard(),
                      const Gap(40),
                    ],
                  ),
                ),
              ),
              const Gap(20),
              Padding(
                padding: const EdgeInsets.all(24),
                child: AppButton(
                  buttonText: 'Create Entry',
                  width: double.infinity,
                  isLoading: state.savingEntry,
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      if (_selectedMood == null) {
                        return AppSnackbar.warning('Select a mood to continue');
                      }

                      final response = await notifier.addEntry(
                        mood: _selectedMood!,
                        title: _titleController.text,
                        note: _noteController.text.isEmpty
                            ? null
                            : _noteController.text,
                      );
                      if (response) {
                        context.back();
                      }
                    }
                  },
                ),
              ),
              const Gap(20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMoodSelector() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: Mood.values.map((mood) {
        final isSelected = _selectedMood == mood;

        return GestureDetector(
          onTap: () {
            setState(() {
              _selectedMood = mood;
            });
          },
          child: Column(
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: isSelected
                      ? mood.color.withAlpha(50)
                      : AppColors.background,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: isSelected ? mood.color : Colors.transparent,
                    width: 2,
                  ),
                ),
                child: Icon(
                  mood.icon,
                  size: 32,
                  color: mood.color,
                ),
              ),
              const Gap(8),
              Text(
                mood.name.capitalize,
                style: context.bodySmall?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildPreviewCard() {
    final hasMood = _selectedMood != null;
    final hasNote = _noteController.text.isNotEmpty;
    final hasTitle = _titleController.text.isNotEmpty;

    if (!hasMood && !hasNote && !hasTitle) {
      return const SizedBox.shrink();
    }

    return Card(
      elevation: 0,
      color: _selectedMood?.color.withAlpha(40),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'PREVIEW',
              style: context.bodySmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: AppColors.textSecondary,
              ),
            ),
            const Gap(10),
            Row(
              children: [
                Flexible(
                  fit: FlexFit.tight,
                  child: Text(
                    _titleController.text,
                    style: context.titleSmall,
                  ),
                ),
                if (hasMood)
                  Row(
                    children: [
                      Icon(
                        _selectedMood!.icon,
                        color: _selectedMood!.color,
                        size: 20,
                      ),
                      const Gap(4),
                      Text(
                        _selectedMood!.name.capitalize,
                        style: context.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
              ],
            ),
            const Gap(8),
            if (hasNote)
              Text(
                _noteController.text,
                style: context.bodyMedium,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
          ],
        ),
      ),
    );
  }
}
