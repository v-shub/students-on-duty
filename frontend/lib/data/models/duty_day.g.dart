// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'duty_day.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DutyDayImpl _$$DutyDayImplFromJson(Map<String, dynamic> json) =>
    _$DutyDayImpl(
      scheduleId: (json['scheduleId'] as num).toInt(),
      isMonday: json['isMonday'] as bool? ?? false,
      isTuesday: json['isTuesday'] as bool? ?? false,
      isWednesday: json['isWednesday'] as bool? ?? false,
      isThursday: json['isThursday'] as bool? ?? false,
      isFriday: json['isFriday'] as bool? ?? false,
      isSaturday: json['isSaturday'] as bool? ?? false,
      isSunday: json['isSunday'] as bool? ?? false,
    );

Map<String, dynamic> _$$DutyDayImplToJson(_$DutyDayImpl instance) =>
    <String, dynamic>{
      'scheduleId': instance.scheduleId,
      'isMonday': instance.isMonday,
      'isTuesday': instance.isTuesday,
      'isWednesday': instance.isWednesday,
      'isThursday': instance.isThursday,
      'isFriday': instance.isFriday,
      'isSaturday': instance.isSaturday,
      'isSunday': instance.isSunday,
    };
