// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'duty_schedule.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DutyScheduleImpl _$$DutyScheduleImplFromJson(Map<String, dynamic> json) =>
    _$DutyScheduleImpl(
      id: (json['id'] as num).toInt(),
      groupId: (json['groupId'] as num).toInt(),
      dutyTypeId: (json['dutyTypeId'] as num).toInt(),
      studentsPerDay: (json['studentsPerDay'] as num).toInt(),
      startDate: DateTime.parse(json['startDate'] as String),
      endDate: json['endDate'] == null
          ? null
          : DateTime.parse(json['endDate'] as String),
      isActive: json['isActive'] as bool? ?? true,
    );

Map<String, dynamic> _$$DutyScheduleImplToJson(_$DutyScheduleImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'groupId': instance.groupId,
      'dutyTypeId': instance.dutyTypeId,
      'studentsPerDay': instance.studentsPerDay,
      'startDate': instance.startDate.toIso8601String(),
      'endDate': instance.endDate?.toIso8601String(),
      'isActive': instance.isActive,
    };
