import 'package:freezed_annotation/freezed_annotation.dart';

part 'duty_schedule.freezed.dart';
part 'duty_schedule.g.dart';

@freezed
class DutySchedule with _$DutySchedule {
  const factory DutySchedule({
    required int id,
    required int groupId,
    required int dutyTypeId,
    required int studentsPerDay,
    required DateTime startDate,
    DateTime? endDate,
    @Default(true) bool isActive,
  }) = _DutySchedule;

  factory DutySchedule.fromJson(Map<String, dynamic> json) =>
      _$DutyScheduleFromJson(json);
}
