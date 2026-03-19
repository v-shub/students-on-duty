import 'package:freezed_annotation/freezed_annotation.dart';

part 'create_duty_day_dto.freezed.dart';
part 'create_duty_day_dto.g.dart';

@freezed
class CreateDutyDayDto with _$CreateDutyDayDto {
  const factory CreateDutyDayDto({
    required int scheduleId,
    bool? isMonday,
    bool? isTuesday,
    bool? isWednesday,
    bool? isThursday,
    bool? isFriday,
    bool? isSaturday,
    bool? isSunday,
  }) = _CreateDutyDayDto;

  factory CreateDutyDayDto.fromJson(Map<String, dynamic> json) =>
      _$CreateDutyDayDtoFromJson(json);
}
