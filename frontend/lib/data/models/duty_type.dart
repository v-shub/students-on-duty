import 'package:freezed_annotation/freezed_annotation.dart';

part 'duty_type.freezed.dart';
part 'duty_type.g.dart';

@freezed
abstract class DutyType with _$DutyType {
  const factory DutyType({
    required int id,
    required String name,
    String? description,
    @JsonKey(name: 'default_score') required int defaultScore,
  }) = _DutyType;

  factory DutyType.fromJson(Map<String, dynamic> json) =>
      _$DutyTypeFromJson(json);
}
