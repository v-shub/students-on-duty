import 'package:freezed_annotation/freezed_annotation.dart';

part 'create_duty_type_dto.freezed.dart';
part 'create_duty_type_dto.g.dart';

@freezed
class CreateDutyTypeDto with _$CreateDutyTypeDto {
  const factory CreateDutyTypeDto({
    required String name,
    String? description,
    required int defaultScore,
  }) = _CreateDutyTypeDto;

  factory CreateDutyTypeDto.fromJson(Map<String, dynamic> json) =>
      _$CreateDutyTypeDtoFromJson(json);
}
