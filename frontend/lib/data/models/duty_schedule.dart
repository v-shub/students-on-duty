import 'package:freezed_annotation/freezed_annotation.dart';

part 'duty_schedule.freezed.dart';
part 'duty_schedule.g.dart';

@freezed
abstract class DutySchedule with _$DutySchedule {
  const factory DutySchedule({
    required int id,
    @JsonKey(name: 'group_id') required int groupId,
    @JsonKey(name: 'duty_type_id') required int dutyTypeId,
    @JsonKey(name: 'students_per_day') required int studentsPerDay,
    @JsonKey(name: 'start_date') required DateTime startDate,
    @JsonKey(name: 'end_date') DateTime? endDate,
    @JsonKey(name: 'is_active') @Default(true) bool isActive,
  }) = _DutySchedule;

  factory DutySchedule.fromJson(Map<String, dynamic> json) =>
      _$DutyScheduleFromJson(json);
}
