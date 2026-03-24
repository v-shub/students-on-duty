import 'package:freezed_annotation/freezed_annotation.dart';

part 'duty_day.freezed.dart';
part 'duty_day.g.dart';

@freezed
abstract class DutyDay with _$DutyDay {
  const factory DutyDay({
    @JsonKey(name: 'schedule_id') required int scheduleId,
    @JsonKey(name: 'is_monday') @Default(false) bool isMonday,
    @JsonKey(name: 'is_tuesday') @Default(false) bool isTuesday,
    @JsonKey(name: 'is_wednesday') @Default(false) bool isWednesday,
    @JsonKey(name: 'is_thursday') @Default(false) bool isThursday,
    @JsonKey(name: 'is_friday') @Default(false) bool isFriday,
    @JsonKey(name: 'is_saturday') @Default(false) bool isSaturday,
    @JsonKey(name: 'is_sunday') @Default(false) bool isSunday,
  }) = _DutyDay;

  factory DutyDay.fromJson(Map<String, dynamic> json) =>
      _$DutyDayFromJson(json);
}
