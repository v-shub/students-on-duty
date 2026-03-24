// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'create_duty_schedule_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CreateDutyScheduleDto {

 int get groupId; int get dutyTypeId; int get studentsPerDay; String get startDate; String? get endDate; Map<String, bool>? get dutyDays;
/// Create a copy of CreateDutyScheduleDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CreateDutyScheduleDtoCopyWith<CreateDutyScheduleDto> get copyWith => _$CreateDutyScheduleDtoCopyWithImpl<CreateDutyScheduleDto>(this as CreateDutyScheduleDto, _$identity);

  /// Serializes this CreateDutyScheduleDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CreateDutyScheduleDto&&(identical(other.groupId, groupId) || other.groupId == groupId)&&(identical(other.dutyTypeId, dutyTypeId) || other.dutyTypeId == dutyTypeId)&&(identical(other.studentsPerDay, studentsPerDay) || other.studentsPerDay == studentsPerDay)&&(identical(other.startDate, startDate) || other.startDate == startDate)&&(identical(other.endDate, endDate) || other.endDate == endDate)&&const DeepCollectionEquality().equals(other.dutyDays, dutyDays));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,groupId,dutyTypeId,studentsPerDay,startDate,endDate,const DeepCollectionEquality().hash(dutyDays));

@override
String toString() {
  return 'CreateDutyScheduleDto(groupId: $groupId, dutyTypeId: $dutyTypeId, studentsPerDay: $studentsPerDay, startDate: $startDate, endDate: $endDate, dutyDays: $dutyDays)';
}


}

/// @nodoc
abstract mixin class $CreateDutyScheduleDtoCopyWith<$Res>  {
  factory $CreateDutyScheduleDtoCopyWith(CreateDutyScheduleDto value, $Res Function(CreateDutyScheduleDto) _then) = _$CreateDutyScheduleDtoCopyWithImpl;
@useResult
$Res call({
 int groupId, int dutyTypeId, int studentsPerDay, String startDate, String? endDate, Map<String, bool>? dutyDays
});




}
/// @nodoc
class _$CreateDutyScheduleDtoCopyWithImpl<$Res>
    implements $CreateDutyScheduleDtoCopyWith<$Res> {
  _$CreateDutyScheduleDtoCopyWithImpl(this._self, this._then);

  final CreateDutyScheduleDto _self;
  final $Res Function(CreateDutyScheduleDto) _then;

/// Create a copy of CreateDutyScheduleDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? groupId = null,Object? dutyTypeId = null,Object? studentsPerDay = null,Object? startDate = null,Object? endDate = freezed,Object? dutyDays = freezed,}) {
  return _then(_self.copyWith(
groupId: null == groupId ? _self.groupId : groupId // ignore: cast_nullable_to_non_nullable
as int,dutyTypeId: null == dutyTypeId ? _self.dutyTypeId : dutyTypeId // ignore: cast_nullable_to_non_nullable
as int,studentsPerDay: null == studentsPerDay ? _self.studentsPerDay : studentsPerDay // ignore: cast_nullable_to_non_nullable
as int,startDate: null == startDate ? _self.startDate : startDate // ignore: cast_nullable_to_non_nullable
as String,endDate: freezed == endDate ? _self.endDate : endDate // ignore: cast_nullable_to_non_nullable
as String?,dutyDays: freezed == dutyDays ? _self.dutyDays : dutyDays // ignore: cast_nullable_to_non_nullable
as Map<String, bool>?,
  ));
}

}


/// Adds pattern-matching-related methods to [CreateDutyScheduleDto].
extension CreateDutyScheduleDtoPatterns on CreateDutyScheduleDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CreateDutyScheduleDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CreateDutyScheduleDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CreateDutyScheduleDto value)  $default,){
final _that = this;
switch (_that) {
case _CreateDutyScheduleDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CreateDutyScheduleDto value)?  $default,){
final _that = this;
switch (_that) {
case _CreateDutyScheduleDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int groupId,  int dutyTypeId,  int studentsPerDay,  String startDate,  String? endDate,  Map<String, bool>? dutyDays)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CreateDutyScheduleDto() when $default != null:
return $default(_that.groupId,_that.dutyTypeId,_that.studentsPerDay,_that.startDate,_that.endDate,_that.dutyDays);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int groupId,  int dutyTypeId,  int studentsPerDay,  String startDate,  String? endDate,  Map<String, bool>? dutyDays)  $default,) {final _that = this;
switch (_that) {
case _CreateDutyScheduleDto():
return $default(_that.groupId,_that.dutyTypeId,_that.studentsPerDay,_that.startDate,_that.endDate,_that.dutyDays);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int groupId,  int dutyTypeId,  int studentsPerDay,  String startDate,  String? endDate,  Map<String, bool>? dutyDays)?  $default,) {final _that = this;
switch (_that) {
case _CreateDutyScheduleDto() when $default != null:
return $default(_that.groupId,_that.dutyTypeId,_that.studentsPerDay,_that.startDate,_that.endDate,_that.dutyDays);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CreateDutyScheduleDto implements CreateDutyScheduleDto {
  const _CreateDutyScheduleDto({required this.groupId, required this.dutyTypeId, required this.studentsPerDay, required this.startDate, this.endDate, final  Map<String, bool>? dutyDays}): _dutyDays = dutyDays;
  factory _CreateDutyScheduleDto.fromJson(Map<String, dynamic> json) => _$CreateDutyScheduleDtoFromJson(json);

@override final  int groupId;
@override final  int dutyTypeId;
@override final  int studentsPerDay;
@override final  String startDate;
@override final  String? endDate;
 final  Map<String, bool>? _dutyDays;
@override Map<String, bool>? get dutyDays {
  final value = _dutyDays;
  if (value == null) return null;
  if (_dutyDays is EqualUnmodifiableMapView) return _dutyDays;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}


/// Create a copy of CreateDutyScheduleDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CreateDutyScheduleDtoCopyWith<_CreateDutyScheduleDto> get copyWith => __$CreateDutyScheduleDtoCopyWithImpl<_CreateDutyScheduleDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CreateDutyScheduleDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CreateDutyScheduleDto&&(identical(other.groupId, groupId) || other.groupId == groupId)&&(identical(other.dutyTypeId, dutyTypeId) || other.dutyTypeId == dutyTypeId)&&(identical(other.studentsPerDay, studentsPerDay) || other.studentsPerDay == studentsPerDay)&&(identical(other.startDate, startDate) || other.startDate == startDate)&&(identical(other.endDate, endDate) || other.endDate == endDate)&&const DeepCollectionEquality().equals(other._dutyDays, _dutyDays));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,groupId,dutyTypeId,studentsPerDay,startDate,endDate,const DeepCollectionEquality().hash(_dutyDays));

@override
String toString() {
  return 'CreateDutyScheduleDto(groupId: $groupId, dutyTypeId: $dutyTypeId, studentsPerDay: $studentsPerDay, startDate: $startDate, endDate: $endDate, dutyDays: $dutyDays)';
}


}

/// @nodoc
abstract mixin class _$CreateDutyScheduleDtoCopyWith<$Res> implements $CreateDutyScheduleDtoCopyWith<$Res> {
  factory _$CreateDutyScheduleDtoCopyWith(_CreateDutyScheduleDto value, $Res Function(_CreateDutyScheduleDto) _then) = __$CreateDutyScheduleDtoCopyWithImpl;
@override @useResult
$Res call({
 int groupId, int dutyTypeId, int studentsPerDay, String startDate, String? endDate, Map<String, bool>? dutyDays
});




}
/// @nodoc
class __$CreateDutyScheduleDtoCopyWithImpl<$Res>
    implements _$CreateDutyScheduleDtoCopyWith<$Res> {
  __$CreateDutyScheduleDtoCopyWithImpl(this._self, this._then);

  final _CreateDutyScheduleDto _self;
  final $Res Function(_CreateDutyScheduleDto) _then;

/// Create a copy of CreateDutyScheduleDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? groupId = null,Object? dutyTypeId = null,Object? studentsPerDay = null,Object? startDate = null,Object? endDate = freezed,Object? dutyDays = freezed,}) {
  return _then(_CreateDutyScheduleDto(
groupId: null == groupId ? _self.groupId : groupId // ignore: cast_nullable_to_non_nullable
as int,dutyTypeId: null == dutyTypeId ? _self.dutyTypeId : dutyTypeId // ignore: cast_nullable_to_non_nullable
as int,studentsPerDay: null == studentsPerDay ? _self.studentsPerDay : studentsPerDay // ignore: cast_nullable_to_non_nullable
as int,startDate: null == startDate ? _self.startDate : startDate // ignore: cast_nullable_to_non_nullable
as String,endDate: freezed == endDate ? _self.endDate : endDate // ignore: cast_nullable_to_non_nullable
as String?,dutyDays: freezed == dutyDays ? _self._dutyDays : dutyDays // ignore: cast_nullable_to_non_nullable
as Map<String, bool>?,
  ));
}


}

// dart format on
