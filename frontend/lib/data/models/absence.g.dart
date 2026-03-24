// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'absence.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Absence _$AbsenceFromJson(Map<String, dynamic> json) => _Absence(
  id: (json['id'] as num).toInt(),
  studentId: (json['student_id'] as num).toInt(),
  dateFrom: DateTime.parse(json['date_from'] as String),
  dateTo: DateTime.parse(json['date_to'] as String),
  reason: json['reason'] as String?,
  isApproved: json['is_approved'] as bool? ?? false,
);

Map<String, dynamic> _$AbsenceToJson(_Absence instance) => <String, dynamic>{
  'id': instance.id,
  'student_id': instance.studentId,
  'date_from': instance.dateFrom.toIso8601String(),
  'date_to': instance.dateTo.toIso8601String(),
  'reason': instance.reason,
  'is_approved': instance.isApproved,
};
