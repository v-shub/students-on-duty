// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'duty_schedule.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

DutySchedule _$DutyScheduleFromJson(Map<String, dynamic> json) {
  return _DutySchedule.fromJson(json);
}

/// @nodoc
mixin _$DutySchedule {
  int get id => throw _privateConstructorUsedError;
  int get groupId => throw _privateConstructorUsedError;
  int get dutyTypeId => throw _privateConstructorUsedError;
  int get studentsPerDay => throw _privateConstructorUsedError;
  DateTime get startDate => throw _privateConstructorUsedError;
  DateTime? get endDate => throw _privateConstructorUsedError;
  bool get isActive => throw _privateConstructorUsedError;

  /// Serializes this DutySchedule to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DutySchedule
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DutyScheduleCopyWith<DutySchedule> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DutyScheduleCopyWith<$Res> {
  factory $DutyScheduleCopyWith(
    DutySchedule value,
    $Res Function(DutySchedule) then,
  ) = _$DutyScheduleCopyWithImpl<$Res, DutySchedule>;
  @useResult
  $Res call({
    int id,
    int groupId,
    int dutyTypeId,
    int studentsPerDay,
    DateTime startDate,
    DateTime? endDate,
    bool isActive,
  });
}

/// @nodoc
class _$DutyScheduleCopyWithImpl<$Res, $Val extends DutySchedule>
    implements $DutyScheduleCopyWith<$Res> {
  _$DutyScheduleCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DutySchedule
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? groupId = null,
    Object? dutyTypeId = null,
    Object? studentsPerDay = null,
    Object? startDate = null,
    Object? endDate = freezed,
    Object? isActive = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as int,
            groupId: null == groupId
                ? _value.groupId
                : groupId // ignore: cast_nullable_to_non_nullable
                      as int,
            dutyTypeId: null == dutyTypeId
                ? _value.dutyTypeId
                : dutyTypeId // ignore: cast_nullable_to_non_nullable
                      as int,
            studentsPerDay: null == studentsPerDay
                ? _value.studentsPerDay
                : studentsPerDay // ignore: cast_nullable_to_non_nullable
                      as int,
            startDate: null == startDate
                ? _value.startDate
                : startDate // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            endDate: freezed == endDate
                ? _value.endDate
                : endDate // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            isActive: null == isActive
                ? _value.isActive
                : isActive // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$DutyScheduleImplCopyWith<$Res>
    implements $DutyScheduleCopyWith<$Res> {
  factory _$$DutyScheduleImplCopyWith(
    _$DutyScheduleImpl value,
    $Res Function(_$DutyScheduleImpl) then,
  ) = __$$DutyScheduleImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int id,
    int groupId,
    int dutyTypeId,
    int studentsPerDay,
    DateTime startDate,
    DateTime? endDate,
    bool isActive,
  });
}

/// @nodoc
class __$$DutyScheduleImplCopyWithImpl<$Res>
    extends _$DutyScheduleCopyWithImpl<$Res, _$DutyScheduleImpl>
    implements _$$DutyScheduleImplCopyWith<$Res> {
  __$$DutyScheduleImplCopyWithImpl(
    _$DutyScheduleImpl _value,
    $Res Function(_$DutyScheduleImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of DutySchedule
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? groupId = null,
    Object? dutyTypeId = null,
    Object? studentsPerDay = null,
    Object? startDate = null,
    Object? endDate = freezed,
    Object? isActive = null,
  }) {
    return _then(
      _$DutyScheduleImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int,
        groupId: null == groupId
            ? _value.groupId
            : groupId // ignore: cast_nullable_to_non_nullable
                  as int,
        dutyTypeId: null == dutyTypeId
            ? _value.dutyTypeId
            : dutyTypeId // ignore: cast_nullable_to_non_nullable
                  as int,
        studentsPerDay: null == studentsPerDay
            ? _value.studentsPerDay
            : studentsPerDay // ignore: cast_nullable_to_non_nullable
                  as int,
        startDate: null == startDate
            ? _value.startDate
            : startDate // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        endDate: freezed == endDate
            ? _value.endDate
            : endDate // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        isActive: null == isActive
            ? _value.isActive
            : isActive // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$DutyScheduleImpl implements _DutySchedule {
  const _$DutyScheduleImpl({
    required this.id,
    required this.groupId,
    required this.dutyTypeId,
    required this.studentsPerDay,
    required this.startDate,
    this.endDate,
    this.isActive = true,
  });

  factory _$DutyScheduleImpl.fromJson(Map<String, dynamic> json) =>
      _$$DutyScheduleImplFromJson(json);

  @override
  final int id;
  @override
  final int groupId;
  @override
  final int dutyTypeId;
  @override
  final int studentsPerDay;
  @override
  final DateTime startDate;
  @override
  final DateTime? endDate;
  @override
  @JsonKey()
  final bool isActive;

  @override
  String toString() {
    return 'DutySchedule(id: $id, groupId: $groupId, dutyTypeId: $dutyTypeId, studentsPerDay: $studentsPerDay, startDate: $startDate, endDate: $endDate, isActive: $isActive)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DutyScheduleImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.groupId, groupId) || other.groupId == groupId) &&
            (identical(other.dutyTypeId, dutyTypeId) ||
                other.dutyTypeId == dutyTypeId) &&
            (identical(other.studentsPerDay, studentsPerDay) ||
                other.studentsPerDay == studentsPerDay) &&
            (identical(other.startDate, startDate) ||
                other.startDate == startDate) &&
            (identical(other.endDate, endDate) || other.endDate == endDate) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    groupId,
    dutyTypeId,
    studentsPerDay,
    startDate,
    endDate,
    isActive,
  );

  /// Create a copy of DutySchedule
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DutyScheduleImplCopyWith<_$DutyScheduleImpl> get copyWith =>
      __$$DutyScheduleImplCopyWithImpl<_$DutyScheduleImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DutyScheduleImplToJson(this);
  }
}

abstract class _DutySchedule implements DutySchedule {
  const factory _DutySchedule({
    required final int id,
    required final int groupId,
    required final int dutyTypeId,
    required final int studentsPerDay,
    required final DateTime startDate,
    final DateTime? endDate,
    final bool isActive,
  }) = _$DutyScheduleImpl;

  factory _DutySchedule.fromJson(Map<String, dynamic> json) =
      _$DutyScheduleImpl.fromJson;

  @override
  int get id;
  @override
  int get groupId;
  @override
  int get dutyTypeId;
  @override
  int get studentsPerDay;
  @override
  DateTime get startDate;
  @override
  DateTime? get endDate;
  @override
  bool get isActive;

  /// Create a copy of DutySchedule
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DutyScheduleImplCopyWith<_$DutyScheduleImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
