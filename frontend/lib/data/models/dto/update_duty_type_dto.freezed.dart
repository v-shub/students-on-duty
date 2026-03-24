// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'update_duty_type_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$UpdateDutyTypeDto {

 String? get name; String? get description; int? get defaultScore;
/// Create a copy of UpdateDutyTypeDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UpdateDutyTypeDtoCopyWith<UpdateDutyTypeDto> get copyWith => _$UpdateDutyTypeDtoCopyWithImpl<UpdateDutyTypeDto>(this as UpdateDutyTypeDto, _$identity);

  /// Serializes this UpdateDutyTypeDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UpdateDutyTypeDto&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&(identical(other.defaultScore, defaultScore) || other.defaultScore == defaultScore));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,description,defaultScore);

@override
String toString() {
  return 'UpdateDutyTypeDto(name: $name, description: $description, defaultScore: $defaultScore)';
}


}

/// @nodoc
abstract mixin class $UpdateDutyTypeDtoCopyWith<$Res>  {
  factory $UpdateDutyTypeDtoCopyWith(UpdateDutyTypeDto value, $Res Function(UpdateDutyTypeDto) _then) = _$UpdateDutyTypeDtoCopyWithImpl;
@useResult
$Res call({
 String? name, String? description, int? defaultScore
});




}
/// @nodoc
class _$UpdateDutyTypeDtoCopyWithImpl<$Res>
    implements $UpdateDutyTypeDtoCopyWith<$Res> {
  _$UpdateDutyTypeDtoCopyWithImpl(this._self, this._then);

  final UpdateDutyTypeDto _self;
  final $Res Function(UpdateDutyTypeDto) _then;

/// Create a copy of UpdateDutyTypeDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = freezed,Object? description = freezed,Object? defaultScore = freezed,}) {
  return _then(_self.copyWith(
name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,defaultScore: freezed == defaultScore ? _self.defaultScore : defaultScore // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [UpdateDutyTypeDto].
extension UpdateDutyTypeDtoPatterns on UpdateDutyTypeDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UpdateDutyTypeDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UpdateDutyTypeDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UpdateDutyTypeDto value)  $default,){
final _that = this;
switch (_that) {
case _UpdateDutyTypeDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UpdateDutyTypeDto value)?  $default,){
final _that = this;
switch (_that) {
case _UpdateDutyTypeDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? name,  String? description,  int? defaultScore)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UpdateDutyTypeDto() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? name,  String? description,  int? defaultScore)  $default,) {final _that = this;
switch (_that) {
case _UpdateDutyTypeDto():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? name,  String? description,  int? defaultScore)?  $default,) {final _that = this;
switch (_that) {
case _UpdateDutyTypeDto() when $default != null:
return $default(_that.name,_that.description,_that.defaultScore);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _UpdateDutyTypeDto implements UpdateDutyTypeDto {
  const _UpdateDutyTypeDto({this.name, this.description, this.defaultScore});
  factory _UpdateDutyTypeDto.fromJson(Map<String, dynamic> json) => _$UpdateDutyTypeDtoFromJson(json);

@override final  String? name;
@override final  String? description;
@override final  int? defaultScore;

/// Create a copy of UpdateDutyTypeDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UpdateDutyTypeDtoCopyWith<_UpdateDutyTypeDto> get copyWith => __$UpdateDutyTypeDtoCopyWithImpl<_UpdateDutyTypeDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UpdateDutyTypeDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UpdateDutyTypeDto&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&(identical(other.defaultScore, defaultScore) || other.defaultScore == defaultScore));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,description,defaultScore);

@override
String toString() {
  return 'UpdateDutyTypeDto(name: $name, description: $description, defaultScore: $defaultScore)';
}


}

/// @nodoc
abstract mixin class _$UpdateDutyTypeDtoCopyWith<$Res> implements $UpdateDutyTypeDtoCopyWith<$Res> {
  factory _$UpdateDutyTypeDtoCopyWith(_UpdateDutyTypeDto value, $Res Function(_UpdateDutyTypeDto) _then) = __$UpdateDutyTypeDtoCopyWithImpl;
@override @useResult
$Res call({
 String? name, String? description, int? defaultScore
});




}
/// @nodoc
class __$UpdateDutyTypeDtoCopyWithImpl<$Res>
    implements _$UpdateDutyTypeDtoCopyWith<$Res> {
  __$UpdateDutyTypeDtoCopyWithImpl(this._self, this._then);

  final _UpdateDutyTypeDto _self;
  final $Res Function(_UpdateDutyTypeDto) _then;

/// Create a copy of UpdateDutyTypeDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = freezed,Object? description = freezed,Object? defaultScore = freezed,}) {
  return _then(_UpdateDutyTypeDto(
name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,defaultScore: freezed == defaultScore ? _self.defaultScore : defaultScore // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

// dart format on
