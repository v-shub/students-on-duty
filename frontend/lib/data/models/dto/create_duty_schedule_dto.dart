import 'package:freezed_annotation/freezed_annotation.dart';

part 'create_duty_schedule_dto.freezed.dart';
part 'create_duty_schedule_dto.g.dart';

@freezed
class CreateDutyScheduleDto with _$CreateDutyScheduleDto {
  const factory CreateDutyScheduleDto({
    required int groupId,
    required int dutyTypeId,
    required int studentsPerDay,
    required String startDate,
    String? endDate,
    Map<String, bool>? dutyDays,
  }) = _CreateDutyScheduleDto;

  factory CreateDutyScheduleDto.fromJson(Map<String, dynamic> json) =>
      _$CreateDutyScheduleDtoFromJson(json);
}
