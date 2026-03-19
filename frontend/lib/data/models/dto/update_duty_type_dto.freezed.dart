// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'update_duty_type_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

UpdateDutyTypeDto _$UpdateDutyTypeDtoFromJson(Map<String, dynamic> json) {
  return _UpdateDutyTypeDto.fromJson(json);
}

/// @nodoc
mixin _$UpdateDutyTypeDto {
  String? get name => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  int? get defaultScore => throw _privateConstructorUsedError;

  /// Serializes this UpdateDutyTypeDto to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UpdateDutyTypeDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UpdateDutyTypeDtoCopyWith<UpdateDutyTypeDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UpdateDutyTypeDtoCopyWith<$Res> {
  factory $UpdateDutyTypeDtoCopyWith(
    UpdateDutyTypeDto value,
    $Res Function(UpdateDutyTypeDto) then,
  ) = _$UpdateDutyTypeDtoCopyWithImpl<$Res, UpdateDutyTypeDto>;
  @useResult
  $Res call({String? name, String? description, int? defaultScore});
}

/// @nodoc
class _$UpdateDutyTypeDtoCopyWithImpl<$Res, $Val extends UpdateDutyTypeDto>
    implements $UpdateDutyTypeDtoCopyWith<$Res> {
  _$UpdateDutyTypeDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UpdateDutyTypeDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = freezed,
    Object? description = freezed,
    Object? defaultScore = freezed,
  }) {
    return _then(
      _value.copyWith(
            name: freezed == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String?,
            description: freezed == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String?,
            defaultScore: freezed == defaultScore
                ? _value.defaultScore
                : defaultScore // ignore: cast_nullable_to_non_nullable
                      as int?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$UpdateDutyTypeDtoImplCopyWith<$Res>
    implements $UpdateDutyTypeDtoCopyWith<$Res> {
  factory _$$UpdateDutyTypeDtoImplCopyWith(
    _$UpdateDutyTypeDtoImpl value,
    $Res Function(_$UpdateDutyTypeDtoImpl) then,
  ) = __$$UpdateDutyTypeDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? name, String? description, int? defaultScore});
}

/// @nodoc
class __$$UpdateDutyTypeDtoImplCopyWithImpl<$Res>
    extends _$UpdateDutyTypeDtoCopyWithImpl<$Res, _$UpdateDutyTypeDtoImpl>
    implements _$$UpdateDutyTypeDtoImplCopyWith<$Res> {
  __$$UpdateDutyTypeDtoImplCopyWithImpl(
    _$UpdateDutyTypeDtoImpl _value,
    $Res Function(_$UpdateDutyTypeDtoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of UpdateDutyTypeDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = freezed,
    Object? description = freezed,
    Object? defaultScore = freezed,
  }) {
    return _then(
      _$UpdateDutyTypeDtoImpl(
        name: freezed == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String?,
        description: freezed == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String?,
        defaultScore: freezed == defaultScore
            ? _value.defaultScore
            : defaultScore // ignore: cast_nullable_to_non_nullable
                  as int?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$UpdateDutyTypeDtoImpl implements _UpdateDutyTypeDto {
  const _$UpdateDutyTypeDtoImpl({
    this.name,
    this.description,
    this.defaultScore,
  });

  factory _$UpdateDutyTypeDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$UpdateDutyTypeDtoImplFromJson(json);

  @override
  final String? name;
  @override
  final String? description;
  @override
  final int? defaultScore;

  @override
  String toString() {
    return 'UpdateDutyTypeDto(name: $name, description: $description, defaultScore: $defaultScore)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UpdateDutyTypeDtoImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.defaultScore, defaultScore) ||
                other.defaultScore == defaultScore));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, name, description, defaultScore);

  /// Create a copy of UpdateDutyTypeDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UpdateDutyTypeDtoImplCopyWith<_$UpdateDutyTypeDtoImpl> get copyWith =>
      __$$UpdateDutyTypeDtoImplCopyWithImpl<_$UpdateDutyTypeDtoImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$UpdateDutyTypeDtoImplToJson(this);
  }
}

abstract class _UpdateDutyTypeDto implements UpdateDutyTypeDto {
  const factory _UpdateDutyTypeDto({
    final String? name,
    final String? description,
    final int? defaultScore,
  }) = _$UpdateDutyTypeDtoImpl;

  factory _UpdateDutyTypeDto.fromJson(Map<String, dynamic> json) =
      _$UpdateDutyTypeDtoImpl.fromJson;

  @override
  String? get name;
  @override
  String? get description;
  @override
  int? get defaultScore;

  /// Create a copy of UpdateDutyTypeDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UpdateDutyTypeDtoImplCopyWith<_$UpdateDutyTypeDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
