// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'update_duty_day_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$UpdateDutyDayDto {

 bool? get isMonday; bool? get isTuesday; bool? get isWednesday; bool? get isThursday; bool? get isFriday; bool? get isSaturday; bool? get isSunday;
/// Create a copy of UpdateDutyDayDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UpdateDutyDayDtoCopyWith<UpdateDutyDayDto> get copyWith => _$UpdateDutyDayDtoCopyWithImpl<UpdateDutyDayDto>(this as UpdateDutyDayDto, _$identity);

  /// Serializes this UpdateDutyDayDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UpdateDutyDayDto&&(identical(other.isMonday, isMonday) || other.isMonday == isMonday)&&(identical(other.isTuesday, isTuesday) || other.isTuesday == isTuesday)&&(identical(other.isWednesday, isWednesday) || other.isWednesday == isWednesday)&&(identical(other.isThursday, isThursday) || other.isThursday == isThursday)&&(identical(other.isFriday, isFriday) || other.isFriday == isFriday)&&(identical(other.isSaturday, isSaturday) || other.isSaturday == isSaturday)&&(identical(other.isSunday, isSunday) || other.isSunday == isSunday));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,isMonday,isTuesday,isWednesday,isThursday,isFriday,isSaturday,isSunday);

@override
String toString() {
  return 'UpdateDutyDayDto(isMonday: $isMonday, isTuesday: $isTuesday, isWednesday: $isWednesday, isThursday: $isThursday, isFriday: $isFriday, isSaturday: $isSaturday, isSunday: $isSunday)';
}


}

/// @nodoc
abstract mixin class $UpdateDutyDayDtoCopyWith<$Res>  {
  factory $UpdateDutyDayDtoCopyWith(UpdateDutyDayDto value, $Res Function(UpdateDutyDayDto) _then) = _$UpdateDutyDayDtoCopyWithImpl;
@useResult
$Res call({
 bool? isMonday, bool? isTuesday, bool? isWednesday, bool? isThursday, bool? isFriday, bool? isSaturday, bool? isSunday
});




}
/// @nodoc
class _$UpdateDutyDayDtoCopyWithImpl<$Res>
    implements $UpdateDutyDayDtoCopyWith<$Res> {
  _$UpdateDutyDayDtoCopyWithImpl(this._self, this._then);

  final UpdateDutyDayDto _self;
  final $Res Function(UpdateDutyDayDto) _then;

/// Create a copy of UpdateDutyDayDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isMonday = freezed,Object? isTuesday = freezed,Object? isWednesday = freezed,Object? isThursday = freezed,Object? isFriday = freezed,Object? isSaturday = freezed,Object? isSunday = freezed,}) {
  return _then(_self.copyWith(
isMonday: freezed == isMonday ? _self.isMonday : isMonday // ignore: cast_nullable_to_non_nullable
as bool?,isTuesday: freezed == isTuesday ? _self.isTuesday : isTuesday // ignore: cast_nullable_to_non_nullable
as bool?,isWednesday: freezed == isWednesday ? _self.isWednesday : isWednesday // ignore: cast_nullable_to_non_nullable
as bool?,isThursday: freezed == isThursday ? _self.isThursday : isThursday // ignore: cast_nullable_to_non_nullable
as bool?,isFriday: freezed == isFriday ? _self.isFriday : isFriday // ignore: cast_nullable_to_non_nullable
as bool?,isSaturday: freezed == isSaturday ? _self.isSaturday : isSaturday // ignore: cast_nullable_to_non_nullable
as bool?,isSunday: freezed == isSunday ? _self.isSunday : isSunday // ignore: cast_nullable_to_non_nullable
as bool?,
  ));
}

}


/// Adds pattern-matching-related methods to [UpdateDutyDayDto].
extension UpdateDutyDayDtoPatterns on UpdateDutyDayDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UpdateDutyDayDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UpdateDutyDayDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UpdateDutyDayDto value)  $default,){
final _that = this;
switch (_that) {
case _UpdateDutyDayDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UpdateDutyDayDto value)?  $default,){
final _that = this;
switch (_that) {
case _UpdateDutyDayDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool? isMonday,  bool? isTuesday,  bool? isWednesday,  bool? isThursday,  bool? isFriday,  bool? isSaturday,  bool? isSunday)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UpdateDutyDayDto() when $default != null:
return $default(_that.isMonday,_that.isTuesday,_that.isWednesday,_that.isThursday,_that.isFriday,_that.isSaturday,_that.isSunday);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool? isMonday,  bool? isTuesday,  bool? isWednesday,  bool? isThursday,  bool? isFriday,  bool? isSaturday,  bool? isSunday)  $default,) {final _that = this;
switch (_that) {
case _UpdateDutyDayDto():
return $default(_that.isMonday,_that.isTuesday,_that.isWednesday,_that.isThursday,_that.isFriday,_that.isSaturday,_that.isSunday);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool? isMonday,  bool? isTuesday,  bool? isWednesday,  bool? isThursday,  bool? isFriday,  bool? isSaturday,  bool? isSunday)?  $default,) {final _that = this;
switch (_that) {
case _UpdateDutyDayDto() when $default != null:
return $default(_that.isMonday,_that.isTuesday,_that.isWednesday,_that.isThursday,_that.isFriday,_that.isSaturday,_that.isSunday);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _UpdateDutyDayDto implements UpdateDutyDayDto {
  const _UpdateDutyDayDto({this.isMonday, this.isTuesday, this.isWednesday, this.isThursday, this.isFriday, this.isSaturday, this.isSunday});
  factory _UpdateDutyDayDto.fromJson(Map<String, dynamic> json) => _$UpdateDutyDayDtoFromJson(json);

@override final  bool? isMonday;
@override final  bool? isTuesday;
@override final  bool? isWednesday;
@override final  bool? isThursday;
@override final  bool? isFriday;
@override final  bool? isSaturday;
@override final  bool? isSunday;

/// Create a copy of UpdateDutyDayDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UpdateDutyDayDtoCopyWith<_UpdateDutyDayDto> get copyWith => __$UpdateDutyDayDtoCopyWithImpl<_UpdateDutyDayDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UpdateDutyDayDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UpdateDutyDayDto&&(identical(other.isMonday, isMonday) || other.isMonday == isMonday)&&(identical(other.isTuesday, isTuesday) || other.isTuesday == isTuesday)&&(identical(other.isWednesday, isWednesday) || other.isWednesday == isWednesday)&&(identical(other.isThursday, isThursday) || other.isThursday == isThursday)&&(identical(other.isFriday, isFriday) || other.isFriday == isFriday)&&(identical(other.isSaturday, isSaturday) || other.isSaturday == isSaturday)&&(identical(other.isSunday, isSunday) || other.isSunday == isSunday));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,isMonday,isTuesday,isWednesday,isThursday,isFriday,isSaturday,isSunday);

@override
String toString() {
  return 'UpdateDutyDayDto(isMonday: $isMonday, isTuesday: $isTuesday, isWednesday: $isWednesday, isThursday: $isThursday, isFriday: $isFriday, isSaturday: $isSaturday, isSunday: $isSunday)';
}


}

/// @nodoc
abstract mixin class _$UpdateDutyDayDtoCopyWith<$Res> implements $UpdateDutyDayDtoCopyWith<$Res> {
  factory _$UpdateDutyDayDtoCopyWith(_UpdateDutyDayDto value, $Res Function(_UpdateDutyDayDto) _then) = __$UpdateDutyDayDtoCopyWithImpl;
@override @useResult
$Res call({
 bool? isMonday, bool? isTuesday, bool? isWednesday, bool? isThursday, bool? isFriday, bool? isSaturday, bool? isSunday
});




}
/// @nodoc
class __$UpdateDutyDayDtoCopyWithImpl<$Res>
    implements _$UpdateDutyDayDtoCopyWith<$Res> {
  __$UpdateDutyDayDtoCopyWithImpl(this._self, this._then);

  final _UpdateDutyDayDto _self;
  final $Res Function(_UpdateDutyDayDto) _then;

/// Create a copy of UpdateDutyDayDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isMonday = freezed,Object? isTuesday = freezed,Object? isWednesday = freezed,Object? isThursday = freezed,Object? isFriday = freezed,Object? isSaturday = freezed,Object? isSunday = freezed,}) {
  return _then(_UpdateDutyDayDto(
isMonday: freezed == isMonday ? _self.isMonday : isMonday // ignore: cast_nullable_to_non_nullable
as bool?,isTuesday: freezed == isTuesday ? _self.isTuesday : isTuesday // ignore: cast_nullable_to_non_nullable
as bool?,isWednesday: freezed == isWednesday ? _self.isWednesday : isWednesday // ignore: cast_nullable_to_non_nullable
as bool?,isThursday: freezed == isThursday ? _self.isThursday : isThursday // ignore: cast_nullable_to_non_nullable
as bool?,isFriday: freezed == isFriday ? _self.isFriday : isFriday // ignore: cast_nullable_to_non_nullable
as bool?,isSaturday: freezed == isSaturday ? _self.isSaturday : isSaturday // ignore: cast_nullable_to_non_nullable
as bool?,isSunday: freezed == isSunday ? _self.isSunday : isSunday // ignore: cast_nullable_to_non_nullable
as bool?,
  ));
}


}

// dart format on
