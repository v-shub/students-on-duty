// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'duty_schedule.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$DutySchedule {

 int get id;@JsonKey(name: 'group_id') int get groupId;@JsonKey(name: 'duty_type_id') int get dutyTypeId;@JsonKey(name: 'students_per_day') int get studentsPerDay;@JsonKey(name: 'start_date') DateTime get startDate;@JsonKey(name: 'end_date') DateTime? get endDate;@JsonKey(name: 'is_active') bool get isActive;
/// Create a copy of DutySchedule
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DutyScheduleCopyWith<DutySchedule> get copyWith => _$DutyScheduleCopyWithImpl<DutySchedule>(this as DutySchedule, _$identity);

  /// Serializes this DutySchedule to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DutySchedule&&(identical(other.id, id) || other.id == id)&&(identical(other.groupId, groupId) || other.groupId == groupId)&&(identical(other.dutyTypeId, dutyTypeId) || other.dutyTypeId == dutyTypeId)&&(identical(other.studentsPerDay, studentsPerDay) || other.studentsPerDay == studentsPerDay)&&(identical(other.startDate, startDate) || other.startDate == startDate)&&(identical(other.endDate, endDate) || other.endDate == endDate)&&(identical(other.isActive, isActive) || other.isActive == isActive));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,groupId,dutyTypeId,studentsPerDay,startDate,endDate,isActive);

@override
String toString() {
  return 'DutySchedule(id: $id, groupId: $groupId, dutyTypeId: $dutyTypeId, studentsPerDay: $studentsPerDay, startDate: $startDate, endDate: $endDate, isActive: $isActive)';
}


}

/// @nodoc
abstract mixin class $DutyScheduleCopyWith<$Res>  {
  factory $DutyScheduleCopyWith(DutySchedule value, $Res Function(DutySchedule) _then) = _$DutyScheduleCopyWithImpl;
@useResult
$Res call({
 int id,@JsonKey(name: 'group_id') int groupId,@JsonKey(name: 'duty_type_id') int dutyTypeId,@JsonKey(name: 'students_per_day') int studentsPerDay,@JsonKey(name: 'start_date') DateTime startDate,@JsonKey(name: 'end_date') DateTime? endDate,@JsonKey(name: 'is_active') bool isActive
});




}
/// @nodoc
class _$DutyScheduleCopyWithImpl<$Res>
    implements $DutyScheduleCopyWith<$Res> {
  _$DutyScheduleCopyWithImpl(this._self, this._then);

  final DutySchedule _self;
  final $Res Function(DutySchedule) _then;

/// Create a copy of DutySchedule
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? groupId = null,Object? dutyTypeId = null,Object? studentsPerDay = null,Object? startDate = null,Object? endDate = freezed,Object? isActive = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,groupId: null == groupId ? _self.groupId : groupId // ignore: cast_nullable_to_non_nullable
as int,dutyTypeId: null == dutyTypeId ? _self.dutyTypeId : dutyTypeId // ignore: cast_nullable_to_non_nullable
as int,studentsPerDay: null == studentsPerDay ? _self.studentsPerDay : studentsPerDay // ignore: cast_nullable_to_non_nullable
as int,startDate: null == startDate ? _self.startDate : startDate // ignore: cast_nullable_to_non_nullable
as DateTime,endDate: freezed == endDate ? _self.endDate : endDate // ignore: cast_nullable_to_non_nullable
as DateTime?,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [DutySchedule].
extension DutySchedulePatterns on DutySchedule {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DutySchedule value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DutySchedule() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DutySchedule value)  $default,){
final _that = this;
switch (_that) {
case _DutySchedule():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DutySchedule value)?  $default,){
final _that = this;
switch (_that) {
case _DutySchedule() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id, @JsonKey(name: 'group_id')  int groupId, @JsonKey(name: 'duty_type_id')  int dutyTypeId, @JsonKey(name: 'students_per_day')  int studentsPerDay, @JsonKey(name: 'start_date')  DateTime startDate, @JsonKey(name: 'end_date')  DateTime? endDate, @JsonKey(name: 'is_active')  bool isActive)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DutySchedule() when $default != null:
return $default(_that.id,_that.groupId,_that.dutyTypeId,_that.studentsPerDay,_that.startDate,_that.endDate,_that.isActive);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id, @JsonKey(name: 'group_id')  int groupId, @JsonKey(name: 'duty_type_id')  int dutyTypeId, @JsonKey(name: 'students_per_day')  int studentsPerDay, @JsonKey(name: 'start_date')  DateTime startDate, @JsonKey(name: 'end_date')  DateTime? endDate, @JsonKey(name: 'is_active')  bool isActive)  $default,) {final _that = this;
switch (_that) {
case _DutySchedule():
return $default(_that.id,_that.groupId,_that.dutyTypeId,_that.studentsPerDay,_that.startDate,_that.endDate,_that.isActive);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id, @JsonKey(name: 'group_id')  int groupId, @JsonKey(name: 'duty_type_id')  int dutyTypeId, @JsonKey(name: 'students_per_day')  int studentsPerDay, @JsonKey(name: 'start_date')  DateTime startDate, @JsonKey(name: 'end_date')  DateTime? endDate, @JsonKey(name: 'is_active')  bool isActive)?  $default,) {final _that = this;
switch (_that) {
case _DutySchedule() when $default != null:
return $default(_that.id,_that.groupId,_that.dutyTypeId,_that.studentsPerDay,_that.startDate,_that.endDate,_that.isActive);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DutySchedule implements DutySchedule {
  const _DutySchedule({required this.id, @JsonKey(name: 'group_id') required this.groupId, @JsonKey(name: 'duty_type_id') required this.dutyTypeId, @JsonKey(name: 'students_per_day') required this.studentsPerDay, @JsonKey(name: 'start_date') required this.startDate, @JsonKey(name: 'end_date') this.endDate, @JsonKey(name: 'is_active') this.isActive = true});
  factory _DutySchedule.fromJson(Map<String, dynamic> json) => _$DutyScheduleFromJson(json);

@override final  int id;
@override@JsonKey(name: 'group_id') final  int groupId;
@override@JsonKey(name: 'duty_type_id') final  int dutyTypeId;
@override@JsonKey(name: 'students_per_day') final  int studentsPerDay;
@override@JsonKey(name: 'start_date') final  DateTime startDate;
@override@JsonKey(name: 'end_date') final  DateTime? endDate;
@override@JsonKey(name: 'is_active') final  bool isActive;

/// Create a copy of DutySchedule
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DutyScheduleCopyWith<_DutySchedule> get copyWith => __$DutyScheduleCopyWithImpl<_DutySchedule>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DutyScheduleToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DutySchedule&&(identical(other.id, id) || other.id == id)&&(identical(other.groupId, groupId) || other.groupId == groupId)&&(identical(other.dutyTypeId, dutyTypeId) || other.dutyTypeId == dutyTypeId)&&(identical(other.studentsPerDay, studentsPerDay) || other.studentsPerDay == studentsPerDay)&&(identical(other.startDate, startDate) || other.startDate == startDate)&&(identical(other.endDate, endDate) || other.endDate == endDate)&&(identical(other.isActive, isActive) || other.isActive == isActive));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,groupId,dutyTypeId,studentsPerDay,startDate,endDate,isActive);

@override
String toString() {
  return 'DutySchedule(id: $id, groupId: $groupId, dutyTypeId: $dutyTypeId, studentsPerDay: $studentsPerDay, startDate: $startDate, endDate: $endDate, isActive: $isActive)';
}


}

/// @nodoc
abstract mixin class _$DutyScheduleCopyWith<$Res> implements $DutyScheduleCopyWith<$Res> {
  factory _$DutyScheduleCopyWith(_DutySchedule value, $Res Function(_DutySchedule) _then) = __$DutyScheduleCopyWithImpl;
@override @useResult
$Res call({
 int id,@JsonKey(name: 'group_id') int groupId,@JsonKey(name: 'duty_type_id') int dutyTypeId,@JsonKey(name: 'students_per_day') int studentsPerDay,@JsonKey(name: 'start_date') DateTime startDate,@JsonKey(name: 'end_date') DateTime? endDate,@JsonKey(name: 'is_active') bool isActive
});




}
/// @nodoc
class __$DutyScheduleCopyWithImpl<$Res>
    implements _$DutyScheduleCopyWith<$Res> {
  __$DutyScheduleCopyWithImpl(this._self, this._then);

  final _DutySchedule _self;
  final $Res Function(_DutySchedule) _then;

/// Create a copy of DutySchedule
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? groupId = null,Object? dutyTypeId = null,Object? studentsPerDay = null,Object? startDate = null,Object? endDate = freezed,Object? isActive = null,}) {
  return _then(_DutySchedule(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,groupId: null == groupId ? _self.groupId : groupId // ignore: cast_nullable_to_non_nullable
as int,dutyTypeId: null == dutyTypeId ? _self.dutyTypeId : dutyTypeId // ignore: cast_nullable_to_non_nullable
as int,studentsPerDay: null == studentsPerDay ? _self.studentsPerDay : studentsPerDay // ignore: cast_nullable_to_non_nullable
as int,startDate: null == startDate ? _self.startDate : startDate // ignore: cast_nullable_to_non_nullable
as DateTime,endDate: freezed == endDate ? _self.endDate : endDate // ignore: cast_nullable_to_non_nullable
as DateTime?,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
