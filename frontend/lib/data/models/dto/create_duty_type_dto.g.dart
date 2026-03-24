// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_duty_type_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CreateDutyTypeDto _$CreateDutyTypeDtoFromJson(Map<String, dynamic> json) =>
    _CreateDutyTypeDto(
      name: json['name'] as String,
      description: json['description'] as String?,
      defaultScore: (json['default_score'] as num).toInt(),
    );

Map<String, dynamic> _$CreateDutyTypeDtoToJson(_CreateDutyTypeDto instance) =>
    <String, dynamic>{
      'name': instance.name,
      'description': instance.description,
      'default_score': instance.defaultScore,
    };
