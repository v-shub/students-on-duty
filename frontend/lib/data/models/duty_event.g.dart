// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'duty_event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_DutyEvent _$DutyEventFromJson(Map<String, dynamic> json) => _DutyEvent(
  id: (json['id'] as num).toInt(),
  studentId: (json['student_id'] as num).toInt(),
  scheduleId: (json['schedule_id'] as num).toInt(),
  dutyDate: DateTime.parse(json['duty_date'] as String),
  status: $enumDecode(_$DutyEventStatusEnumMap, json['status']),
  scoreEarned: (json['score_earned'] as num?)?.toInt(),
  notes: json['notes'] as String?,
  assignedAt: json['assigned_at'] == null
      ? null
      : DateTime.parse(json['assigned_at'] as String),
);

Map<String, dynamic> _$DutyEventToJson(_DutyEvent instance) =>
    <String, dynamic>{
      'id': instance.id,
      'student_id': instance.studentId,
      'schedule_id': instance.scheduleId,
      'duty_date': instance.dutyDate.toIso8601String(),
      'status': _$DutyEventStatusEnumMap[instance.status]!,
      'score_earned': instance.scoreEarned,
      'notes': instance.notes,
      'assigned_at': instance.assignedAt?.toIso8601String(),
    };

const _$DutyEventStatusEnumMap = {
  DutyEventStatus.pending: 'pending',
  DutyEventStatus.completed: 'completed',
  DutyEventStatus.cancelled: 'cancelled',
  DutyEventStatus.reassigned: 'reassigned',
};
