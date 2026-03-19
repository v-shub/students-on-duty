import 'package:freezed_annotation/freezed_annotation.dart';

part 'duty_event.freezed.dart';
part 'duty_event.g.dart';

enum DutyEventStatus { pending, completed, cancelled, reassigned }

@freezed
class DutyEvent with _$DutyEvent {
  const factory DutyEvent({
    required int id,
    required int studentId,
    required int scheduleId,
    required DateTime dutyDate,
    required DutyEventStatus status,
    int? scoreEarned,
    String? notes,
    DateTime? assignedAt,
  }) = _DutyEvent;

  factory DutyEvent.fromJson(Map<String, dynamic> json) =>
      _$DutyEventFromJson(json);
}
