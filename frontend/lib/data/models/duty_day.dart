import 'package:freezed_annotation/freezed_annotation.dart';

part 'duty_day.freezed.dart';
part 'duty_day.g.dart';

@freezed
class DutyDay with _$DutyDay {
  const factory DutyDay({
    required int scheduleId,
    @Default(false) bool isMonday,
    @Default(false) bool isTuesday,
    @Default(false) bool isWednesday,
    @Default(false) bool isThursday,
    @Default(false) bool isFriday,
    @Default(false) bool isSaturday,
    @Default(false) bool isSunday,
  }) = _DutyDay;

  factory DutyDay.fromJson(Map<String, dynamic> json) =>
      _$DutyDayFromJson(json);
}
