// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'duty_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$DutyEvent {

 int get id;@JsonKey(name: 'student_id') int get studentId;@JsonKey(name: 'schedule_id') int get scheduleId;@JsonKey(name: 'duty_date') DateTime get dutyDate; DutyEventStatus get status;@JsonKey(name: 'score_earned') int? get scoreEarned; String? get notes;@JsonKey(name: 'assigned_at') DateTime? get assignedAt;
/// Create a copy of DutyEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DutyEventCopyWith<DutyEvent> get copyWith => _$DutyEventCopyWithImpl<DutyEvent>(this as DutyEvent, _$identity);

  /// Serializes this DutyEvent to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DutyEvent&&(identical(other.id, id) || other.id == id)&&(identical(other.studentId, studentId) || other.studentId == studentId)&&(identical(other.scheduleId, scheduleId) || other.scheduleId == scheduleId)&&(identical(other.dutyDate, dutyDate) || other.dutyDate == dutyDate)&&(identical(other.status, status) || other.status == status)&&(identical(other.scoreEarned, scoreEarned) || other.scoreEarned == scoreEarned)&&(identical(other.notes, notes) || other.notes == notes)&&(identical(other.assignedAt, assignedAt) || other.assignedAt == assignedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,studentId,scheduleId,dutyDate,status,scoreEarned,notes,assignedAt);

@override
String toString() {
  return 'DutyEvent(id: $id, studentId: $studentId, scheduleId: $scheduleId, dutyDate: $dutyDate, status: $status, scoreEarned: $scoreEarned, notes: $notes, assignedAt: $assignedAt)';
}


}

/// @nodoc
abstract mixin class $DutyEventCopyWith<$Res>  {
  factory $DutyEventCopyWith(DutyEvent value, $Res Function(DutyEvent) _then) = _$DutyEventCopyWithImpl;
@useResult
$Res call({
 int id,@JsonKey(name: 'student_id') int studentId,@JsonKey(name: 'schedule_id') int scheduleId,@JsonKey(name: 'duty_date') DateTime dutyDate, DutyEventStatus status,@JsonKey(name: 'score_earned') int? scoreEarned, String? notes,@JsonKey(name: 'assigned_at') DateTime? assignedAt
});




}
/// @nodoc
class _$DutyEventCopyWithImpl<$Res>
    implements $DutyEventCopyWith<$Res> {
  _$DutyEventCopyWithImpl(this._self, this._then);

  final DutyEvent _self;
  final $Res Function(DutyEvent) _then;

/// Create a copy of DutyEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? studentId = null,Object? scheduleId = null,Object? dutyDate = null,Object? status = null,Object? scoreEarned = freezed,Object? notes = freezed,Object? assignedAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,studentId: null == studentId ? _self.studentId : studentId // ignore: cast_nullable_to_non_nullable
as int,scheduleId: null == scheduleId ? _self.scheduleId : scheduleId // ignore: cast_nullable_to_non_nullable
as int,dutyDate: null == dutyDate ? _self.dutyDate : dutyDate // ignore: cast_nullable_to_non_nullable
as DateTime,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as DutyEventStatus,scoreEarned: freezed == scoreEarned ? _self.scoreEarned : scoreEarned // ignore: cast_nullable_to_non_nullable
as int?,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,assignedAt: freezed == assignedAt ? _self.assignedAt : assignedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [DutyEvent].
extension DutyEventPatterns on DutyEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DutyEvent value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DutyEvent() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DutyEvent value)  $default,){
final _that = this;
switch (_that) {
case _DutyEvent():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DutyEvent value)?  $default,){
final _that = this;
switch (_that) {
case _DutyEvent() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id, @JsonKey(name: 'student_id')  int studentId, @JsonKey(name: 'schedule_id')  int scheduleId, @JsonKey(name: 'duty_date')  DateTime dutyDate,  DutyEventStatus status, @JsonKey(name: 'score_earned')  int? scoreEarned,  String? notes, @JsonKey(name: 'assigned_at')  DateTime? assignedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DutyEvent() when $default != null:
return $default(_that.id,_that.studentId,_that.scheduleId,_that.dutyDate,_that.status,_that.scoreEarned,_that.notes,_that.assignedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id, @JsonKey(name: 'student_id')  int studentId, @JsonKey(name: 'schedule_id')  int scheduleId, @JsonKey(name: 'duty_date')  DateTime dutyDate,  DutyEventStatus status, @JsonKey(name: 'score_earned')  int? scoreEarned,  String? notes, @JsonKey(name: 'assigned_at')  DateTime? assignedAt)  $default,) {final _that = this;
switch (_that) {
case _DutyEvent():
return $default(_that.id,_that.studentId,_that.scheduleId,_that.dutyDate,_that.status,_that.scoreEarned,_that.notes,_that.assignedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id, @JsonKey(name: 'student_id')  int studentId, @JsonKey(name: 'schedule_id')  int scheduleId, @JsonKey(name: 'duty_date')  DateTime dutyDate,  DutyEventStatus status, @JsonKey(name: 'score_earned')  int? scoreEarned,  String? notes, @JsonKey(name: 'assigned_at')  DateTime? assignedAt)?  $default,) {final _that = this;
switch (_that) {
case _DutyEvent() when $default != null:
return $default(_that.id,_that.studentId,_that.scheduleId,_that.dutyDate,_that.status,_that.scoreEarned,_that.notes,_that.assignedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DutyEvent implements DutyEvent {
  const _DutyEvent({required this.id, @JsonKey(name: 'student_id') required this.studentId, @JsonKey(name: 'schedule_id') required this.scheduleId, @JsonKey(name: 'duty_date') required this.dutyDate, required this.status, @JsonKey(name: 'score_earned') this.scoreEarned, this.notes, @JsonKey(name: 'assigned_at') this.assignedAt});
  factory _DutyEvent.fromJson(Map<String, dynamic> json) => _$DutyEventFromJson(json);

@override final  int id;
@override@JsonKey(name: 'student_id') final  int studentId;
@override@JsonKey(name: 'schedule_id') final  int scheduleId;
@override@JsonKey(name: 'duty_date') final  DateTime dutyDate;
@override final  DutyEventStatus status;
@override@JsonKey(name: 'score_earned') final  int? scoreEarned;
@override final  String? notes;
@override@JsonKey(name: 'assigned_at') final  DateTime? assignedAt;

/// Create a copy of DutyEvent
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DutyEventCopyWith<_DutyEvent> get copyWith => __$DutyEventCopyWithImpl<_DutyEvent>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DutyEventToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DutyEvent&&(identical(other.id, id) || other.id == id)&&(identical(other.studentId, studentId) || other.studentId == studentId)&&(identical(other.scheduleId, scheduleId) || other.scheduleId == scheduleId)&&(identical(other.dutyDate, dutyDate) || other.dutyDate == dutyDate)&&(identical(other.status, status) || other.status == status)&&(identical(other.scoreEarned, scoreEarned) || other.scoreEarned == scoreEarned)&&(identical(other.notes, notes) || other.notes == notes)&&(identical(other.assignedAt, assignedAt) || other.assignedAt == assignedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,studentId,scheduleId,dutyDate,status,scoreEarned,notes,assignedAt);

@override
String toString() {
  return 'DutyEvent(id: $id, studentId: $studentId, scheduleId: $scheduleId, dutyDate: $dutyDate, status: $status, scoreEarned: $scoreEarned, notes: $notes, assignedAt: $assignedAt)';
}


}

/// @nodoc
abstract mixin class _$DutyEventCopyWith<$Res> implements $DutyEventCopyWith<$Res> {
  factory _$DutyEventCopyWith(_DutyEvent value, $Res Function(_DutyEvent) _then) = __$DutyEventCopyWithImpl;
@override @useResult
$Res call({
 int id,@JsonKey(name: 'student_id') int studentId,@JsonKey(name: 'schedule_id') int scheduleId,@JsonKey(name: 'duty_date') DateTime dutyDate, DutyEventStatus status,@JsonKey(name: 'score_earned') int? scoreEarned, String? notes,@JsonKey(name: 'assigned_at') DateTime? assignedAt
});




}
/// @nodoc
class __$DutyEventCopyWithImpl<$Res>
    implements _$DutyEventCopyWith<$Res> {
  __$DutyEventCopyWithImpl(this._self, this._then);

  final _DutyEvent _self;
  final $Res Function(_DutyEvent) _then;

/// Create a copy of DutyEvent
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? studentId = null,Object? scheduleId = null,Object? dutyDate = null,Object? status = null,Object? scoreEarned = freezed,Object? notes = freezed,Object? assignedAt = freezed,}) {
  return _then(_DutyEvent(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,studentId: null == studentId ? _self.studentId : studentId // ignore: cast_nullable_to_non_nullable
as int,scheduleId: null == scheduleId ? _self.scheduleId : scheduleId // ignore: cast_nullable_to_non_nullable
as int,dutyDate: null == dutyDate ? _self.dutyDate : dutyDate // ignore: cast_nullable_to_non_nullable
as DateTime,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as DutyEventStatus,scoreEarned: freezed == scoreEarned ? _self.scoreEarned : scoreEarned // ignore: cast_nullable_to_non_nullable
as int?,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,assignedAt: freezed == assignedAt ? _self.assignedAt : assignedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
