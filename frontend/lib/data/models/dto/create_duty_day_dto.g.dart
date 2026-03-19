// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_duty_day_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CreateDutyDayDtoImpl _$$CreateDutyDayDtoImplFromJson(
  Map<String, dynamic> json,
) => _$CreateDutyDayDtoImpl(
  scheduleId: (json['scheduleId'] as num).toInt(),
  isMonday: json['isMonday'] as bool?,
  isTuesday: json['isTuesday'] as bool?,
  isWednesday: json['isWednesday'] as bool?,
  isThursday: json['isThursday'] as bool?,
  isFriday: json['isFriday'] as bool?,
  isSaturday: json['isSaturday'] as bool?,
  isSunday: json['isSunday'] as bool?,
);

Map<String, dynamic> _$$CreateDutyDayDtoImplToJson(
  _$CreateDutyDayDtoImpl instance,
) => <String, dynamic>{
  'scheduleId': instance.scheduleId,
  'isMonday': instance.isMonday,
  'isTuesday': instance.isTuesday,
  'isWednesday': instance.isWednesday,
  'isThursday': instance.isThursday,
  'isFriday': instance.isFriday,
  'isSaturday': instance.isSaturday,
  'isSunday': instance.isSunday,
};
