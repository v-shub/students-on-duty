// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'create_absence_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

CreateAbsenceDto _$CreateAbsenceDtoFromJson(Map<String, dynamic> json) {
  return _CreateAbsenceDto.fromJson(json);
}

/// @nodoc
mixin _$CreateAbsenceDto {
  int get studentId => throw _privateConstructorUsedError;
  String get dateFrom => throw _privateConstructorUsedError;
  String get dateTo => throw _privateConstructorUsedError;
  String? get reason => throw _privateConstructorUsedError;
  bool? get isApproved => throw _privateConstructorUsedError;

  /// Serializes this CreateAbsenceDto to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CreateAbsenceDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CreateAbsenceDtoCopyWith<CreateAbsenceDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CreateAbsenceDtoCopyWith<$Res> {
  factory $CreateAbsenceDtoCopyWith(
    CreateAbsenceDto value,
    $Res Function(CreateAbsenceDto) then,
  ) = _$CreateAbsenceDtoCopyWithImpl<$Res, CreateAbsenceDto>;
  @useResult
  $Res call({
    int studentId,
    String dateFrom,
    String dateTo,
    String? reason,
    bool? isApproved,
  });
}

/// @nodoc
class _$CreateAbsenceDtoCopyWithImpl<$Res, $Val extends CreateAbsenceDto>
    implements $CreateAbsenceDtoCopyWith<$Res> {
  _$CreateAbsenceDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CreateAbsenceDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? studentId = null,
    Object? dateFrom = null,
    Object? dateTo = null,
    Object? reason = freezed,
    Object? isApproved = freezed,
  }) {
    return _then(
      _value.copyWith(
            studentId: null == studentId
                ? _value.studentId
                : studentId // ignore: cast_nullable_to_non_nullable
                      as int,
            dateFrom: null == dateFrom
                ? _value.dateFrom
                : dateFrom // ignore: cast_nullable_to_non_nullable
                      as String,
            dateTo: null == dateTo
                ? _value.dateTo
                : dateTo // ignore: cast_nullable_to_non_nullable
                      as String,
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
abstract class _$$CreateAbsenceDtoImplCopyWith<$Res>
    implements $CreateAbsenceDtoCopyWith<$Res> {
  factory _$$CreateAbsenceDtoImplCopyWith(
    _$CreateAbsenceDtoImpl value,
    $Res Function(_$CreateAbsenceDtoImpl) then,
  ) = __$$CreateAbsenceDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int studentId,
    String dateFrom,
    String dateTo,
    String? reason,
    bool? isApproved,
  });
}

/// @nodoc
class __$$CreateAbsenceDtoImplCopyWithImpl<$Res>
    extends _$CreateAbsenceDtoCopyWithImpl<$Res, _$CreateAbsenceDtoImpl>
    implements _$$CreateAbsenceDtoImplCopyWith<$Res> {
  __$$CreateAbsenceDtoImplCopyWithImpl(
    _$CreateAbsenceDtoImpl _value,
    $Res Function(_$CreateAbsenceDtoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CreateAbsenceDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? studentId = null,
    Object? dateFrom = null,
    Object? dateTo = null,
    Object? reason = freezed,
    Object? isApproved = freezed,
  }) {
    return _then(
      _$CreateAbsenceDtoImpl(
        studentId: null == studentId
            ? _value.studentId
            : studentId // ignore: cast_nullable_to_non_nullable
                  as int,
        dateFrom: null == dateFrom
            ? _value.dateFrom
            : dateFrom // ignore: cast_nullable_to_non_nullable
                  as String,
        dateTo: null == dateTo
            ? _value.dateTo
            : dateTo // ignore: cast_nullable_to_non_nullable
                  as String,
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
class _$CreateAbsenceDtoImpl implements _CreateAbsenceDto {
  const _$CreateAbsenceDtoImpl({
    required this.studentId,
    required this.dateFrom,
    required this.dateTo,
    this.reason,
    this.isApproved,
  });

  factory _$CreateAbsenceDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$CreateAbsenceDtoImplFromJson(json);

  @override
  final int studentId;
  @override
  final String dateFrom;
  @override
  final String dateTo;
  @override
  final String? reason;
  @override
  final bool? isApproved;

  @override
  String toString() {
    return 'CreateAbsenceDto(studentId: $studentId, dateFrom: $dateFrom, dateTo: $dateTo, reason: $reason, isApproved: $isApproved)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CreateAbsenceDtoImpl &&
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

  /// Create a copy of CreateAbsenceDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CreateAbsenceDtoImplCopyWith<_$CreateAbsenceDtoImpl> get copyWith =>
      __$$CreateAbsenceDtoImplCopyWithImpl<_$CreateAbsenceDtoImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$CreateAbsenceDtoImplToJson(this);
  }
}

abstract class _CreateAbsenceDto implements CreateAbsenceDto {
  const factory _CreateAbsenceDto({
    required final int studentId,
    required final String dateFrom,
    required final String dateTo,
    final String? reason,
    final bool? isApproved,
  }) = _$CreateAbsenceDtoImpl;

  factory _CreateAbsenceDto.fromJson(Map<String, dynamic> json) =
      _$CreateAbsenceDtoImpl.fromJson;

  @override
  int get studentId;
  @override
  String get dateFrom;
  @override
  String get dateTo;
  @override
  String? get reason;
  @override
  bool? get isApproved;

  /// Create a copy of CreateAbsenceDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CreateAbsenceDtoImplCopyWith<_$CreateAbsenceDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
