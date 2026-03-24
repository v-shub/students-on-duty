// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_absence_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_UpdateAbsenceDto _$UpdateAbsenceDtoFromJson(Map<String, dynamic> json) =>
    _UpdateAbsenceDto(
      studentId: (json['student_id'] as num?)?.toInt(),
      dateFrom: json['date_from'] as String?,
      dateTo: json['date_to'] as String?,
      reason: json['reason'] as String?,
      isApproved: json['is_approved'] as bool?,
    );

Map<String, dynamic> _$UpdateAbsenceDtoToJson(_UpdateAbsenceDto instance) =>
    <String, dynamic>{
      'student_id': instance.studentId,
      'date_from': instance.dateFrom,
      'date_to': instance.dateTo,
      'reason': instance.reason,
      'is_approved': instance.isApproved,
    };
