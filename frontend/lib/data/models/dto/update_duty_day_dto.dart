import 'package:freezed_annotation/freezed_annotation.dart';

part 'update_duty_day_dto.freezed.dart';
part 'update_duty_day_dto.g.dart';

@freezed
class UpdateDutyDayDto with _$UpdateDutyDayDto {
  const factory UpdateDutyDayDto({
    bool? isMonday,
    bool? isTuesday,
    bool? isWednesday,
    bool? isThursday,
    bool? isFriday,
    bool? isSaturday,
    bool? isSunday,
  }) = _UpdateDutyDayDto;

  factory UpdateDutyDayDto.fromJson(Map<String, dynamic> json) =>
      _$UpdateDutyDayDtoFromJson(json);
}
