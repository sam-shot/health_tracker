// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'health_entry_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

HealthEntry _$HealthEntryFromJson(Map<String, dynamic> json) {
  return _HealthEntry.fromJson(json);
}

/// @nodoc
mixin _$HealthEntry {
  String get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  @JsonKey(name: 'user_id')
  String get userId => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  DateTime get createdAt => throw _privateConstructorUsedError;
  Mood get mood => throw _privateConstructorUsedError;
  @JsonKey(name: 'synced')
  @BoolToIntConverter()
  bool? get isSynced => throw _privateConstructorUsedError;
  String? get note => throw _privateConstructorUsedError;

  /// Serializes this HealthEntry to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of HealthEntry
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $HealthEntryCopyWith<HealthEntry> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HealthEntryCopyWith<$Res> {
  factory $HealthEntryCopyWith(
          HealthEntry value, $Res Function(HealthEntry) then) =
      _$HealthEntryCopyWithImpl<$Res, HealthEntry>;
  @useResult
  $Res call(
      {String id,
      String title,
      @JsonKey(name: 'user_id') String userId,
      @JsonKey(name: 'created_at') DateTime createdAt,
      Mood mood,
      @JsonKey(name: 'synced') @BoolToIntConverter() bool? isSynced,
      String? note});
}

/// @nodoc
class _$HealthEntryCopyWithImpl<$Res, $Val extends HealthEntry>
    implements $HealthEntryCopyWith<$Res> {
  _$HealthEntryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of HealthEntry
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? userId = null,
    Object? createdAt = null,
    Object? mood = null,
    Object? isSynced = freezed,
    Object? note = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      mood: null == mood
          ? _value.mood
          : mood // ignore: cast_nullable_to_non_nullable
              as Mood,
      isSynced: freezed == isSynced
          ? _value.isSynced
          : isSynced // ignore: cast_nullable_to_non_nullable
              as bool?,
      note: freezed == note
          ? _value.note
          : note // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$HealthEntryImplCopyWith<$Res>
    implements $HealthEntryCopyWith<$Res> {
  factory _$$HealthEntryImplCopyWith(
          _$HealthEntryImpl value, $Res Function(_$HealthEntryImpl) then) =
      __$$HealthEntryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String title,
      @JsonKey(name: 'user_id') String userId,
      @JsonKey(name: 'created_at') DateTime createdAt,
      Mood mood,
      @JsonKey(name: 'synced') @BoolToIntConverter() bool? isSynced,
      String? note});
}

/// @nodoc
class __$$HealthEntryImplCopyWithImpl<$Res>
    extends _$HealthEntryCopyWithImpl<$Res, _$HealthEntryImpl>
    implements _$$HealthEntryImplCopyWith<$Res> {
  __$$HealthEntryImplCopyWithImpl(
      _$HealthEntryImpl _value, $Res Function(_$HealthEntryImpl) _then)
      : super(_value, _then);

  /// Create a copy of HealthEntry
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? userId = null,
    Object? createdAt = null,
    Object? mood = null,
    Object? isSynced = freezed,
    Object? note = freezed,
  }) {
    return _then(_$HealthEntryImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      mood: null == mood
          ? _value.mood
          : mood // ignore: cast_nullable_to_non_nullable
              as Mood,
      isSynced: freezed == isSynced
          ? _value.isSynced
          : isSynced // ignore: cast_nullable_to_non_nullable
              as bool?,
      note: freezed == note
          ? _value.note
          : note // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$HealthEntryImpl implements _HealthEntry {
  const _$HealthEntryImpl(
      {required this.id,
      required this.title,
      @JsonKey(name: 'user_id') required this.userId,
      @JsonKey(name: 'created_at') required this.createdAt,
      required this.mood,
      @JsonKey(name: 'synced') @BoolToIntConverter() this.isSynced = true,
      this.note});

  factory _$HealthEntryImpl.fromJson(Map<String, dynamic> json) =>
      _$$HealthEntryImplFromJson(json);

  @override
  final String id;
  @override
  final String title;
  @override
  @JsonKey(name: 'user_id')
  final String userId;
  @override
  @JsonKey(name: 'created_at')
  final DateTime createdAt;
  @override
  final Mood mood;
  @override
  @JsonKey(name: 'synced')
  @BoolToIntConverter()
  final bool? isSynced;
  @override
  final String? note;

  @override
  String toString() {
    return 'HealthEntry(id: $id, title: $title, userId: $userId, createdAt: $createdAt, mood: $mood, isSynced: $isSynced, note: $note)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HealthEntryImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.mood, mood) || other.mood == mood) &&
            (identical(other.isSynced, isSynced) ||
                other.isSynced == isSynced) &&
            (identical(other.note, note) || other.note == note));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, title, userId, createdAt, mood, isSynced, note);

  /// Create a copy of HealthEntry
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$HealthEntryImplCopyWith<_$HealthEntryImpl> get copyWith =>
      __$$HealthEntryImplCopyWithImpl<_$HealthEntryImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$HealthEntryImplToJson(
      this,
    );
  }
}

abstract class _HealthEntry implements HealthEntry {
  const factory _HealthEntry(
      {required final String id,
      required final String title,
      @JsonKey(name: 'user_id') required final String userId,
      @JsonKey(name: 'created_at') required final DateTime createdAt,
      required final Mood mood,
      @JsonKey(name: 'synced') @BoolToIntConverter() final bool? isSynced,
      final String? note}) = _$HealthEntryImpl;

  factory _HealthEntry.fromJson(Map<String, dynamic> json) =
      _$HealthEntryImpl.fromJson;

  @override
  String get id;
  @override
  String get title;
  @override
  @JsonKey(name: 'user_id')
  String get userId;
  @override
  @JsonKey(name: 'created_at')
  DateTime get createdAt;
  @override
  Mood get mood;
  @override
  @JsonKey(name: 'synced')
  @BoolToIntConverter()
  bool? get isSynced;
  @override
  String? get note;

  /// Create a copy of HealthEntry
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$HealthEntryImplCopyWith<_$HealthEntryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
