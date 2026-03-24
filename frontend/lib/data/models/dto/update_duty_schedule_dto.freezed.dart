// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'update_duty_schedule_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$UpdateDutyScheduleDto {

@JsonKey(name: 'duty_type_id') int? get dutyTypeId;@JsonKey(name: 'students_per_day') int? get studentsPerDay;@JsonKey(name: 'start_date') String? get startDate;@JsonKey(name: 'end_date') String? get endDate;@JsonKey(name: 'is_active') bool? get isActive;@JsonKey(name: 'duty_days') Map<String, bool>? get dutyDays;
/// Create a copy of UpdateDutyScheduleDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UpdateDutyScheduleDtoCopyWith<UpdateDutyScheduleDto> get copyWith => _$UpdateDutyScheduleDtoCopyWithImpl<UpdateDutyScheduleDto>(this as UpdateDutyScheduleDto, _$identity);

  /// Serializes this UpdateDutyScheduleDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UpdateDutyScheduleDto&&(identical(other.dutyTypeId, dutyTypeId) || other.dutyTypeId == dutyTypeId)&&(identical(other.studentsPerDay, studentsPerDay) || other.studentsPerDay == studentsPerDay)&&(identical(other.startDate, startDate) || other.startDate == startDate)&&(identical(other.endDate, endDate) || other.endDate == endDate)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&const DeepCollectionEquality().equals(other.dutyDays, dutyDays));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,dutyTypeId,studentsPerDay,startDate,endDate,isActive,const DeepCollectionEquality().hash(dutyDays));

@override
String toString() {
  return 'UpdateDutyScheduleDto(dutyTypeId: $dutyTypeId, studentsPerDay: $studentsPerDay, startDate: $startDate, endDate: $endDate, isActive: $isActive, dutyDays: $dutyDays)';
}


}

/// @nodoc
abstract mixin class $UpdateDutyScheduleDtoCopyWith<$Res>  {
  factory $UpdateDutyScheduleDtoCopyWith(UpdateDutyScheduleDto value, $Res Function(UpdateDutyScheduleDto) _then) = _$UpdateDutyScheduleDtoCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'duty_type_id') int? dutyTypeId,@JsonKey(name: 'students_per_day') int? studentsPerDay,@JsonKey(name: 'start_date') String? startDate,@JsonKey(name: 'end_date') String? endDate,@JsonKey(name: 'is_active') bool? isActive,@JsonKey(name: 'duty_days') Map<String, bool>? dutyDays
});




}
/// @nodoc
class _$UpdateDutyScheduleDtoCopyWithImpl<$Res>
    implements $UpdateDutyScheduleDtoCopyWith<$Res> {
  _$UpdateDutyScheduleDtoCopyWithImpl(this._self, this._then);

  final UpdateDutyScheduleDto _self;
  final $Res Function(UpdateDutyScheduleDto) _then;

/// Create a copy of UpdateDutyScheduleDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? dutyTypeId = freezed,Object? studentsPerDay = freezed,Object? startDate = freezed,Object? endDate = freezed,Object? isActive = freezed,Object? dutyDays = freezed,}) {
  return _then(_self.copyWith(
dutyTypeId: freezed == dutyTypeId ? _self.dutyTypeId : dutyTypeId // ignore: cast_nullable_to_non_nullable
as int?,studentsPerDay: freezed == studentsPerDay ? _self.studentsPerDay : studentsPerDay // ignore: cast_nullable_to_non_nullable
as int?,startDate: freezed == startDate ? _self.startDate : startDate // ignore: cast_nullable_to_non_nullable
as String?,endDate: freezed == endDate ? _self.endDate : endDate // ignore: cast_nullable_to_non_nullable
as String?,isActive: freezed == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool?,dutyDays: freezed == dutyDays ? _self.dutyDays : dutyDays // ignore: cast_nullable_to_non_nullable
as Map<String, bool>?,
  ));
}

}


/// Adds pattern-matching-related methods to [UpdateDutyScheduleDto].
extension UpdateDutyScheduleDtoPatterns on UpdateDutyScheduleDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UpdateDutyScheduleDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UpdateDutyScheduleDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UpdateDutyScheduleDto value)  $default,){
final _that = this;
switch (_that) {
case _UpdateDutyScheduleDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UpdateDutyScheduleDto value)?  $default,){
final _that = this;
switch (_that) {
case _UpdateDutyScheduleDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'duty_type_id')  int? dutyTypeId, @JsonKey(name: 'students_per_day')  int? studentsPerDay, @JsonKey(name: 'start_date')  String? startDate, @JsonKey(name: 'end_date')  String? endDate, @JsonKey(name: 'is_active')  bool? isActive, @JsonKey(name: 'duty_days')  Map<String, bool>? dutyDays)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UpdateDutyScheduleDto() when $default != null:
return $default(_that.dutyTypeId,_that.studentsPerDay,_that.startDate,_that.endDate,_that.isActive,_that.dutyDays);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'duty_type_id')  int? dutyTypeId, @JsonKey(name: 'students_per_day')  int? studentsPerDay, @JsonKey(name: 'start_date')  String? startDate, @JsonKey(name: 'end_date')  String? endDate, @JsonKey(name: 'is_active')  bool? isActive, @JsonKey(name: 'duty_days')  Map<String, bool>? dutyDays)  $default,) {final _that = this;
switch (_that) {
case _UpdateDutyScheduleDto():
return $default(_that.dutyTypeId,_that.studentsPerDay,_that.startDate,_that.endDate,_that.isActive,_that.dutyDays);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'duty_type_id')  int? dutyTypeId, @JsonKey(name: 'students_per_day')  int? studentsPerDay, @JsonKey(name: 'start_date')  String? startDate, @JsonKey(name: 'end_date')  String? endDate, @JsonKey(name: 'is_active')  bool? isActive, @JsonKey(name: 'duty_days')  Map<String, bool>? dutyDays)?  $default,) {final _that = this;
switch (_that) {
case _UpdateDutyScheduleDto() when $default != null:
return $default(_that.dutyTypeId,_that.studentsPerDay,_that.startDate,_that.endDate,_that.isActive,_that.dutyDays);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _UpdateDutyScheduleDto implements UpdateDutyScheduleDto {
  const _UpdateDutyScheduleDto({@JsonKey(name: 'duty_type_id') this.dutyTypeId, @JsonKey(name: 'students_per_day') this.studentsPerDay, @JsonKey(name: 'start_date') this.startDate, @JsonKey(name: 'end_date') this.endDate, @JsonKey(name: 'is_active') this.isActive, @JsonKey(name: 'duty_days') final  Map<String, bool>? dutyDays}): _dutyDays = dutyDays;
  factory _UpdateDutyScheduleDto.fromJson(Map<String, dynamic> json) => _$UpdateDutyScheduleDtoFromJson(json);

@override@JsonKey(name: 'duty_type_id') final  int? dutyTypeId;
@override@JsonKey(name: 'students_per_day') final  int? studentsPerDay;
@override@JsonKey(name: 'start_date') final  String? startDate;
@override@JsonKey(name: 'end_date') final  String? endDate;
@override@JsonKey(name: 'is_active') final  bool? isActive;
 final  Map<String, bool>? _dutyDays;
@override@JsonKey(name: 'duty_days') Map<String, bool>? get dutyDays {
  final value = _dutyDays;
  if (value == null) return null;
  if (_dutyDays is EqualUnmodifiableMapView) return _dutyDays;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}


/// Create a copy of UpdateDutyScheduleDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UpdateDutyScheduleDtoCopyWith<_UpdateDutyScheduleDto> get copyWith => __$UpdateDutyScheduleDtoCopyWithImpl<_UpdateDutyScheduleDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UpdateDutyScheduleDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UpdateDutyScheduleDto&&(identical(other.dutyTypeId, dutyTypeId) || other.dutyTypeId == dutyTypeId)&&(identical(other.studentsPerDay, studentsPerDay) || other.studentsPerDay == studentsPerDay)&&(identical(other.startDate, startDate) || other.startDate == startDate)&&(identical(other.endDate, endDate) || other.endDate == endDate)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&const DeepCollectionEquality().equals(other._dutyDays, _dutyDays));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,dutyTypeId,studentsPerDay,startDate,endDate,isActive,const DeepCollectionEquality().hash(_dutyDays));

@override
String toString() {
  return 'UpdateDutyScheduleDto(dutyTypeId: $dutyTypeId, studentsPerDay: $studentsPerDay, startDate: $startDate, endDate: $endDate, isActive: $isActive, dutyDays: $dutyDays)';
}


}

/// @nodoc
abstract mixin class _$UpdateDutyScheduleDtoCopyWith<$Res> implements $UpdateDutyScheduleDtoCopyWith<$Res> {
  factory _$UpdateDutyScheduleDtoCopyWith(_UpdateDutyScheduleDto value, $Res Function(_UpdateDutyScheduleDto) _then) = __$UpdateDutyScheduleDtoCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'duty_type_id') int? dutyTypeId,@JsonKey(name: 'students_per_day') int? studentsPerDay,@JsonKey(name: 'start_date') String? startDate,@JsonKey(name: 'end_date') String? endDate,@JsonKey(name: 'is_active') bool? isActive,@JsonKey(name: 'duty_days') Map<String, bool>? dutyDays
});




}
/// @nodoc
class __$UpdateDutyScheduleDtoCopyWithImpl<$Res>
    implements _$UpdateDutyScheduleDtoCopyWith<$Res> {
  __$UpdateDutyScheduleDtoCopyWithImpl(this._self, this._then);

  final _UpdateDutyScheduleDto _self;
  final $Res Function(_UpdateDutyScheduleDto) _then;

/// Create a copy of UpdateDutyScheduleDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? dutyTypeId = freezed,Object? studentsPerDay = freezed,Object? startDate = freezed,Object? endDate = freezed,Object? isActive = freezed,Object? dutyDays = freezed,}) {
  return _then(_UpdateDutyScheduleDto(
dutyTypeId: freezed == dutyTypeId ? _self.dutyTypeId : dutyTypeId // ignore: cast_nullable_to_non_nullable
as int?,studentsPerDay: freezed == studentsPerDay ? _self.studentsPerDay : studentsPerDay // ignore: cast_nullable_to_non_nullable
as int?,startDate: freezed == startDate ? _self.startDate : startDate // ignore: cast_nullable_to_non_nullable
as String?,endDate: freezed == endDate ? _self.endDate : endDate // ignore: cast_nullable_to_non_nullable
as String?,isActive: freezed == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool?,dutyDays: freezed == dutyDays ? _self._dutyDays : dutyDays // ignore: cast_nullable_to_non_nullable
as Map<String, bool>?,
  ));
}


}

// dart format on
