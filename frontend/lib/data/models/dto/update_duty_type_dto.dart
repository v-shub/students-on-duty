import 'package:freezed_annotation/freezed_annotation.dart';

part 'update_duty_type_dto.freezed.dart';
part 'update_duty_type_dto.g.dart';

@freezed
class UpdateDutyTypeDto with _$UpdateDutyTypeDto {
  const factory UpdateDutyTypeDto({
    String? name,
    String? description,
    int? defaultScore,
  }) = _UpdateDutyTypeDto;

  factory UpdateDutyTypeDto.fromJson(Map<String, dynamic> json) =>
      _$UpdateDutyTypeDtoFromJson(json);
}
