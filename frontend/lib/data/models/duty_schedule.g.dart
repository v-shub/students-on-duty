// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'duty_schedule.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_DutySchedule _$DutyScheduleFromJson(Map<String, dynamic> json) =>
    _DutySchedule(
      id: (json['id'] as num).toInt(),
      groupId: (json['group_id'] as num).toInt(),
      dutyTypeId: (json['duty_type_id'] as num).toInt(),
      studentsPerDay: (json['students_per_day'] as num).toInt(),
      startDate: DateTime.parse(json['start_date'] as String),
      endDate: json['end_date'] == null
          ? null
          : DateTime.parse(json['end_date'] as String),
      isActive: json['is_active'] as bool? ?? true,
    );

Map<String, dynamic> _$DutyScheduleToJson(_DutySchedule instance) =>
    <String, dynamic>{
      'id': instance.id,
      'group_id': instance.groupId,
      'duty_type_id': instance.dutyTypeId,
      'students_per_day': instance.studentsPerDay,
      'start_date': instance.startDate.toIso8601String(),
      'end_date': instance.endDate?.toIso8601String(),
      'is_active': instance.isActive,
    };
