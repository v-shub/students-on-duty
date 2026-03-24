import 'package:freezed_annotation/freezed_annotation.dart';

part 'create_duty_day_dto.freezed.dart';
part 'create_duty_day_dto.g.dart';

@freezed
abstract class CreateDutyDayDto with _$CreateDutyDayDto {
    const factory CreateDutyDayDto({
    @JsonKey(name: 'schedule_id') required int scheduleId,
    @JsonKey(name: 'is_monday') bool? isMonday,
    @JsonKey(name: 'is_tuesday') bool? isTuesday,
    @JsonKey(name: 'is_wednesday') bool? isWednesday,
    @JsonKey(name: 'is_thursday') bool? isThursday,
    @JsonKey(name: 'is_friday') bool? isFriday,
    @JsonKey(name: 'is_saturday') bool? isSaturday,
    @JsonKey(name: 'is_sunday') bool? isSunday,
  }) = _CreateDutyDayDto;

  factory CreateDutyDayDto.fromJson(Map<String, dynamic> json) =>
      _$CreateDutyDayDtoFromJson(json);
}
