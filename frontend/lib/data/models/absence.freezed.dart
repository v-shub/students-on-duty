// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'absence.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

Absence _$AbsenceFromJson(Map<String, dynamic> json) {
  return _Absence.fromJson(json);
}

/// @nodoc
mixin _$Absence {
  int get id => throw _privateConstructorUsedError;
  int get studentId => throw _privateConstructorUsedError;
  DateTime get dateFrom => throw _privateConstructorUsedError;
  DateTime get dateTo => throw _privateConstructorUsedError;
  String? get reason => throw _privateConstructorUsedError;
  bool get isApproved => throw _privateConstructorUsedError;

  /// Serializes this Absence to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Absence
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AbsenceCopyWith<Absence> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AbsenceCopyWith<$Res> {
  factory $AbsenceCopyWith(Absence value, $Res Function(Absence) then) =
      _$AbsenceCopyWithImpl<$Res, Absence>;
  @useResult
  $Res call({
    int id,
    int studentId,
    DateTime dateFrom,
    DateTime dateTo,
    String? reason,
    bool isApproved,
  });
}

/// @nodoc
class _$AbsenceCopyWithImpl<$Res, $Val extends Absence>
    implements $AbsenceCopyWith<$Res> {
  _$AbsenceCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Absence
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? studentId = null,
    Object? dateFrom = null,
    Object? dateTo = null,
    Object? reason = freezed,
    Object? isApproved = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as int,
            studentId: null == studentId
                ? _value.studentId
                : studentId // ignore: cast_nullable_to_non_nullable
                      as int,
            dateFrom: null == dateFrom
                ? _value.dateFrom
                : dateFrom // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            dateTo: null == dateTo
                ? _value.dateTo
                : dateTo // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            reason: freezed == reason
                ? _value.reason
                : reason // ignore: cast_nullable_to_non_nullable
                      as String?,
            isApproved: null == isApproved
                ? _value.isApproved
                : isApproved // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$AbsenceImplCopyWith<$Res> implements $AbsenceCopyWith<$Res> {
  factory _$$AbsenceImplCopyWith(
    _$AbsenceImpl value,
    $Res Function(_$AbsenceImpl) then,
  ) = __$$AbsenceImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int id,
    int studentId,
    DateTime dateFrom,
    DateTime dateTo,
    String? reason,
    bool isApproved,
  });
}

/// @nodoc
class __$$AbsenceImplCopyWithImpl<$Res>
    extends _$AbsenceCopyWithImpl<$Res, _$AbsenceImpl>
    implements _$$AbsenceImplCopyWith<$Res> {
  __$$AbsenceImplCopyWithImpl(
    _$AbsenceImpl _value,
    $Res Function(_$AbsenceImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Absence
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? studentId = null,
    Object? dateFrom = null,
    Object? dateTo = null,
    Object? reason = freezed,
    Object? isApproved = null,
  }) {
    return _then(
      _$AbsenceImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int,
        studentId: null == studentId
            ? _value.studentId
            : studentId // ignore: cast_nullable_to_non_nullable
                  as int,
        dateFrom: null == dateFrom
            ? _value.dateFrom
            : dateFrom // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        dateTo: null == dateTo
            ? _value.dateTo
            : dateTo // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        reason: freezed == reason
            ? _value.reason
            : reason // ignore: cast_nullable_to_non_nullable
                  as String?,
        isApproved: null == isApproved
            ? _value.isApproved
            : isApproved // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$AbsenceImpl implements _Absence {
  const _$AbsenceImpl({
    required this.id,
    required this.studentId,
    required this.dateFrom,
    required this.dateTo,
    this.reason,
    this.isApproved = false,
  });

  factory _$AbsenceImpl.fromJson(Map<String, dynamic> json) =>
      _$$AbsenceImplFromJson(json);

  @override
  final int id;
  @override
  final int studentId;
  @override
  final DateTime dateFrom;
  @override
  final DateTime dateTo;
  @override
  final String? reason;
  @override
  @JsonKey()
  final bool isApproved;

  @override
  String toString() {
    return 'Absence(id: $id, studentId: $studentId, dateFrom: $dateFrom, dateTo: $dateTo, reason: $reason, isApproved: $isApproved)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AbsenceImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.studentId, studentId) ||
                other.studentId == studentId) &&
            (identical(other.dateFrom, dateFrom) ||
                other.dateFrom == dateFrom) &&
            (identical(other.dateTo, dateTo) || other.dateTo == dateTo) &&
            (identical(other.reason, reason) || other.reason == reason) &&
            (identical(other.isApproved, isApproved) ||
                other.isApproved == isApproved));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    studentId,
    dateFrom,
    dateTo,
    reason,
    isApproved,
  );

  /// Create a copy of Absence
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AbsenceImplCopyWith<_$AbsenceImpl> get copyWith =>
      __$$AbsenceImplCopyWithImpl<_$AbsenceImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AbsenceImplToJson(this);
  }
}

abstract class _Absence implements Absence {
  const factory _Absence({
    required final int id,
    required final int studentId,
    required final DateTime dateFrom,
    required final DateTime dateTo,
    final String? reason,
    final bool isApproved,
  }) = _$AbsenceImpl;

  factory _Absence.fromJson(Map<String, dynamic> json) = _$AbsenceImpl.fromJson;

  @override
  int get id;
  @override
  int get studentId;
  @override
  DateTime get dateFrom;
  @override
  DateTime get dateTo;
  @override
  String? get reason;
  @override
  bool get isApproved;

  /// Create a copy of Absence
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AbsenceImplCopyWith<_$AbsenceImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
