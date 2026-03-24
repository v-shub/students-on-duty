import 'package:freezed_annotation/freezed_annotation.dart';

part 'create_group_dto.freezed.dart';
part 'create_group_dto.g.dart';

@freezed
abstract class CreateGroupDto with _$CreateGroupDto {
  const factory CreateGroupDto({required String name, String? description}) =
      _CreateGroupDto;

  factory CreateGroupDto.fromJson(Map<String, dynamic> json) =>
      _$CreateGroupDtoFromJson(json);
}
