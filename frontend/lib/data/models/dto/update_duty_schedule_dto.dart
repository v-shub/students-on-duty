import 'package:freezed_annotation/freezed_annotation.dart';

part 'update_duty_schedule_dto.freezed.dart';
part 'update_duty_schedule_dto.g.dart';

@freezed
abstract class UpdateDutyScheduleDto with _$UpdateDutyScheduleDto {
    const factory UpdateDutyScheduleDto({
    @JsonKey(name: 'duty_type_id') int? dutyTypeId,
    @JsonKey(name: 'students_per_day') int? studentsPerDay,
    @JsonKey(name: 'start_date') String? startDate,
    @JsonKey(name: 'end_date') String? endDate,
    @JsonKey(name: 'is_active') bool? isActive,
    @JsonKey(name: 'duty_days') Map<String, bool>? dutyDays,
  }) = _UpdateDutyScheduleDto;

  factory UpdateDutyScheduleDto.fromJson(Map<String, dynamic> json) =>
      _$UpdateDutyScheduleDtoFromJson(json);
}
