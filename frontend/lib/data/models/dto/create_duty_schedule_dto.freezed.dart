// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'create_duty_schedule_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

CreateDutyScheduleDto _$CreateDutyScheduleDtoFromJson(
  Map<String, dynamic> json,
) {
  return _CreateDutyScheduleDto.fromJson(json);
}

/// @nodoc
mixin _$CreateDutyScheduleDto {
  int get groupId => throw _privateConstructorUsedError;
  int get dutyTypeId => throw _privateConstructorUsedError;
  int get studentsPerDay => throw _privateConstructorUsedError;
  String get startDate => throw _privateConstructorUsedError;
  String? get endDate => throw _privateConstructorUsedError;
  Map<String, bool>? get dutyDays => throw _privateConstructorUsedError;

  /// Serializes this CreateDutyScheduleDto to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CreateDutyScheduleDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CreateDutyScheduleDtoCopyWith<CreateDutyScheduleDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CreateDutyScheduleDtoCopyWith<$Res> {
  factory $CreateDutyScheduleDtoCopyWith(
    CreateDutyScheduleDto value,
    $Res Function(CreateDutyScheduleDto) then,
  ) = _$CreateDutyScheduleDtoCopyWithImpl<$Res, CreateDutyScheduleDto>;
  @useResult
  $Res call({
    int groupId,
    int dutyTypeId,
    int studentsPerDay,
    String startDate,
    String? endDate,
    Map<String, bool>? dutyDays,
  });
}

/// @nodoc
class _$CreateDutyScheduleDtoCopyWithImpl<
  $Res,
  $Val extends CreateDutyScheduleDto
>
    implements $CreateDutyScheduleDtoCopyWith<$Res> {
  _$CreateDutyScheduleDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CreateDutyScheduleDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? groupId = null,
    Object? dutyTypeId = null,
    Object? studentsPerDay = null,
    Object? startDate = null,
    Object? endDate = freezed,
    Object? dutyDays = freezed,
  }) {
    return _then(
      _value.copyWith(
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
                      as String,
            endDate: freezed == endDate
                ? _value.endDate
                : endDate // ignore: cast_nullable_to_non_nullable
                      as String?,
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
abstract class _$$CreateDutyScheduleDtoImplCopyWith<$Res>
    implements $CreateDutyScheduleDtoCopyWith<$Res> {
  factory _$$CreateDutyScheduleDtoImplCopyWith(
    _$CreateDutyScheduleDtoImpl value,
    $Res Function(_$CreateDutyScheduleDtoImpl) then,
  ) = __$$CreateDutyScheduleDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int groupId,
    int dutyTypeId,
    int studentsPerDay,
    String startDate,
    String? endDate,
    Map<String, bool>? dutyDays,
  });
}

/// @nodoc
class __$$CreateDutyScheduleDtoImplCopyWithImpl<$Res>
    extends
        _$CreateDutyScheduleDtoCopyWithImpl<$Res, _$CreateDutyScheduleDtoImpl>
    implements _$$CreateDutyScheduleDtoImplCopyWith<$Res> {
  __$$CreateDutyScheduleDtoImplCopyWithImpl(
    _$CreateDutyScheduleDtoImpl _value,
    $Res Function(_$CreateDutyScheduleDtoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CreateDutyScheduleDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? groupId = null,
    Object? dutyTypeId = null,
    Object? studentsPerDay = null,
    Object? startDate = null,
    Object? endDate = freezed,
    Object? dutyDays = freezed,
  }) {
    return _then(
      _$CreateDutyScheduleDtoImpl(
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
                  as String,
        endDate: freezed == endDate
            ? _value.endDate
            : endDate // ignore: cast_nullable_to_non_nullable
                  as String?,
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
class _$CreateDutyScheduleDtoImpl implements _CreateDutyScheduleDto {
  const _$CreateDutyScheduleDtoImpl({
    required this.groupId,
    required this.dutyTypeId,
    required this.studentsPerDay,
    required this.startDate,
    this.endDate,
    final Map<String, bool>? dutyDays,
  }) : _dutyDays = dutyDays;

  factory _$CreateDutyScheduleDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$CreateDutyScheduleDtoImplFromJson(json);

  @override
  final int groupId;
  @override
  final int dutyTypeId;
  @override
  final int studentsPerDay;
  @override
  final String startDate;
  @override
  final String? endDate;
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
    return 'CreateDutyScheduleDto(groupId: $groupId, dutyTypeId: $dutyTypeId, studentsPerDay: $studentsPerDay, startDate: $startDate, endDate: $endDate, dutyDays: $dutyDays)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CreateDutyScheduleDtoImpl &&
            (identical(other.groupId, groupId) || other.groupId == groupId) &&
            (identical(other.dutyTypeId, dutyTypeId) ||
                other.dutyTypeId == dutyTypeId) &&
            (identical(other.studentsPerDay, studentsPerDay) ||
                other.studentsPerDay == studentsPerDay) &&
            (identical(other.startDate, startDate) ||
                other.startDate == startDate) &&
            (identical(other.endDate, endDate) || other.endDate == endDate) &&
            const DeepCollectionEquality().equals(other._dutyDays, _dutyDays));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    groupId,
    dutyTypeId,
    studentsPerDay,
    startDate,
    endDate,
    const DeepCollectionEquality().hash(_dutyDays),
  );

  /// Create a copy of CreateDutyScheduleDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CreateDutyScheduleDtoImplCopyWith<_$CreateDutyScheduleDtoImpl>
  get copyWith =>
      __$$CreateDutyScheduleDtoImplCopyWithImpl<_$CreateDutyScheduleDtoImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$CreateDutyScheduleDtoImplToJson(this);
  }
}

abstract class _CreateDutyScheduleDto implements CreateDutyScheduleDto {
  const factory _CreateDutyScheduleDto({
    required final int groupId,
    required final int dutyTypeId,
    required final int studentsPerDay,
    required final String startDate,
    final String? endDate,
    final Map<String, bool>? dutyDays,
  }) = _$CreateDutyScheduleDtoImpl;

  factory _CreateDutyScheduleDto.fromJson(Map<String, dynamic> json) =
      _$CreateDutyScheduleDtoImpl.fromJson;

  @override
  int get groupId;
  @override
  int get dutyTypeId;
  @override
  int get studentsPerDay;
  @override
  String get startDate;
  @override
  String? get endDate;
  @override
  Map<String, bool>? get dutyDays;

  /// Create a copy of CreateDutyScheduleDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CreateDutyScheduleDtoImplCopyWith<_$CreateDutyScheduleDtoImpl>
  get copyWith => throw _privateConstructorUsedError;
}
