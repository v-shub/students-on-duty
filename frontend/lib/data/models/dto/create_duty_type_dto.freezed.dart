// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'create_duty_type_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CreateDutyTypeDto {

 String get name; String? get description; int get defaultScore;
/// Create a copy of CreateDutyTypeDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CreateDutyTypeDtoCopyWith<CreateDutyTypeDto> get copyWith => _$CreateDutyTypeDtoCopyWithImpl<CreateDutyTypeDto>(this as CreateDutyTypeDto, _$identity);

  /// Serializes this CreateDutyTypeDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CreateDutyTypeDto&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&(identical(other.defaultScore, defaultScore) || other.defaultScore == defaultScore));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,description,defaultScore);

@override
String toString() {
  return 'CreateDutyTypeDto(name: $name, description: $description, defaultScore: $defaultScore)';
}


}

/// @nodoc
abstract mixin class $CreateDutyTypeDtoCopyWith<$Res>  {
  factory $CreateDutyTypeDtoCopyWith(CreateDutyTypeDto value, $Res Function(CreateDutyTypeDto) _then) = _$CreateDutyTypeDtoCopyWithImpl;
@useResult
$Res call({
 String name, String? description, int defaultScore
});




}
/// @nodoc
class _$CreateDutyTypeDtoCopyWithImpl<$Res>
    implements $CreateDutyTypeDtoCopyWith<$Res> {
  _$CreateDutyTypeDtoCopyWithImpl(this._self, this._then);

  final CreateDutyTypeDto _self;
  final $Res Function(CreateDutyTypeDto) _then;

/// Create a copy of CreateDutyTypeDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? description = freezed,Object? defaultScore = null,}) {
  return _then(_self.copyWith(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,defaultScore: null == defaultScore ? _self.defaultScore : defaultScore // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [CreateDutyTypeDto].
extension CreateDutyTypeDtoPatterns on CreateDutyTypeDto {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CreateDutyTypeDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CreateDutyTypeDto() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CreateDutyTypeDto value)  $default,){
final _that = this;
switch (_that) {
case _CreateDutyTypeDto():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CreateDutyTypeDto value)?  $default,){
final _that = this;
switch (_that) {
case _CreateDutyTypeDto() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String name,  String? description,  int defaultScore)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CreateDutyTypeDto() when $default != null:
return $default(_that.name,_that.description,_that.defaultScore);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String name,  String? description,  int defaultScore)  $default,) {final _that = this;
switch (_that) {
case _CreateDutyTypeDto():
return $default(_that.name,_that.description,_that.defaultScore);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String name,  String? description,  int defaultScore)?  $default,) {final _that = this;
switch (_that) {
case _CreateDutyTypeDto() when $default != null:
return $default(_that.name,_that.description,_that.defaultScore);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CreateDutyTypeDto implements CreateDutyTypeDto {
  const _CreateDutyTypeDto({required this.name, this.description, required this.defaultScore});
  factory _CreateDutyTypeDto.fromJson(Map<String, dynamic> json) => _$CreateDutyTypeDtoFromJson(json);

@override final  String name;
@override final  String? description;
@override final  int defaultScore;

/// Create a copy of CreateDutyTypeDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CreateDutyTypeDtoCopyWith<_CreateDutyTypeDto> get copyWith => __$CreateDutyTypeDtoCopyWithImpl<_CreateDutyTypeDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CreateDutyTypeDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CreateDutyTypeDto&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&(identical(other.defaultScore, defaultScore) || other.defaultScore == defaultScore));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,description,defaultScore);

@override
String toString() {
  return 'CreateDutyTypeDto(name: $name, description: $description, defaultScore: $defaultScore)';
}


}

/// @nodoc
abstract mixin class _$CreateDutyTypeDtoCopyWith<$Res> implements $CreateDutyTypeDtoCopyWith<$Res> {
  factory _$CreateDutyTypeDtoCopyWith(_CreateDutyTypeDto value, $Res Function(_CreateDutyTypeDto) _then) = __$CreateDutyTypeDtoCopyWithImpl;
@override @useResult
$Res call({
 String name, String? description, int defaultScore
});




}
/// @nodoc
class __$CreateDutyTypeDtoCopyWithImpl<$Res>
    implements _$CreateDutyTypeDtoCopyWith<$Res> {
  __$CreateDutyTypeDtoCopyWithImpl(this._self, this._then);

  final _CreateDutyTypeDto _self;
  final $Res Function(_CreateDutyTypeDto) _then;

/// Create a copy of CreateDutyTypeDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? description = freezed,Object? defaultScore = null,}) {
  return _then(_CreateDutyTypeDto(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,defaultScore: null == defaultScore ? _self.defaultScore : defaultScore // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
