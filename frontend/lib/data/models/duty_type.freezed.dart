// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'duty_type.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$DutyType {

 int get id; String get name; String? get description;@JsonKey(name: 'default_score') int get defaultScore;
/// Create a copy of DutyType
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DutyTypeCopyWith<DutyType> get copyWith => _$DutyTypeCopyWithImpl<DutyType>(this as DutyType, _$identity);

  /// Serializes this DutyType to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DutyType&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&(identical(other.defaultScore, defaultScore) || other.defaultScore == defaultScore));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,description,defaultScore);

@override
String toString() {
  return 'DutyType(id: $id, name: $name, description: $description, defaultScore: $defaultScore)';
}


}

/// @nodoc
abstract mixin class $DutyTypeCopyWith<$Res>  {
  factory $DutyTypeCopyWith(DutyType value, $Res Function(DutyType) _then) = _$DutyTypeCopyWithImpl;
@useResult
$Res call({
 int id, String name, String? description,@JsonKey(name: 'default_score') int defaultScore
});




}
/// @nodoc
class _$DutyTypeCopyWithImpl<$Res>
    implements $DutyTypeCopyWith<$Res> {
  _$DutyTypeCopyWithImpl(this._self, this._then);

  final DutyType _self;
  final $Res Function(DutyType) _then;

/// Create a copy of DutyType
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? description = freezed,Object? defaultScore = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,defaultScore: null == defaultScore ? _self.defaultScore : defaultScore // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [DutyType].
extension DutyTypePatterns on DutyType {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DutyType value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DutyType() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DutyType value)  $default,){
final _that = this;
switch (_that) {
case _DutyType():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DutyType value)?  $default,){
final _that = this;
switch (_that) {
case _DutyType() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String name,  String? description, @JsonKey(name: 'default_score')  int defaultScore)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DutyType() when $default != null:
return $default(_that.id,_that.name,_that.description,_that.defaultScore);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String name,  String? description, @JsonKey(name: 'default_score')  int defaultScore)  $default,) {final _that = this;
switch (_that) {
case _DutyType():
return $default(_that.id,_that.name,_that.description,_that.defaultScore);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String name,  String? description, @JsonKey(name: 'default_score')  int defaultScore)?  $default,) {final _that = this;
switch (_that) {
case _DutyType() when $default != null:
return $default(_that.id,_that.name,_that.description,_that.defaultScore);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DutyType implements DutyType {
  const _DutyType({required this.id, required this.name, this.description, @JsonKey(name: 'default_score') required this.defaultScore});
  factory _DutyType.fromJson(Map<String, dynamic> json) => _$DutyTypeFromJson(json);

@override final  int id;
@override final  String name;
@override final  String? description;
@override@JsonKey(name: 'default_score') final  int defaultScore;

/// Create a copy of DutyType
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DutyTypeCopyWith<_DutyType> get copyWith => __$DutyTypeCopyWithImpl<_DutyType>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DutyTypeToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DutyType&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&(identical(other.defaultScore, defaultScore) || other.defaultScore == defaultScore));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,description,defaultScore);

@override
String toString() {
  return 'DutyType(id: $id, name: $name, description: $description, defaultScore: $defaultScore)';
}


}

/// @nodoc
abstract mixin class _$DutyTypeCopyWith<$Res> implements $DutyTypeCopyWith<$Res> {
  factory _$DutyTypeCopyWith(_DutyType value, $Res Function(_DutyType) _then) = __$DutyTypeCopyWithImpl;
@override @useResult
$Res call({
 int id, String name, String? description,@JsonKey(name: 'default_score') int defaultScore
});




}
/// @nodoc
class __$DutyTypeCopyWithImpl<$Res>
    implements _$DutyTypeCopyWith<$Res> {
  __$DutyTypeCopyWithImpl(this._self, this._then);

  final _DutyType _self;
  final $Res Function(_DutyType) _then;

/// Create a copy of DutyType
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? description = freezed,Object? defaultScore = null,}) {
  return _then(_DutyType(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,defaultScore: null == defaultScore ? _self.defaultScore : defaultScore // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
