// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_duty_day_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CreateDutyDayDto _$CreateDutyDayDtoFromJson(Map<String, dynamic> json) =>
    _CreateDutyDayDto(
      scheduleId: (json['schedule_id'] as num).toInt(),
      isMonday: json['is_monday'] as bool?,
      isTuesday: json['is_tuesday'] as bool?,
      isWednesday: json['is_wednesday'] as bool?,
      isThursday: json['is_thursday'] as bool?,
      isFriday: json['is_friday'] as bool?,
      isSaturday: json['is_saturday'] as bool?,
      isSunday: json['is_sunday'] as bool?,
    );

Map<String, dynamic> _$CreateDutyDayDtoToJson(_CreateDutyDayDto instance) =>
    <String, dynamic>{
      'schedule_id': instance.scheduleId,
      'is_monday': instance.isMonday,
      'is_tuesday': instance.isTuesday,
      'is_wednesday': instance.isWednesday,
      'is_thursday': instance.isThursday,
      'is_friday': instance.isFriday,
      'is_saturday': instance.isSaturday,
      'is_sunday': instance.isSunday,
    };
