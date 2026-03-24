import 'package:freezed_annotation/freezed_annotation.dart';

part 'create_duty_schedule_dto.freezed.dart';
part 'create_duty_schedule_dto.g.dart';

@freezed
abstract class CreateDutyScheduleDto with _$CreateDutyScheduleDto {
    const factory CreateDutyScheduleDto({
    @JsonKey(name: 'group_id') required int groupId,
    @JsonKey(name: 'duty_type_id') required int dutyTypeId,
    @JsonKey(name: 'students_per_day') required int studentsPerDay,
    @JsonKey(name: 'start_date') required String startDate,
    @JsonKey(name: 'end_date') String? endDate,
    @JsonKey(name: 'duty_days') Map<String, bool>? dutyDays,
  }) = _CreateDutyScheduleDto;

  factory CreateDutyScheduleDto.fromJson(Map<String, dynamic> json) =>
      _$CreateDutyScheduleDtoFromJson(json);
}
