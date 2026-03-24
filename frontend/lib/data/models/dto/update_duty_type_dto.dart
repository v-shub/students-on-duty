import 'package:freezed_annotation/freezed_annotation.dart';

part 'update_duty_type_dto.freezed.dart';
part 'update_duty_type_dto.g.dart';

@freezed
abstract class UpdateDutyTypeDto with _$UpdateDutyTypeDto {
    const factory UpdateDutyTypeDto({
    String? name,
    String? description,
    @JsonKey(name: 'default_score') int? defaultScore,
  }) = _UpdateDutyTypeDto;

  factory UpdateDutyTypeDto.fromJson(Map<String, dynamic> json) =>
      _$UpdateDutyTypeDtoFromJson(json);
}
