// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'update_absence_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

UpdateAbsenceDto _$UpdateAbsenceDtoFromJson(Map<String, dynamic> json) {
  return _UpdateAbsenceDto.fromJson(json);
}

/// @nodoc
mixin _$UpdateAbsenceDto {
  int? get studentId => throw _privateConstructorUsedError;
  String? get dateFrom => throw _privateConstructorUsedError;
  String? get dateTo => throw _privateConstructorUsedError;
  String? get reason => throw _privateConstructorUsedError;
  bool? get isApproved => throw _privateConstructorUsedError;

  /// Serializes this UpdateAbsenceDto to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UpdateAbsenceDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UpdateAbsenceDtoCopyWith<UpdateAbsenceDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UpdateAbsenceDtoCopyWith<$Res> {
  factory $UpdateAbsenceDtoCopyWith(
    UpdateAbsenceDto value,
    $Res Function(UpdateAbsenceDto) then,
  ) = _$UpdateAbsenceDtoCopyWithImpl<$Res, UpdateAbsenceDto>;
  @useResult
  $Res call({
    int? studentId,
    String? dateFrom,
    String? dateTo,
    String? reason,
    bool? isApproved,
  });
}

/// @nodoc
class _$UpdateAbsenceDtoCopyWithImpl<$Res, $Val extends UpdateAbsenceDto>
    implements $UpdateAbsenceDtoCopyWith<$Res> {
  _$UpdateAbsenceDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UpdateAbsenceDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? studentId = freezed,
    Object? dateFrom = freezed,
    Object? dateTo = freezed,
    Object? reason = freezed,
    Object? isApproved = freezed,
  }) {
    return _then(
      _value.copyWith(
            studentId: freezed == studentId
                ? _value.studentId
                : studentId // ignore: cast_nullable_to_non_nullable
                      as int?,
            dateFrom: freezed == dateFrom
                ? _value.dateFrom
                : dateFrom // ignore: cast_nullable_to_non_nullable
                      as String?,
            dateTo: freezed == dateTo
                ? _value.dateTo
                : dateTo // ignore: cast_nullable_to_non_nullable
                      as String?,
            reason: freezed == reason
                ? _value.reason
                : reason // ignore: cast_nullable_to_non_nullable
                      as String?,
            isApproved: freezed == isApproved
                ? _value.isApproved
                : isApproved // ignore: cast_nullable_to_non_nullable
                      as bool?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$UpdateAbsenceDtoImplCopyWith<$Res>
    implements $UpdateAbsenceDtoCopyWith<$Res> {
  factory _$$UpdateAbsenceDtoImplCopyWith(
    _$UpdateAbsenceDtoImpl value,
    $Res Function(_$UpdateAbsenceDtoImpl) then,
  ) = __$$UpdateAbsenceDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int? studentId,
    String? dateFrom,
    String? dateTo,
    String? reason,
    bool? isApproved,
  });
}

/// @nodoc
class __$$UpdateAbsenceDtoImplCopyWithImpl<$Res>
    extends _$UpdateAbsenceDtoCopyWithImpl<$Res, _$UpdateAbsenceDtoImpl>
    implements _$$UpdateAbsenceDtoImplCopyWith<$Res> {
  __$$UpdateAbsenceDtoImplCopyWithImpl(
    _$UpdateAbsenceDtoImpl _value,
    $Res Function(_$UpdateAbsenceDtoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of UpdateAbsenceDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? studentId = freezed,
    Object? dateFrom = freezed,
    Object? dateTo = freezed,
    Object? reason = freezed,
    Object? isApproved = freezed,
  }) {
    return _then(
      _$UpdateAbsenceDtoImpl(
        studentId: freezed == studentId
            ? _value.studentId
            : studentId // ignore: cast_nullable_to_non_nullable
                  as int?,
        dateFrom: freezed == dateFrom
            ? _value.dateFrom
            : dateFrom // ignore: cast_nullable_to_non_nullable
                  as String?,
        dateTo: freezed == dateTo
            ? _value.dateTo
            : dateTo // ignore: cast_nullable_to_non_nullable
                  as String?,
        reason: freezed == reason
            ? _value.reason
            : reason // ignore: cast_nullable_to_non_nullable
                  as String?,
        isApproved: freezed == isApproved
            ? _value.isApproved
            : isApproved // ignore: cast_nullable_to_non_nullable
                  as bool?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$UpdateAbsenceDtoImpl implements _UpdateAbsenceDto {
  const _$UpdateAbsenceDtoImpl({
    this.studentId,
    this.dateFrom,
    this.dateTo,
    this.reason,
    this.isApproved,
  });

  factory _$UpdateAbsenceDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$UpdateAbsenceDtoImplFromJson(json);

  @override
  final int? studentId;
  @override
  final String? dateFrom;
  @override
  final String? dateTo;
  @override
  final String? reason;
  @override
  final bool? isApproved;

  @override
  String toString() {
    return 'UpdateAbsenceDto(studentId: $studentId, dateFrom: $dateFrom, dateTo: $dateTo, reason: $reason, isApproved: $isApproved)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UpdateAbsenceDtoImpl &&
            (identical(other.studentId, studentId) ||
                other.studentId == studentId) &&
            (identical(other.dateFrom, dateFrom) ||
                other.dateFrom == dateFrom) &&
            (identical(other.dateTo, dateTo) || other.dateTo == dateTo) &&
            (identical(other.reason, reason) || other.reason == reason) &&
            (identical(other.isApproved, isApproved) ||
                other.isApproved == isApproved));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, studentId, dateFrom, dateTo, reason, isApproved);

  /// Create a copy of UpdateAbsenceDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UpdateAbsenceDtoImplCopyWith<_$UpdateAbsenceDtoImpl> get copyWith =>
      __$$UpdateAbsenceDtoImplCopyWithImpl<_$UpdateAbsenceDtoImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$UpdateAbsenceDtoImplToJson(this);
  }
}

abstract class _UpdateAbsenceDto implements UpdateAbsenceDto {
  const factory _UpdateAbsenceDto({
    final int? studentId,
    final String? dateFrom,
    final String? dateTo,
    final String? reason,
    final bool? isApproved,
  }) = _$UpdateAbsenceDtoImpl;

  factory _UpdateAbsenceDto.fromJson(Map<String, dynamic> json) =
      _$UpdateAbsenceDtoImpl.fromJson;

  @override
  int? get studentId;
  @override
  String? get dateFrom;
  @override
  String? get dateTo;
  @override
  String? get reason;
  @override
  bool? get isApproved;

  /// Create a copy of UpdateAbsenceDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UpdateAbsenceDtoImplCopyWith<_$UpdateAbsenceDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
