// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'absence.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AbsenceImpl _$$AbsenceImplFromJson(Map<String, dynamic> json) =>
    _$AbsenceImpl(
      id: (json['id'] as num).toInt(),
      studentId: (json['studentId'] as num).toInt(),
      dateFrom: DateTime.parse(json['dateFrom'] as String),
      dateTo: DateTime.parse(json['dateTo'] as String),
      reason: json['reason'] as String?,
      isApproved: json['isApproved'] as bool? ?? false,
    );

Map<String, dynamic> _$$AbsenceImplToJson(_$AbsenceImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'studentId': instance.studentId,
      'dateFrom': instance.dateFrom.toIso8601String(),
      'dateTo': instance.dateTo.toIso8601String(),
      'reason': instance.reason,
      'isApproved': instance.isApproved,
    };
