// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'duty_type.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

DutyType _$DutyTypeFromJson(Map<String, dynamic> json) {
  return _DutyType.fromJson(json);
}

/// @nodoc
mixin _$DutyType {
  int get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  int get defaultScore => throw _privateConstructorUsedError;

  /// Serializes this DutyType to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DutyType
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DutyTypeCopyWith<DutyType> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DutyTypeCopyWith<$Res> {
  factory $DutyTypeCopyWith(DutyType value, $Res Function(DutyType) then) =
      _$DutyTypeCopyWithImpl<$Res, DutyType>;
  @useResult
  $Res call({int id, String name, String? description, int defaultScore});
}

/// @nodoc
class _$DutyTypeCopyWithImpl<$Res, $Val extends DutyType>
    implements $DutyTypeCopyWith<$Res> {
  _$DutyTypeCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DutyType
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = freezed,
    Object? defaultScore = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as int,
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
abstract class _$$DutyTypeImplCopyWith<$Res>
    implements $DutyTypeCopyWith<$Res> {
  factory _$$DutyTypeImplCopyWith(
    _$DutyTypeImpl value,
    $Res Function(_$DutyTypeImpl) then,
  ) = __$$DutyTypeImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int id, String name, String? description, int defaultScore});
}

/// @nodoc
class __$$DutyTypeImplCopyWithImpl<$Res>
    extends _$DutyTypeCopyWithImpl<$Res, _$DutyTypeImpl>
    implements _$$DutyTypeImplCopyWith<$Res> {
  __$$DutyTypeImplCopyWithImpl(
    _$DutyTypeImpl _value,
    $Res Function(_$DutyTypeImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of DutyType
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = freezed,
    Object? defaultScore = null,
  }) {
    return _then(
      _$DutyTypeImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int,
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
class _$DutyTypeImpl implements _DutyType {
  const _$DutyTypeImpl({
    required this.id,
    required this.name,
    this.description,
    required this.defaultScore,
  });

  factory _$DutyTypeImpl.fromJson(Map<String, dynamic> json) =>
      _$$DutyTypeImplFromJson(json);

  @override
  final int id;
  @override
  final String name;
  @override
  final String? description;
  @override
  final int defaultScore;

  @override
  String toString() {
    return 'DutyType(id: $id, name: $name, description: $description, defaultScore: $defaultScore)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DutyTypeImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.defaultScore, defaultScore) ||
                other.defaultScore == defaultScore));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, name, description, defaultScore);

  /// Create a copy of DutyType
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DutyTypeImplCopyWith<_$DutyTypeImpl> get copyWith =>
      __$$DutyTypeImplCopyWithImpl<_$DutyTypeImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DutyTypeImplToJson(this);
  }
}

abstract class _DutyType implements DutyType {
  const factory _DutyType({
    required final int id,
    required final String name,
    final String? description,
    required final int defaultScore,
  }) = _$DutyTypeImpl;

  factory _DutyType.fromJson(Map<String, dynamic> json) =
      _$DutyTypeImpl.fromJson;

  @override
  int get id;
  @override
  String get name;
  @override
  String? get description;
  @override
  int get defaultScore;

  /// Create a copy of DutyType
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DutyTypeImplCopyWith<_$DutyTypeImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
