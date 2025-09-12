// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'health_entry_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$HealthEntryImpl _$$HealthEntryImplFromJson(Map<String, dynamic> json) =>
    _$HealthEntryImpl(
      id: json['id'] as String,
      title: json['title'] as String,
      userId: json['user_id'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
      mood: $enumDecode(_$MoodEnumMap, json['mood']),
      isSynced: _$JsonConverterFromJson<int, bool>(
              json['synced'], const BoolToIntConverter().fromJson,) ??
          true,
      note: json['note'] as String?,
    );

Map<String, dynamic> _$$HealthEntryImplToJson(_$HealthEntryImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'user_id': instance.userId,
      'created_at': instance.createdAt.toIso8601String(),
      'mood': _$MoodEnumMap[instance.mood]!,
      'synced': _$JsonConverterToJson<int, bool>(
          instance.isSynced, const BoolToIntConverter().toJson,),
      'note': instance.note,
    };

const _$MoodEnumMap = {
  Mood.happy: 'happy',
  Mood.neutral: 'neutral',
  Mood.tired: 'tired',
  Mood.sad: 'sad',
};

Value? _$JsonConverterFromJson<Json, Value>(
  Object? json,
  Value? Function(Json json) fromJson,
) =>
    json == null ? null : fromJson(json as Json);

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) =>
    value == null ? null : toJson(value);
