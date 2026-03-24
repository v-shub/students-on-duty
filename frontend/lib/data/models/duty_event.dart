import 'package:freezed_annotation/freezed_annotation.dart';

part 'duty_event.freezed.dart';
part 'duty_event.g.dart';

enum DutyEventStatus { pending, completed, cancelled, reassigned }

@freezed
abstract class DutyEvent with _$DutyEvent {
  const factory DutyEvent({
    required int id,
    @JsonKey(name: 'student_id') required int studentId,
    @JsonKey(name: 'schedule_id') required int scheduleId,
    @JsonKey(name: 'duty_date') required DateTime dutyDate,
    required DutyEventStatus status,
    @JsonKey(name: 'score_earned') int? scoreEarned,
    String? notes,
    @JsonKey(name: 'assigned_at') DateTime? assignedAt,
  }) = _DutyEvent;

  factory DutyEvent.fromJson(Map<String, dynamic> json) =>
      _$DutyEventFromJson(json);
}
