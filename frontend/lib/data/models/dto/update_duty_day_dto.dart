import 'package:freezed_annotation/freezed_annotation.dart';

part 'update_duty_day_dto.freezed.dart';
part 'update_duty_day_dto.g.dart';

@freezed
abstract class UpdateDutyDayDto with _$UpdateDutyDayDto {
    const factory UpdateDutyDayDto({
    @JsonKey(name: 'is_monday') bool? isMonday,
    @JsonKey(name: 'is_tuesday') bool? isTuesday,
    @JsonKey(name: 'is_wednesday') bool? isWednesday,
    @JsonKey(name: 'is_thursday') bool? isThursday,
    @JsonKey(name: 'is_friday') bool? isFriday,
    @JsonKey(name: 'is_saturday') bool? isSaturday,
    @JsonKey(name: 'is_sunday') bool? isSunday,
  }) = _UpdateDutyDayDto;

  factory UpdateDutyDayDto.fromJson(Map<String, dynamic> json) =>
      _$UpdateDutyDayDtoFromJson(json);
}
