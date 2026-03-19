// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_duty_schedule_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CreateDutyScheduleDtoImpl _$$CreateDutyScheduleDtoImplFromJson(
  Map<String, dynamic> json,
) => _$CreateDutyScheduleDtoImpl(
  groupId: (json['groupId'] as num).toInt(),
  dutyTypeId: (json['dutyTypeId'] as num).toInt(),
  studentsPerDay: (json['studentsPerDay'] as num).toInt(),
  startDate: json['startDate'] as String,
  endDate: json['endDate'] as String?,
  dutyDays: (json['dutyDays'] as Map<String, dynamic>?)?.map(
    (k, e) => MapEntry(k, e as bool),
  ),
);

Map<String, dynamic> _$$CreateDutyScheduleDtoImplToJson(
  _$CreateDutyScheduleDtoImpl instance,
) => <String, dynamic>{
  'groupId': instance.groupId,
  'dutyTypeId': instance.dutyTypeId,
  'studentsPerDay': instance.studentsPerDay,
  'startDate': instance.startDate,
  'endDate': instance.endDate,
  'dutyDays': instance.dutyDays,
};
