// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'create_duty_type_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

CreateDutyTypeDto _$CreateDutyTypeDtoFromJson(Map<String, dynamic> json) {
  return _CreateDutyTypeDto.fromJson(json);
}

/// @nodoc
mixin _$CreateDutyTypeDto {
  String get name => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  int get defaultScore => throw _privateConstructorUsedError;

  /// Serializes this CreateDutyTypeDto to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CreateDutyTypeDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CreateDutyTypeDtoCopyWith<CreateDutyTypeDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CreateDutyTypeDtoCopyWith<$Res> {
  factory $CreateDutyTypeDtoCopyWith(
    CreateDutyTypeDto value,
    $Res Function(CreateDutyTypeDto) then,
  ) = _$CreateDutyTypeDtoCopyWithImpl<$Res, CreateDutyTypeDto>;
  @useResult
  $Res call({String name, String? description, int defaultScore});
}

/// @nodoc
class _$CreateDutyTypeDtoCopyWithImpl<$Res, $Val extends CreateDutyTypeDto>
    implements $CreateDutyTypeDtoCopyWith<$Res> {
  _$CreateDutyTypeDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CreateDutyTypeDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? description = freezed,
    Object? defaultScore = null,
  }) {
    return _then(
      _value.copyWith(
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            description: freezed == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String?,
            defaultScore: null == defaultScore
                ? _value.defaultScore
                : defaultScore // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$CreateDutyTypeDtoImplCopyWith<$Res>
    implements $CreateDutyTypeDtoCopyWith<$Res> {
  factory _$$CreateDutyTypeDtoImplCopyWith(
    _$CreateDutyTypeDtoImpl value,
    $Res Function(_$CreateDutyTypeDtoImpl) then,
  ) = __$$CreateDutyTypeDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String name, String? description, int defaultScore});
}

/// @nodoc
class __$$CreateDutyTypeDtoImplCopyWithImpl<$Res>
    extends _$CreateDutyTypeDtoCopyWithImpl<$Res, _$CreateDutyTypeDtoImpl>
    implements _$$CreateDutyTypeDtoImplCopyWith<$Res> {
  __$$CreateDutyTypeDtoImplCopyWithImpl(
    _$CreateDutyTypeDtoImpl _value,
    $Res Function(_$CreateDutyTypeDtoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CreateDutyTypeDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? description = freezed,
    Object? defaultScore = null,
  }) {
    return _then(
      _$CreateDutyTypeDtoImpl(
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        description: freezed == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String?,
        defaultScore: null == defaultScore
            ? _value.defaultScore
            : defaultScore // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$CreateDutyTypeDtoImpl implements _CreateDutyTypeDto {
  const _$CreateDutyTypeDtoImpl({
    required this.name,
    this.description,
    required this.defaultScore,
  });

  factory _$CreateDutyTypeDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$CreateDutyTypeDtoImplFromJson(json);

  @override
  final String name;
  @override
  final String? description;
  @override
  final int defaultScore;

  @override
  String toString() {
    return 'CreateDutyTypeDto(name: $name, description: $description, defaultScore: $defaultScore)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CreateDutyTypeDtoImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.defaultScore, defaultScore) ||
                other.defaultScore == defaultScore));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, name, description, defaultScore);

  /// Create a copy of CreateDutyTypeDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CreateDutyTypeDtoImplCopyWith<_$CreateDutyTypeDtoImpl> get copyWith =>
      __$$CreateDutyTypeDtoImplCopyWithImpl<_$CreateDutyTypeDtoImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$CreateDutyTypeDtoImplToJson(this);
  }
}

abstract class _CreateDutyTypeDto implements CreateDutyTypeDto {
  const factory _CreateDutyTypeDto({
    required final String name,
    final String? description,
    required final int defaultScore,
  }) = _$CreateDutyTypeDtoImpl;

  factory _CreateDutyTypeDto.fromJson(Map<String, dynamic> json) =
      _$CreateDutyTypeDtoImpl.fromJson;

  @override
  String get name;
  @override
  String? get description;
  @override
  int get defaultScore;

  /// Create a copy of CreateDutyTypeDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CreateDutyTypeDtoImplCopyWith<_$CreateDutyTypeDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
