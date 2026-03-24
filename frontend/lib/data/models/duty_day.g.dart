// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'duty_day.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_DutyDay _$DutyDayFromJson(Map<String, dynamic> json) => _DutyDay(
  scheduleId: (json['schedule_id'] as num).toInt(),
  isMonday: json['is_monday'] as bool? ?? false,
  isTuesday: json['is_tuesday'] as bool? ?? false,
  isWednesday: json['is_wednesday'] as bool? ?? false,
  isThursday: json['is_thursday'] as bool? ?? false,
  isFriday: json['is_friday'] as bool? ?? false,
  isSaturday: json['is_saturday'] as bool? ?? false,
  isSunday: json['is_sunday'] as bool? ?? false,
);

Map<String, dynamic> _$DutyDayToJson(_DutyDay instance) => <String, dynamic>{
  'schedule_id': instance.scheduleId,
  'is_monday': instance.isMonday,
  'is_tuesday': instance.isTuesday,
  'is_wednesday': instance.isWednesday,
  'is_thursday': instance.isThursday,
  'is_friday': instance.isFriday,
  'is_saturday': instance.isSaturday,
  'is_sunday': instance.isSunday,
};
