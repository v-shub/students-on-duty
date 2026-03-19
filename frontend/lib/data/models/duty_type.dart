import 'package:freezed_annotation/freezed_annotation.dart';

part 'duty_type.freezed.dart';
part 'duty_type.g.dart';

@freezed
class DutyType with _$DutyType {
  const factory DutyType({
    required int id,
    required String name,
    String? description,
    required int defaultScore,
  }) = _DutyType;

  factory DutyType.fromJson(Map<String, dynamic> json) =>
      _$DutyTypeFromJson(json);
}
