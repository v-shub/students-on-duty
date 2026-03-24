// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'absence.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Absence {

 int get id; int get studentId; DateTime get dateFrom; DateTime get dateTo; String? get reason; bool get isApproved;
/// Create a copy of Absence
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AbsenceCopyWith<Absence> get copyWith => _$AbsenceCopyWithImpl<Absence>(this as Absence, _$identity);

  /// Serializes this Absence to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Absence&&(identical(other.id, id) || other.id == id)&&(identical(other.studentId, studentId) || other.studentId == studentId)&&(identical(other.dateFrom, dateFrom) || other.dateFrom == dateFrom)&&(identical(other.dateTo, dateTo) || other.dateTo == dateTo)&&(identical(other.reason, reason) || other.reason == reason)&&(identical(other.isApproved, isApproved) || other.isApproved == isApproved));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,studentId,dateFrom,dateTo,reason,isApproved);

@override
String toString() {
  return 'Absence(id: $id, studentId: $studentId, dateFrom: $dateFrom, dateTo: $dateTo, reason: $reason, isApproved: $isApproved)';
}


}

/// @nodoc
abstract mixin class $AbsenceCopyWith<$Res>  {
  factory $AbsenceCopyWith(Absence value, $Res Function(Absence) _then) = _$AbsenceCopyWithImpl;
@useResult
$Res call({
 int id, int studentId, DateTime dateFrom, DateTime dateTo, String? reason, bool isApproved
});




}
/// @nodoc
class _$AbsenceCopyWithImpl<$Res>
    implements $AbsenceCopyWith<$Res> {
  _$AbsenceCopyWithImpl(this._self, this._then);

  final Absence _self;
  final $Res Function(Absence) _then;

/// Create a copy of Absence
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? studentId = null,Object? dateFrom = null,Object? dateTo = null,Object? reason = freezed,Object? isApproved = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,studentId: null == studentId ? _self.studentId : studentId // ignore: cast_nullable_to_non_nullable
as int,dateFrom: null == dateFrom ? _self.dateFrom : dateFrom // ignore: cast_nullable_to_non_nullable
as DateTime,dateTo: null == dateTo ? _self.dateTo : dateTo // ignore: cast_nullable_to_non_nullable
as DateTime,reason: freezed == reason ? _self.reason : reason // ignore: cast_nullable_to_non_nullable
as String?,isApproved: null == isApproved ? _self.isApproved : isApproved // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [Absence].
extension AbsencePatterns on Absence {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Absence value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Absence() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Absence value)  $default,){
final _that = this;
switch (_that) {
case _Absence():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Absence value)?  $default,){
final _that = this;
switch (_that) {
case _Absence() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  int studentId,  DateTime dateFrom,  DateTime dateTo,  String? reason,  bool isApproved)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Absence() when $default != null:
return $default(_that.id,_that.studentId,_that.dateFrom,_that.dateTo,_that.reason,_that.isApproved);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  int studentId,  DateTime dateFrom,  DateTime dateTo,  String? reason,  bool isApproved)  $default,) {final _that = this;
switch (_that) {
case _Absence():
return $default(_that.id,_that.studentId,_that.dateFrom,_that.dateTo,_that.reason,_that.isApproved);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  int studentId,  DateTime dateFrom,  DateTime dateTo,  String? reason,  bool isApproved)?  $default,) {final _that = this;
switch (_that) {
case _Absence() when $default != null:
return $default(_that.id,_that.studentId,_that.dateFrom,_that.dateTo,_that.reason,_that.isApproved);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Absence implements Absence {
  const _Absence({required this.id, required this.studentId, required this.dateFrom, required this.dateTo, this.reason, this.isApproved = false});
  factory _Absence.fromJson(Map<String, dynamic> json) => _$AbsenceFromJson(json);

@override final  int id;
@override final  int studentId;
@override final  DateTime dateFrom;
@override final  DateTime dateTo;
@override final  String? reason;
@override@JsonKey() final  bool isApproved;

/// Create a copy of Absence
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AbsenceCopyWith<_Absence> get copyWith => __$AbsenceCopyWithImpl<_Absence>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AbsenceToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Absence&&(identical(other.id, id) || other.id == id)&&(identical(other.studentId, studentId) || other.studentId == studentId)&&(identical(other.dateFrom, dateFrom) || other.dateFrom == dateFrom)&&(identical(other.dateTo, dateTo) || other.dateTo == dateTo)&&(identical(other.reason, reason) || other.reason == reason)&&(identical(other.isApproved, isApproved) || other.isApproved == isApproved));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,studentId,dateFrom,dateTo,reason,isApproved);

@override
String toString() {
  return 'Absence(id: $id, studentId: $studentId, dateFrom: $dateFrom, dateTo: $dateTo, reason: $reason, isApproved: $isApproved)';
}


}

/// @nodoc
abstract mixin class _$AbsenceCopyWith<$Res> implements $AbsenceCopyWith<$Res> {
  factory _$AbsenceCopyWith(_Absence value, $Res Function(_Absence) _then) = __$AbsenceCopyWithImpl;
@override @useResult
$Res call({
 int id, int studentId, DateTime dateFrom, DateTime dateTo, String? reason, bool isApproved
});




}
/// @nodoc
class __$AbsenceCopyWithImpl<$Res>
    implements _$AbsenceCopyWith<$Res> {
  __$AbsenceCopyWithImpl(this._self, this._then);

  final _Absence _self;
  final $Res Function(_Absence) _then;

/// Create a copy of Absence
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? studentId = null,Object? dateFrom = null,Object? dateTo = null,Object? reason = freezed,Object? isApproved = null,}) {
  return _then(_Absence(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,studentId: null == studentId ? _self.studentId : studentId // ignore: cast_nullable_to_non_nullable
as int,dateFrom: null == dateFrom ? _self.dateFrom : dateFrom // ignore: cast_nullable_to_non_nullable
as DateTime,dateTo: null == dateTo ? _self.dateTo : dateTo // ignore: cast_nullable_to_non_nullable
as DateTime,reason: freezed == reason ? _self.reason : reason // ignore: cast_nullable_to_non_nullable
as String?,isApproved: null == isApproved ? _self.isApproved : isApproved // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
