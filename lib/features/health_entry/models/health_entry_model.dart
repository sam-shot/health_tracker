// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'health_entry_model.freezed.dart';
part 'health_entry_model.g.dart';

enum Mood { happy, neutral, tired, sad }

class BoolToIntConverter implements JsonConverter<bool, int> {
  const BoolToIntConverter();

  @override
  bool fromJson(int json) => json == 1;

  @override
  int toJson(bool object) => object ? 1 : 0;
}

@freezed
class HealthEntry with _$HealthEntry {
  const factory HealthEntry({
    required String id,
    required String title,
    @JsonKey(name: 'user_id') required String userId,
    @JsonKey(name: 'created_at') required DateTime createdAt,
    required Mood mood,
    @JsonKey(name: 'synced')
    @Default(true)
    @BoolToIntConverter()
    bool? isSynced,
    String? note,
  }) = _HealthEntry;

  factory HealthEntry.fromJson(Map<String, dynamic> json) =>
      _$HealthEntryFromJson(json);
}
