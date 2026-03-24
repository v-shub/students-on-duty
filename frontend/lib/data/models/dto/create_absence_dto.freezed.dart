// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'create_absence_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CreateAbsenceDto {

 int get studentId; String get dateFrom; String get dateTo; String? get reason; bool? get isApproved;
/// Create a copy of CreateAbsenceDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CreateAbsenceDtoCopyWith<CreateAbsenceDto> get copyWith => _$CreateAbsenceDtoCopyWithImpl<CreateAbsenceDto>(this as CreateAbsenceDto, _$identity);

  /// Serializes this CreateAbsenceDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CreateAbsenceDto&&(identical(other.studentId, studentId) || other.studentId == studentId)&&(identical(other.dateFrom, dateFrom) || other.dateFrom == dateFrom)&&(identical(other.dateTo, dateTo) || other.dateTo == dateTo)&&(identical(other.reason, reason) || other.reason == reason)&&(identical(other.isApproved, isApproved) || other.isApproved == isApproved));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,studentId,dateFrom,dateTo,reason,isApproved);

@override
String toString() {
  return 'CreateAbsenceDto(studentId: $studentId, dateFrom: $dateFrom, dateTo: $dateTo, reason: $reason, isApproved: $isApproved)';
}


}

/// @nodoc
abstract mixin class $CreateAbsenceDtoCopyWith<$Res>  {
  factory $CreateAbsenceDtoCopyWith(CreateAbsenceDto value, $Res Function(CreateAbsenceDto) _then) = _$CreateAbsenceDtoCopyWithImpl;
@useResult
$Res call({
 int studentId, String dateFrom, String dateTo, String? reason, bool? isApproved
});




}
/// @nodoc
class _$CreateAbsenceDtoCopyWithImpl<$Res>
    implements $CreateAbsenceDtoCopyWith<$Res> {
  _$CreateAbsenceDtoCopyWithImpl(this._self, this._then);

  final CreateAbsenceDto _self;
  final $Res Function(CreateAbsenceDto) _then;

/// Create a copy of CreateAbsenceDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? studentId = null,Object? dateFrom = null,Object? dateTo = null,Object? reason = freezed,Object? isApproved = freezed,}) {
  return _then(_self.copyWith(
studentId: null == studentId ? _self.studentId : studentId // ignore: cast_nullable_to_non_nullable
as int,dateFrom: null == dateFrom ? _self.dateFrom : dateFrom // ignore: cast_nullable_to_non_nullable
as String,dateTo: null == dateTo ? _self.dateTo : dateTo // ignore: cast_nullable_to_non_nullable
as String,reason: freezed == reason ? _self.reason : reason // ignore: cast_nullable_to_non_nullable
as String?,isApproved: freezed == isApproved ? _self.isApproved : isApproved // ignore: cast_nullable_to_non_nullable
as bool?,
  ));
}

}


/// Adds pattern-matching-related methods to [CreateAbsenceDto].
extension CreateAbsenceDtoPatterns on CreateAbsenceDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CreateAbsenceDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CreateAbsenceDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CreateAbsenceDto value)  $default,){
final _that = this;
switch (_that) {
case _CreateAbsenceDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CreateAbsenceDto value)?  $default,){
final _that = this;
switch (_that) {
case _CreateAbsenceDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int studentId,  String dateFrom,  String dateTo,  String? reason,  bool? isApproved)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CreateAbsenceDto() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int studentId,  String dateFrom,  String dateTo,  String? reason,  bool? isApproved)  $default,) {final _that = this;
switch (_that) {
case _CreateAbsenceDto():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int studentId,  String dateFrom,  String dateTo,  String? reason,  bool? isApproved)?  $default,) {final _that = this;
switch (_that) {
case _CreateAbsenceDto() when $default != null:
return $default(_that.studentId,_that.dateFrom,_that.dateTo,_that.reason,_that.isApproved);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CreateAbsenceDto implements CreateAbsenceDto {
  const _CreateAbsenceDto({required this.studentId, required this.dateFrom, required this.dateTo, this.reason, this.isApproved});
  factory _CreateAbsenceDto.fromJson(Map<String, dynamic> json) => _$CreateAbsenceDtoFromJson(json);

@override final  int studentId;
@override final  String dateFrom;
@override final  String dateTo;
@override final  String? reason;
@override final  bool? isApproved;

/// Create a copy of CreateAbsenceDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CreateAbsenceDtoCopyWith<_CreateAbsenceDto> get copyWith => __$CreateAbsenceDtoCopyWithImpl<_CreateAbsenceDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CreateAbsenceDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CreateAbsenceDto&&(identical(other.studentId, studentId) || other.studentId == studentId)&&(identical(other.dateFrom, dateFrom) || other.dateFrom == dateFrom)&&(identical(other.dateTo, dateTo) || other.dateTo == dateTo)&&(identical(other.reason, reason) || other.reason == reason)&&(identical(other.isApproved, isApproved) || other.isApproved == isApproved));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,studentId,dateFrom,dateTo,reason,isApproved);

@override
String toString() {
  return 'CreateAbsenceDto(studentId: $studentId, dateFrom: $dateFrom, dateTo: $dateTo, reason: $reason, isApproved: $isApproved)';
}


}

/// @nodoc
abstract mixin class _$CreateAbsenceDtoCopyWith<$Res> implements $CreateAbsenceDtoCopyWith<$Res> {
  factory _$CreateAbsenceDtoCopyWith(_CreateAbsenceDto value, $Res Function(_CreateAbsenceDto) _then) = __$CreateAbsenceDtoCopyWithImpl;
@override @useResult
$Res call({
 int studentId, String dateFrom, String dateTo, String? reason, bool? isApproved
});




}
/// @nodoc
class __$CreateAbsenceDtoCopyWithImpl<$Res>
    implements _$CreateAbsenceDtoCopyWith<$Res> {
  __$CreateAbsenceDtoCopyWithImpl(this._self, this._then);

  final _CreateAbsenceDto _self;
  final $Res Function(_CreateAbsenceDto) _then;

/// Create a copy of CreateAbsenceDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? studentId = null,Object? dateFrom = null,Object? dateTo = null,Object? reason = freezed,Object? isApproved = freezed,}) {
  return _then(_CreateAbsenceDto(
studentId: null == studentId ? _self.studentId : studentId // ignore: cast_nullable_to_non_nullable
as int,dateFrom: null == dateFrom ? _self.dateFrom : dateFrom // ignore: cast_nullable_to_non_nullable
as String,dateTo: null == dateTo ? _self.dateTo : dateTo // ignore: cast_nullable_to_non_nullable
as String,reason: freezed == reason ? _self.reason : reason // ignore: cast_nullable_to_non_nullable
as String?,isApproved: freezed == isApproved ? _self.isApproved : isApproved // ignore: cast_nullable_to_non_nullable
as bool?,
  ));
}


}

// dart format on
