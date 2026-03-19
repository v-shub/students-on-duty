import 'package:freezed_annotation/freezed_annotation.dart';

part 'update_duty_schedule_dto.freezed.dart';
part 'update_duty_schedule_dto.g.dart';

@freezed
class UpdateDutyScheduleDto with _$UpdateDutyScheduleDto {
  const factory UpdateDutyScheduleDto({
    int? dutyTypeId,
    int? studentsPerDay,
    String? startDate,
    String? endDate,
    bool? isActive,
    Map<String, bool>? dutyDays,
  }) = _UpdateDutyScheduleDto;

  factory UpdateDutyScheduleDto.fromJson(Map<String, dynamic> json) =>
      _$UpdateDutyScheduleDtoFromJson(json);
}
