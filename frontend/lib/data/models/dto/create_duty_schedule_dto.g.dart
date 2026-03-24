// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_duty_schedule_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CreateDutyScheduleDto _$CreateDutyScheduleDtoFromJson(
  Map<String, dynamic> json,
) => _CreateDutyScheduleDto(
  groupId: (json['group_id'] as num).toInt(),
  dutyTypeId: (json['duty_type_id'] as num).toInt(),
  studentsPerDay: (json['students_per_day'] as num).toInt(),
  startDate: json['start_date'] as String,
  endDate: json['end_date'] as String?,
  dutyDays: (json['duty_days'] as Map<String, dynamic>?)?.map(
    (k, e) => MapEntry(k, e as bool),
  ),
);

Map<String, dynamic> _$CreateDutyScheduleDtoToJson(
  _CreateDutyScheduleDto instance,
) => <String, dynamic>{
  'group_id': instance.groupId,
  'duty_type_id': instance.dutyTypeId,
  'students_per_day': instance.studentsPerDay,
  'start_date': instance.startDate,
  'end_date': instance.endDate,
  'duty_days': instance.dutyDays,
};
