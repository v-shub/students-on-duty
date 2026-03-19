// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_duty_schedule_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UpdateDutyScheduleDtoImpl _$$UpdateDutyScheduleDtoImplFromJson(
  Map<String, dynamic> json,
) => _$UpdateDutyScheduleDtoImpl(
  dutyTypeId: (json['dutyTypeId'] as num?)?.toInt(),
  studentsPerDay: (json['studentsPerDay'] as num?)?.toInt(),
  startDate: json['startDate'] as String?,
  endDate: json['endDate'] as String?,
  isActive: json['isActive'] as bool?,
  dutyDays: (json['dutyDays'] as Map<String, dynamic>?)?.map(
    (k, e) => MapEntry(k, e as bool),
  ),
);

Map<String, dynamic> _$$UpdateDutyScheduleDtoImplToJson(
  _$UpdateDutyScheduleDtoImpl instance,
) => <String, dynamic>{
  'dutyTypeId': instance.dutyTypeId,
  'studentsPerDay': instance.studentsPerDay,
  'startDate': instance.startDate,
  'endDate': instance.endDate,
  'isActive': instance.isActive,
  'dutyDays': instance.dutyDays,
};
