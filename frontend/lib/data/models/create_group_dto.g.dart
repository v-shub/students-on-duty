// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_group_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CreateGroupDto _$CreateGroupDtoFromJson(Map<String, dynamic> json) =>
    _CreateGroupDto(
      name: json['name'] as String,
      description: json['description'] as String?,
    );

Map<String, dynamic> _$CreateGroupDtoToJson(_CreateGroupDto instance) =>
    <String, dynamic>{
      'name': instance.name,
      'description': instance.description,
    };
