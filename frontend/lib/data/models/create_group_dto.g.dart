// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_group_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CreateGroupDtoImpl _$$CreateGroupDtoImplFromJson(Map<String, dynamic> json) =>
    _$CreateGroupDtoImpl(
      name: json['name'] as String,
      description: json['description'] as String?,
    );

Map<String, dynamic> _$$CreateGroupDtoImplToJson(
  _$CreateGroupDtoImpl instance,
) => <String, dynamic>{
  'name': instance.name,
  'description': instance.description,
};
