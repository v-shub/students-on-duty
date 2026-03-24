// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'update_absence_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$UpdateAbsenceDto {

@JsonKey(name: 'student_id') int? get studentId;@JsonKey(name: 'date_from') String? get dateFrom;@JsonKey(name: 'date_to') String? get dateTo; String? get reason;@JsonKey(name: 'is_approved') bool? get isApproved;
/// Create a copy of UpdateAbsenceDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UpdateAbsenceDtoCopyWith<UpdateAbsenceDto> get copyWith => _$UpdateAbsenceDtoCopyWithImpl<UpdateAbsenceDto>(this as UpdateAbsenceDto, _$identity);

  /// Serializes this UpdateAbsenceDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UpdateAbsenceDto&&(identical(other.studentId, studentId) || other.studentId == studentId)&&(identical(other.dateFrom, dateFrom) || other.dateFrom == dateFrom)&&(identical(other.dateTo, dateTo) || other.dateTo == dateTo)&&(identical(other.reason, reason) || other.reason == reason)&&(identical(other.isApproved, isApproved) || other.isApproved == isApproved));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,studentId,dateFrom,dateTo,reason,isApproved);

@override
String toString() {
  return 'UpdateAbsenceDto(studentId: $studentId, dateFrom: $dateFrom, dateTo: $dateTo, reason: $reason, isApproved: $isApproved)';
}


}

/// @nodoc
abstract mixin class $UpdateAbsenceDtoCopyWith<$Res>  {
  factory $UpdateAbsenceDtoCopyWith(UpdateAbsenceDto value, $Res Function(UpdateAbsenceDto) _then) = _$UpdateAbsenceDtoCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'student_id') int? studentId,@JsonKey(name: 'date_from') String? dateFrom,@JsonKey(name: 'date_to') String? dateTo, String? reason,@JsonKey(name: 'is_approved') bool? isApproved
});




}
/// @nodoc
class _$UpdateAbsenceDtoCopyWithImpl<$Res>
    implements $UpdateAbsenceDtoCopyWith<$Res> {
  _$UpdateAbsenceDtoCopyWithImpl(this._self, this._then);

  final UpdateAbsenceDto _self;
  final $Res Function(UpdateAbsenceDto) _then;

/// Create a copy of UpdateAbsenceDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? studentId = freezed,Object? dateFrom = freezed,Object? dateTo = freezed,Object? reason = freezed,Object? isApproved = freezed,}) {
  return _then(_self.copyWith(
studentId: freezed == studentId ? _self.studentId : studentId // ignore: cast_nullable_to_non_nullable
as int?,dateFrom: freezed == dateFrom ? _self.dateFrom : dateFrom // ignore: cast_nullable_to_non_nullable
as String?,dateTo: freezed == dateTo ? _self.dateTo : dateTo // ignore: cast_nullable_to_non_nullable
as String?,reason: freezed == reason ? _self.reason : reason // ignore: cast_nullable_to_non_nullable
as String?,isApproved: freezed == isApproved ? _self.isApproved : isApproved // ignore: cast_nullable_to_non_nullable
as bool?,
  ));
}

}


/// Adds pattern-matching-related methods to [UpdateAbsenceDto].
extension UpdateAbsenceDtoPatterns on UpdateAbsenceDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UpdateAbsenceDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UpdateAbsenceDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UpdateAbsenceDto value)  $default,){
final _that = this;
switch (_that) {
case _UpdateAbsenceDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UpdateAbsenceDto value)?  $default,){
final _that = this;
switch (_that) {
case _UpdateAbsenceDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'student_id')  int? studentId, @JsonKey(name: 'date_from')  String? dateFrom, @JsonKey(name: 'date_to')  String? dateTo,  String? reason, @JsonKey(name: 'is_approved')  bool? isApproved)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UpdateAbsenceDto() when $default != null:
return $default(_that.studentId,_that.dateFrom,_that.dateTo,_that.reason,_that.isApproved);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'student_id')  int? studentId, @JsonKey(name: 'date_from')  String? dateFrom, @JsonKey(name: 'date_to')  String? dateTo,  String? reason, @JsonKey(name: 'is_approved')  bool? isApproved)  $default,) {final _that = this;
switch (_that) {
case _UpdateAbsenceDto():
return $default(_that.studentId,_that.dateFrom,_that.dateTo,_that.reason,_that.isApproved);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'student_id')  int? studentId, @JsonKey(name: 'date_from')  String? dateFrom, @JsonKey(name: 'date_to')  String? dateTo,  String? reason, @JsonKey(name: 'is_approved')  bool? isApproved)?  $default,) {final _that = this;
switch (_that) {
case _UpdateAbsenceDto() when $default != null:
return $default(_that.studentId,_that.dateFrom,_that.dateTo,_that.reason,_that.isApproved);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _UpdateAbsenceDto implements UpdateAbsenceDto {
  const _UpdateAbsenceDto({@JsonKey(name: 'student_id') this.studentId, @JsonKey(name: 'date_from') this.dateFrom, @JsonKey(name: 'date_to') this.dateTo, this.reason, @JsonKey(name: 'is_approved') this.isApproved});
  factory _UpdateAbsenceDto.fromJson(Map<String, dynamic> json) => _$UpdateAbsenceDtoFromJson(json);

@override@JsonKey(name: 'student_id') final  int? studentId;
@override@JsonKey(name: 'date_from') final  String? dateFrom;
@override@JsonKey(name: 'date_to') final  String? dateTo;
@override final  String? reason;
@override@JsonKey(name: 'is_approved') final  bool? isApproved;

/// Create a copy of UpdateAbsenceDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UpdateAbsenceDtoCopyWith<_UpdateAbsenceDto> get copyWith => __$UpdateAbsenceDtoCopyWithImpl<_UpdateAbsenceDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UpdateAbsenceDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UpdateAbsenceDto&&(identical(other.studentId, studentId) || other.studentId == studentId)&&(identical(other.dateFrom, dateFrom) || other.dateFrom == dateFrom)&&(identical(other.dateTo, dateTo) || other.dateTo == dateTo)&&(identical(other.reason, reason) || other.reason == reason)&&(identical(other.isApproved, isApproved) || other.isApproved == isApproved));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,studentId,dateFrom,dateTo,reason,isApproved);

@override
String toString() {
  return 'UpdateAbsenceDto(studentId: $studentId, dateFrom: $dateFrom, dateTo: $dateTo, reason: $reason, isApproved: $isApproved)';
}


}

/// @nodoc
abstract mixin class _$UpdateAbsenceDtoCopyWith<$Res> implements $UpdateAbsenceDtoCopyWith<$Res> {
  factory _$UpdateAbsenceDtoCopyWith(_UpdateAbsenceDto value, $Res Function(_UpdateAbsenceDto) _then) = __$UpdateAbsenceDtoCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'student_id') int? studentId,@JsonKey(name: 'date_from') String? dateFrom,@JsonKey(name: 'date_to') String? dateTo, String? reason,@JsonKey(name: 'is_approved') bool? isApproved
});




}
/// @nodoc
class __$UpdateAbsenceDtoCopyWithImpl<$Res>
    implements _$UpdateAbsenceDtoCopyWith<$Res> {
  __$UpdateAbsenceDtoCopyWithImpl(this._self, this._then);

  final _UpdateAbsenceDto _self;
  final $Res Function(_UpdateAbsenceDto) _then;

/// Create a copy of UpdateAbsenceDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? studentId = freezed,Object? dateFrom = freezed,Object? dateTo = freezed,Object? reason = freezed,Object? isApproved = freezed,}) {
  return _then(_UpdateAbsenceDto(
studentId: freezed == studentId ? _self.studentId : studentId // ignore: cast_nullable_to_non_nullable
as int?,dateFrom: freezed == dateFrom ? _self.dateFrom : dateFrom // ignore: cast_nullable_to_non_nullable
as String?,dateTo: freezed == dateTo ? _self.dateTo : dateTo // ignore: cast_nullable_to_non_nullable
as String?,reason: freezed == reason ? _self.reason : reason // ignore: cast_nullable_to_non_nullable
as String?,isApproved: freezed == isApproved ? _self.isApproved : isApproved // ignore: cast_nullable_to_non_nullable
as bool?,
  ));
}


}

// dart format on
