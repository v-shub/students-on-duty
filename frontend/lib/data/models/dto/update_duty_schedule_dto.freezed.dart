// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'update_duty_schedule_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

UpdateDutyScheduleDto _$UpdateDutyScheduleDtoFromJson(
  Map<String, dynamic> json,
) {
  return _UpdateDutyScheduleDto.fromJson(json);
}

/// @nodoc
mixin _$UpdateDutyScheduleDto {
  int? get dutyTypeId => throw _privateConstructorUsedError;
  int? get studentsPerDay => throw _privateConstructorUsedError;
  String? get startDate => throw _privateConstructorUsedError;
  String? get endDate => throw _privateConstructorUsedError;
  bool? get isActive => throw _privateConstructorUsedError;
  Map<String, bool>? get dutyDays => throw _privateConstructorUsedError;

  /// Serializes this UpdateDutyScheduleDto to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UpdateDutyScheduleDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UpdateDutyScheduleDtoCopyWith<UpdateDutyScheduleDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UpdateDutyScheduleDtoCopyWith<$Res> {
  factory $UpdateDutyScheduleDtoCopyWith(
    UpdateDutyScheduleDto value,
    $Res Function(UpdateDutyScheduleDto) then,
  ) = _$UpdateDutyScheduleDtoCopyWithImpl<$Res, UpdateDutyScheduleDto>;
  @useResult
  $Res call({
    int? dutyTypeId,
    int? studentsPerDay,
    String? startDate,
    String? endDate,
    bool? isActive,
    Map<String, bool>? dutyDays,
  });
}

/// @nodoc
class _$UpdateDutyScheduleDtoCopyWithImpl<
  $Res,
  $Val extends UpdateDutyScheduleDto
>
    implements $UpdateDutyScheduleDtoCopyWith<$Res> {
  _$UpdateDutyScheduleDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UpdateDutyScheduleDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? dutyTypeId = freezed,
    Object? studentsPerDay = freezed,
    Object? startDate = freezed,
    Object? endDate = freezed,
    Object? isActive = freezed,
    Object? dutyDays = freezed,
  }) {
    return _then(
      _value.copyWith(
            dutyTypeId: freezed == dutyTypeId
                ? _value.dutyTypeId
                : dutyTypeId // ignore: cast_nullable_to_non_nullable
                      as int?,
            studentsPerDay: freezed == studentsPerDay
                ? _value.studentsPerDay
                : studentsPerDay // ignore: cast_nullable_to_non_nullable
                      as int?,
            startDate: freezed == startDate
                ? _value.startDate
                : startDate // ignore: cast_nullable_to_non_nullable
                      as String?,
            endDate: freezed == endDate
                ? _value.endDate
                : endDate // ignore: cast_nullable_to_non_nullable
                      as String?,
            isActive: freezed == isActive
                ? _value.isActive
                : isActive // ignore: cast_nullable_to_non_nullable
                      as bool?,
            dutyDays: freezed == dutyDays
                ? _value.dutyDays
                : dutyDays // ignore: cast_nullable_to_non_nullable
                      as Map<String, bool>?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$UpdateDutyScheduleDtoImplCopyWith<$Res>
    implements $UpdateDutyScheduleDtoCopyWith<$Res> {
  factory _$$UpdateDutyScheduleDtoImplCopyWith(
    _$UpdateDutyScheduleDtoImpl value,
    $Res Function(_$UpdateDutyScheduleDtoImpl) then,
  ) = __$$UpdateDutyScheduleDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int? dutyTypeId,
    int? studentsPerDay,
    String? startDate,
    String? endDate,
    bool? isActive,
    Map<String, bool>? dutyDays,
  });
}

/// @nodoc
class __$$UpdateDutyScheduleDtoImplCopyWithImpl<$Res>
    extends
        _$UpdateDutyScheduleDtoCopyWithImpl<$Res, _$UpdateDutyScheduleDtoImpl>
    implements _$$UpdateDutyScheduleDtoImplCopyWith<$Res> {
  __$$UpdateDutyScheduleDtoImplCopyWithImpl(
    _$UpdateDutyScheduleDtoImpl _value,
    $Res Function(_$UpdateDutyScheduleDtoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of UpdateDutyScheduleDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? dutyTypeId = freezed,
    Object? studentsPerDay = freezed,
    Object? startDate = freezed,
    Object? endDate = freezed,
    Object? isActive = freezed,
    Object? dutyDays = freezed,
  }) {
    return _then(
      _$UpdateDutyScheduleDtoImpl(
        dutyTypeId: freezed == dutyTypeId
            ? _value.dutyTypeId
            : dutyTypeId // ignore: cast_nullable_to_non_nullable
                  as int?,
        studentsPerDay: freezed == studentsPerDay
            ? _value.studentsPerDay
            : studentsPerDay // ignore: cast_nullable_to_non_nullable
                  as int?,
        startDate: freezed == startDate
            ? _value.startDate
            : startDate // ignore: cast_nullable_to_non_nullable
                  as String?,
        endDate: freezed == endDate
            ? _value.endDate
            : endDate // ignore: cast_nullable_to_non_nullable
                  as String?,
        isActive: freezed == isActive
            ? _value.isActive
            : isActive // ignore: cast_nullable_to_non_nullable
                  as bool?,
        dutyDays: freezed == dutyDays
            ? _value._dutyDays
            : dutyDays // ignore: cast_nullable_to_non_nullable
                  as Map<String, bool>?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$UpdateDutyScheduleDtoImpl implements _UpdateDutyScheduleDto {
  const _$UpdateDutyScheduleDtoImpl({
    this.dutyTypeId,
    this.studentsPerDay,
    this.startDate,
    this.endDate,
    this.isActive,
    final Map<String, bool>? dutyDays,
  }) : _dutyDays = dutyDays;

  factory _$UpdateDutyScheduleDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$UpdateDutyScheduleDtoImplFromJson(json);

  @override
  final int? dutyTypeId;
  @override
  final int? studentsPerDay;
  @override
  final String? startDate;
  @override
  final String? endDate;
  @override
  final bool? isActive;
  final Map<String, bool>? _dutyDays;
  @override
  Map<String, bool>? get dutyDays {
    final value = _dutyDays;
    if (value == null) return null;
    if (_dutyDays is EqualUnmodifiableMapView) return _dutyDays;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  String toString() {
    return 'UpdateDutyScheduleDto(dutyTypeId: $dutyTypeId, studentsPerDay: $studentsPerDay, startDate: $startDate, endDate: $endDate, isActive: $isActive, dutyDays: $dutyDays)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UpdateDutyScheduleDtoImpl &&
            (identical(other.dutyTypeId, dutyTypeId) ||
                other.dutyTypeId == dutyTypeId) &&
            (identical(other.studentsPerDay, studentsPerDay) ||
                other.studentsPerDay == studentsPerDay) &&
            (identical(other.startDate, startDate) ||
                other.startDate == startDate) &&
            (identical(other.endDate, endDate) || other.endDate == endDate) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive) &&
            const DeepCollectionEquality().equals(other._dutyDays, _dutyDays));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    dutyTypeId,
    studentsPerDay,
    startDate,
    endDate,
    isActive,
    const DeepCollectionEquality().hash(_dutyDays),
  );

  /// Create a copy of UpdateDutyScheduleDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UpdateDutyScheduleDtoImplCopyWith<_$UpdateDutyScheduleDtoImpl>
  get copyWith =>
      __$$UpdateDutyScheduleDtoImplCopyWithImpl<_$UpdateDutyScheduleDtoImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$UpdateDutyScheduleDtoImplToJson(this);
  }
}

abstract class _UpdateDutyScheduleDto implements UpdateDutyScheduleDto {
  const factory _UpdateDutyScheduleDto({
    final int? dutyTypeId,
    final int? studentsPerDay,
    final String? startDate,
    final String? endDate,
    final bool? isActive,
    final Map<String, bool>? dutyDays,
  }) = _$UpdateDutyScheduleDtoImpl;

  factory _UpdateDutyScheduleDto.fromJson(Map<String, dynamic> json) =
      _$UpdateDutyScheduleDtoImpl.fromJson;

  @override
  int? get dutyTypeId;
  @override
  int? get studentsPerDay;
  @override
  String? get startDate;
  @override
  String? get endDate;
  @override
  bool? get isActive;
  @override
  Map<String, bool>? get dutyDays;

  /// Create a copy of UpdateDutyScheduleDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UpdateDutyScheduleDtoImplCopyWith<_$UpdateDutyScheduleDtoImpl>
  get copyWith => throw _privateConstructorUsedError;
}
