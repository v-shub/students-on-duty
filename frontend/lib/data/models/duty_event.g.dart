// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'duty_event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DutyEventImpl _$$DutyEventImplFromJson(Map<String, dynamic> json) =>
    _$DutyEventImpl(
      id: (json['id'] as num).toInt(),
      studentId: (json['studentId'] as num).toInt(),
      scheduleId: (json['scheduleId'] as num).toInt(),
      dutyDate: DateTime.parse(json['dutyDate'] as String),
      status: $enumDecode(_$DutyEventStatusEnumMap, json['status']),
      scoreEarned: (json['scoreEarned'] as num?)?.toInt(),
      notes: json['notes'] as String?,
      assignedAt: json['assignedAt'] == null
          ? null
          : DateTime.parse(json['assignedAt'] as String),
    );

Map<String, dynamic> _$$DutyEventImplToJson(_$DutyEventImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'studentId': instance.studentId,
      'scheduleId': instance.scheduleId,
      'dutyDate': instance.dutyDate.toIso8601String(),
      'status': _$DutyEventStatusEnumMap[instance.status]!,
      'scoreEarned': instance.scoreEarned,
      'notes': instance.notes,
      'assignedAt': instance.assignedAt?.toIso8601String(),
    };

const _$DutyEventStatusEnumMap = {
  DutyEventStatus.pending: 'pending',
  DutyEventStatus.completed: 'completed',
  DutyEventStatus.cancelled: 'cancelled',
  DutyEventStatus.reassigned: 'reassigned',
};
