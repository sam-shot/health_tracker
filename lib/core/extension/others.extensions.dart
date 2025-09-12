import 'package:flutter/material.dart';
import 'package:health_tracker/core/theme/app_colors.dart';
import 'package:health_tracker/features/health_entry/models/health_entry_model.dart';

extension MoodExt on Mood {
  Color get color => switch (this) {
        Mood.happy => AppColors.moodHappy,
        Mood.neutral => AppColors.moodNeutral,
        Mood.tired => AppColors.moodTired,
        Mood.sad => AppColors.error,
      };

  IconData get icon => switch (this) {
        Mood.happy => Icons.sentiment_very_satisfied,
        Mood.neutral => Icons.sentiment_neutral,
        Mood.tired => Icons.sentiment_dissatisfied,
        Mood.sad => Icons.sentiment_very_dissatisfied,
      };
}
