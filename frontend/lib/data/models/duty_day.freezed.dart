// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'duty_day.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$DutyDay {

 int get scheduleId; bool get isMonday; bool get isTuesday; bool get isWednesday; bool get isThursday; bool get isFriday; bool get isSaturday; bool get isSunday;
/// Create a copy of DutyDay
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DutyDayCopyWith<DutyDay> get copyWith => _$DutyDayCopyWithImpl<DutyDay>(this as DutyDay, _$identity);

  /// Serializes this DutyDay to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DutyDay&&(identical(other.scheduleId, scheduleId) || other.scheduleId == scheduleId)&&(identical(other.isMonday, isMonday) || other.isMonday == isMonday)&&(identical(other.isTuesday, isTuesday) || other.isTuesday == isTuesday)&&(identical(other.isWednesday, isWednesday) || other.isWednesday == isWednesday)&&(identical(other.isThursday, isThursday) || other.isThursday == isThursday)&&(identical(other.isFriday, isFriday) || other.isFriday == isFriday)&&(identical(other.isSaturday, isSaturday) || other.isSaturday == isSaturday)&&(identical(other.isSunday, isSunday) || other.isSunday == isSunday));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,scheduleId,isMonday,isTuesday,isWednesday,isThursday,isFriday,isSaturday,isSunday);

@override
String toString() {
  return 'DutyDay(scheduleId: $scheduleId, isMonday: $isMonday, isTuesday: $isTuesday, isWednesday: $isWednesday, isThursday: $isThursday, isFriday: $isFriday, isSaturday: $isSaturday, isSunday: $isSunday)';
}


}

/// @nodoc
abstract mixin class $DutyDayCopyWith<$Res>  {
  factory $DutyDayCopyWith(DutyDay value, $Res Function(DutyDay) _then) = _$DutyDayCopyWithImpl;
@useResult
$Res call({
 int scheduleId, bool isMonday, bool isTuesday, bool isWednesday, bool isThursday, bool isFriday, bool isSaturday, bool isSunday
});




}
/// @nodoc
class _$DutyDayCopyWithImpl<$Res>
    implements $DutyDayCopyWith<$Res> {
  _$DutyDayCopyWithImpl(this._self, this._then);

  final DutyDay _self;
  final $Res Function(DutyDay) _then;

/// Create a copy of DutyDay
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? scheduleId = null,Object? isMonday = null,Object? isTuesday = null,Object? isWednesday = null,Object? isThursday = null,Object? isFriday = null,Object? isSaturday = null,Object? isSunday = null,}) {
  return _then(_self.copyWith(
scheduleId: null == scheduleId ? _self.scheduleId : scheduleId // ignore: cast_nullable_to_non_nullable
as int,isMonday: null == isMonday ? _self.isMonday : isMonday // ignore: cast_nullable_to_non_nullable
as bool,isTuesday: null == isTuesday ? _self.isTuesday : isTuesday // ignore: cast_nullable_to_non_nullable
as bool,isWednesday: null == isWednesday ? _self.isWednesday : isWednesday // ignore: cast_nullable_to_non_nullable
as bool,isThursday: null == isThursday ? _self.isThursday : isThursday // ignore: cast_nullable_to_non_nullable
as bool,isFriday: null == isFriday ? _self.isFriday : isFriday // ignore: cast_nullable_to_non_nullable
as bool,isSaturday: null == isSaturday ? _self.isSaturday : isSaturday // ignore: cast_nullable_to_non_nullable
as bool,isSunday: null == isSunday ? _self.isSunday : isSunday // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [DutyDay].
extension DutyDayPatterns on DutyDay {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DutyDay value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DutyDay() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DutyDay value)  $default,){
final _that = this;
switch (_that) {
case _DutyDay():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DutyDay value)?  $default,){
final _that = this;
switch (_that) {
case _DutyDay() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int scheduleId,  bool isMonday,  bool isTuesday,  bool isWednesday,  bool isThursday,  bool isFriday,  bool isSaturday,  bool isSunday)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DutyDay() when $default != null:
return $default(_that.scheduleId,_that.isMonday,_that.isTuesday,_that.isWednesday,_that.isThursday,_that.isFriday,_that.isSaturday,_that.isSunday);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int scheduleId,  bool isMonday,  bool isTuesday,  bool isWednesday,  bool isThursday,  bool isFriday,  bool isSaturday,  bool isSunday)  $default,) {final _that = this;
switch (_that) {
case _DutyDay():
return $default(_that.scheduleId,_that.isMonday,_that.isTuesday,_that.isWednesday,_that.isThursday,_that.isFriday,_that.isSaturday,_that.isSunday);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int scheduleId,  bool isMonday,  bool isTuesday,  bool isWednesday,  bool isThursday,  bool isFriday,  bool isSaturday,  bool isSunday)?  $default,) {final _that = this;
switch (_that) {
case _DutyDay() when $default != null:
return $default(_that.scheduleId,_that.isMonday,_that.isTuesday,_that.isWednesday,_that.isThursday,_that.isFriday,_that.isSaturday,_that.isSunday);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DutyDay implements DutyDay {
  const _DutyDay({required this.scheduleId, this.isMonday = false, this.isTuesday = false, this.isWednesday = false, this.isThursday = false, this.isFriday = false, this.isSaturday = false, this.isSunday = false});
  factory _DutyDay.fromJson(Map<String, dynamic> json) => _$DutyDayFromJson(json);

@override final  int scheduleId;
@override@JsonKey() final  bool isMonday;
@override@JsonKey() final  bool isTuesday;
@override@JsonKey() final  bool isWednesday;
@override@JsonKey() final  bool isThursday;
@override@JsonKey() final  bool isFriday;
@override@JsonKey() final  bool isSaturday;
@override@JsonKey() final  bool isSunday;

/// Create a copy of DutyDay
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DutyDayCopyWith<_DutyDay> get copyWith => __$DutyDayCopyWithImpl<_DutyDay>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DutyDayToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DutyDay&&(identical(other.scheduleId, scheduleId) || other.scheduleId == scheduleId)&&(identical(other.isMonday, isMonday) || other.isMonday == isMonday)&&(identical(other.isTuesday, isTuesday) || other.isTuesday == isTuesday)&&(identical(other.isWednesday, isWednesday) || other.isWednesday == isWednesday)&&(identical(other.isThursday, isThursday) || other.isThursday == isThursday)&&(identical(other.isFriday, isFriday) || other.isFriday == isFriday)&&(identical(other.isSaturday, isSaturday) || other.isSaturday == isSaturday)&&(identical(other.isSunday, isSunday) || other.isSunday == isSunday));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,scheduleId,isMonday,isTuesday,isWednesday,isThursday,isFriday,isSaturday,isSunday);

@override
String toString() {
  return 'DutyDay(scheduleId: $scheduleId, isMonday: $isMonday, isTuesday: $isTuesday, isWednesday: $isWednesday, isThursday: $isThursday, isFriday: $isFriday, isSaturday: $isSaturday, isSunday: $isSunday)';
}


}

/// @nodoc
abstract mixin class _$DutyDayCopyWith<$Res> implements $DutyDayCopyWith<$Res> {
  factory _$DutyDayCopyWith(_DutyDay value, $Res Function(_DutyDay) _then) = __$DutyDayCopyWithImpl;
@override @useResult
$Res call({
 int scheduleId, bool isMonday, bool isTuesday, bool isWednesday, bool isThursday, bool isFriday, bool isSaturday, bool isSunday
});




}
/// @nodoc
class __$DutyDayCopyWithImpl<$Res>
    implements _$DutyDayCopyWith<$Res> {
  __$DutyDayCopyWithImpl(this._self, this._then);

  final _DutyDay _self;
  final $Res Function(_DutyDay) _then;

/// Create a copy of DutyDay
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? scheduleId = null,Object? isMonday = null,Object? isTuesday = null,Object? isWednesday = null,Object? isThursday = null,Object? isFriday = null,Object? isSaturday = null,Object? isSunday = null,}) {
  return _then(_DutyDay(
scheduleId: null == scheduleId ? _self.scheduleId : scheduleId // ignore: cast_nullable_to_non_nullable
as int,isMonday: null == isMonday ? _self.isMonday : isMonday // ignore: cast_nullable_to_non_nullable
as bool,isTuesday: null == isTuesday ? _self.isTuesday : isTuesday // ignore: cast_nullable_to_non_nullable
as bool,isWednesday: null == isWednesday ? _self.isWednesday : isWednesday // ignore: cast_nullable_to_non_nullable
as bool,isThursday: null == isThursday ? _self.isThursday : isThursday // ignore: cast_nullable_to_non_nullable
as bool,isFriday: null == isFriday ? _self.isFriday : isFriday // ignore: cast_nullable_to_non_nullable
as bool,isSaturday: null == isSaturday ? _self.isSaturday : isSaturday // ignore: cast_nullable_to_non_nullable
as bool,isSunday: null == isSunday ? _self.isSunday : isSunday // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
