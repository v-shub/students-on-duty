import 'package:freezed_annotation/freezed_annotation.dart';

part 'create_duty_type_dto.freezed.dart';
part 'create_duty_type_dto.g.dart';

@freezed
abstract class CreateDutyTypeDto with _$CreateDutyTypeDto {
    const factory CreateDutyTypeDto({
    required String name,
    String? description,
    @JsonKey(name: 'default_score') required int defaultScore,
  }) = _CreateDutyTypeDto;

  factory CreateDutyTypeDto.fromJson(Map<String, dynamic> json) =>
      _$CreateDutyTypeDtoFromJson(json);
}
