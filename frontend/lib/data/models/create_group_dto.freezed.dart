// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'create_group_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

CreateGroupDto _$CreateGroupDtoFromJson(Map<String, dynamic> json) {
  return _CreateGroupDto.fromJson(json);
}

/// @nodoc
mixin _$CreateGroupDto {
  String get name => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;

  /// Serializes this CreateGroupDto to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CreateGroupDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CreateGroupDtoCopyWith<CreateGroupDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CreateGroupDtoCopyWith<$Res> {
  factory $CreateGroupDtoCopyWith(
    CreateGroupDto value,
    $Res Function(CreateGroupDto) then,
  ) = _$CreateGroupDtoCopyWithImpl<$Res, CreateGroupDto>;
  @useResult
  $Res call({String name, String? description});
}

/// @nodoc
class _$CreateGroupDtoCopyWithImpl<$Res, $Val extends CreateGroupDto>
    implements $CreateGroupDtoCopyWith<$Res> {
  _$CreateGroupDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CreateGroupDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? name = null, Object? description = freezed}) {
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
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$CreateGroupDtoImplCopyWith<$Res>
    implements $CreateGroupDtoCopyWith<$Res> {
  factory _$$CreateGroupDtoImplCopyWith(
    _$CreateGroupDtoImpl value,
    $Res Function(_$CreateGroupDtoImpl) then,
  ) = __$$CreateGroupDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String name, String? description});
}

/// @nodoc
class __$$CreateGroupDtoImplCopyWithImpl<$Res>
    extends _$CreateGroupDtoCopyWithImpl<$Res, _$CreateGroupDtoImpl>
    implements _$$CreateGroupDtoImplCopyWith<$Res> {
  __$$CreateGroupDtoImplCopyWithImpl(
    _$CreateGroupDtoImpl _value,
    $Res Function(_$CreateGroupDtoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CreateGroupDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? name = null, Object? description = freezed}) {
    return _then(
      _$CreateGroupDtoImpl(
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        description: freezed == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$CreateGroupDtoImpl implements _CreateGroupDto {
  const _$CreateGroupDtoImpl({required this.name, this.description});

  factory _$CreateGroupDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$CreateGroupDtoImplFromJson(json);

  @override
  final String name;
  @override
  final String? description;

  @override
  String toString() {
    return 'CreateGroupDto(name: $name, description: $description)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CreateGroupDtoImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, name, description);

  /// Create a copy of CreateGroupDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CreateGroupDtoImplCopyWith<_$CreateGroupDtoImpl> get copyWith =>
      __$$CreateGroupDtoImplCopyWithImpl<_$CreateGroupDtoImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$CreateGroupDtoImplToJson(this);
  }
}

abstract class _CreateGroupDto implements CreateGroupDto {
  const factory _CreateGroupDto({
    required final String name,
    final String? description,
  }) = _$CreateGroupDtoImpl;

  factory _CreateGroupDto.fromJson(Map<String, dynamic> json) =
      _$CreateGroupDtoImpl.fromJson;

  @override
  String get name;
  @override
  String? get description;

  /// Create a copy of CreateGroupDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CreateGroupDtoImplCopyWith<_$CreateGroupDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
