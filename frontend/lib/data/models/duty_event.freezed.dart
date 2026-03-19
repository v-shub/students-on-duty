// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'duty_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

DutyEvent _$DutyEventFromJson(Map<String, dynamic> json) {
  return _DutyEvent.fromJson(json);
}

/// @nodoc
mixin _$DutyEvent {
  int get id => throw _privateConstructorUsedError;
  int get studentId => throw _privateConstructorUsedError;
  int get scheduleId => throw _privateConstructorUsedError;
  DateTime get dutyDate => throw _privateConstructorUsedError;
  DutyEventStatus get status => throw _privateConstructorUsedError;
  int? get scoreEarned => throw _privateConstructorUsedError;
  String? get notes => throw _privateConstructorUsedError;
  DateTime? get assignedAt => throw _privateConstructorUsedError;

  /// Serializes this DutyEvent to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DutyEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DutyEventCopyWith<DutyEvent> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DutyEventCopyWith<$Res> {
  factory $DutyEventCopyWith(DutyEvent value, $Res Function(DutyEvent) then) =
      _$DutyEventCopyWithImpl<$Res, DutyEvent>;
  @useResult
  $Res call({
    int id,
    int studentId,
    int scheduleId,
    DateTime dutyDate,
    DutyEventStatus status,
    int? scoreEarned,
    String? notes,
    DateTime? assignedAt,
  });
}

/// @nodoc
class _$DutyEventCopyWithImpl<$Res, $Val extends DutyEvent>
    implements $DutyEventCopyWith<$Res> {
  _$DutyEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DutyEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? studentId = null,
    Object? scheduleId = null,
    Object? dutyDate = null,
    Object? status = null,
    Object? scoreEarned = freezed,
    Object? notes = freezed,
    Object? assignedAt = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as int,
            studentId: null == studentId
                ? _value.studentId
                : studentId // ignore: cast_nullable_to_non_nullable
                      as int,
            scheduleId: null == scheduleId
                ? _value.scheduleId
                : scheduleId // ignore: cast_nullable_to_non_nullable
                      as int,
            dutyDate: null == dutyDate
                ? _value.dutyDate
                : dutyDate // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as DutyEventStatus,
            scoreEarned: freezed == scoreEarned
                ? _value.scoreEarned
                : scoreEarned // ignore: cast_nullable_to_non_nullable
                      as int?,
            notes: freezed == notes
                ? _value.notes
                : notes // ignore: cast_nullable_to_non_nullable
                      as String?,
            assignedAt: freezed == assignedAt
                ? _value.assignedAt
                : assignedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$DutyEventImplCopyWith<$Res>
    implements $DutyEventCopyWith<$Res> {
  factory _$$DutyEventImplCopyWith(
    _$DutyEventImpl value,
    $Res Function(_$DutyEventImpl) then,
  ) = __$$DutyEventImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int id,
    int studentId,
    int scheduleId,
    DateTime dutyDate,
    DutyEventStatus status,
    int? scoreEarned,
    String? notes,
    DateTime? assignedAt,
  });
}

/// @nodoc
class __$$DutyEventImplCopyWithImpl<$Res>
    extends _$DutyEventCopyWithImpl<$Res, _$DutyEventImpl>
    implements _$$DutyEventImplCopyWith<$Res> {
  __$$DutyEventImplCopyWithImpl(
    _$DutyEventImpl _value,
    $Res Function(_$DutyEventImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of DutyEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? studentId = null,
    Object? scheduleId = null,
    Object? dutyDate = null,
    Object? status = null,
    Object? scoreEarned = freezed,
    Object? notes = freezed,
    Object? assignedAt = freezed,
  }) {
    return _then(
      _$DutyEventImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int,
        studentId: null == studentId
            ? _value.studentId
            : studentId // ignore: cast_nullable_to_non_nullable
                  as int,
        scheduleId: null == scheduleId
            ? _value.scheduleId
            : scheduleId // ignore: cast_nullable_to_non_nullable
                  as int,
        dutyDate: null == dutyDate
            ? _value.dutyDate
            : dutyDate // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as DutyEventStatus,
        scoreEarned: freezed == scoreEarned
            ? _value.scoreEarned
            : scoreEarned // ignore: cast_nullable_to_non_nullable
                  as int?,
        notes: freezed == notes
            ? _value.notes
            : notes // ignore: cast_nullable_to_non_nullable
                  as String?,
        assignedAt: freezed == assignedAt
            ? _value.assignedAt
            : assignedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$DutyEventImpl implements _DutyEvent {
  const _$DutyEventImpl({
    required this.id,
    required this.studentId,
    required this.scheduleId,
    required this.dutyDate,
    required this.status,
    this.scoreEarned,
    this.notes,
    this.assignedAt,
  });

  factory _$DutyEventImpl.fromJson(Map<String, dynamic> json) =>
      _$$DutyEventImplFromJson(json);

  @override
  final int id;
  @override
  final int studentId;
  @override
  final int scheduleId;
  @override
  final DateTime dutyDate;
  @override
  final DutyEventStatus status;
  @override
  final int? scoreEarned;
  @override
  final String? notes;
  @override
  final DateTime? assignedAt;

  @override
  String toString() {
    return 'DutyEvent(id: $id, studentId: $studentId, scheduleId: $scheduleId, dutyDate: $dutyDate, status: $status, scoreEarned: $scoreEarned, notes: $notes, assignedAt: $assignedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DutyEventImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.studentId, studentId) ||
                other.studentId == studentId) &&
            (identical(other.scheduleId, scheduleId) ||
                other.scheduleId == scheduleId) &&
            (identical(other.dutyDate, dutyDate) ||
                other.dutyDate == dutyDate) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.scoreEarned, scoreEarned) ||
                other.scoreEarned == scoreEarned) &&
            (identical(other.notes, notes) || other.notes == notes) &&
            (identical(other.assignedAt, assignedAt) ||
                other.assignedAt == assignedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    studentId,
    scheduleId,
    dutyDate,
    status,
    scoreEarned,
    notes,
    assignedAt,
  );

  /// Create a copy of DutyEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DutyEventImplCopyWith<_$DutyEventImpl> get copyWith =>
      __$$DutyEventImplCopyWithImpl<_$DutyEventImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DutyEventImplToJson(this);
  }
}

abstract class _DutyEvent implements DutyEvent {
  const factory _DutyEvent({
    required final int id,
    required final int studentId,
    required final int scheduleId,
    required final DateTime dutyDate,
    required final DutyEventStatus status,
    final int? scoreEarned,
    final String? notes,
    final DateTime? assignedAt,
  }) = _$DutyEventImpl;

  factory _DutyEvent.fromJson(Map<String, dynamic> json) =
      _$DutyEventImpl.fromJson;

  @override
  int get id;
  @override
  int get studentId;
  @override
  int get scheduleId;
  @override
  DateTime get dutyDate;
  @override
  DutyEventStatus get status;
  @override
  int? get scoreEarned;
  @override
  String? get notes;
  @override
  DateTime? get assignedAt;

  /// Create a copy of DutyEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DutyEventImplCopyWith<_$DutyEventImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
