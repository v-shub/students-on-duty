// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_duty_schedule_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_UpdateDutyScheduleDto _$UpdateDutyScheduleDtoFromJson(
  Map<String, dynamic> json,
) => _UpdateDutyScheduleDto(
  dutyTypeId: (json['duty_type_id'] as num?)?.toInt(),
  studentsPerDay: (json['students_per_day'] as num?)?.toInt(),
  startDate: json['start_date'] as String?,
  endDate: json['end_date'] as String?,
  isActive: json['is_active'] as bool?,
  dutyDays: (json['duty_days'] as Map<String, dynamic>?)?.map(
    (k, e) => MapEntry(k, e as bool),
  ),
);

Map<String, dynamic> _$UpdateDutyScheduleDtoToJson(
  _UpdateDutyScheduleDto instance,
) => <String, dynamic>{
  'duty_type_id': instance.dutyTypeId,
  'students_per_day': instance.studentsPerDay,
  'start_date': instance.startDate,
  'end_date': instance.endDate,
  'is_active': instance.isActive,
  'duty_days': instance.dutyDays,
};
