// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_duty_type_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_UpdateDutyTypeDto _$UpdateDutyTypeDtoFromJson(Map<String, dynamic> json) =>
    _UpdateDutyTypeDto(
      name: json['name'] as String?,
      description: json['description'] as String?,
      defaultScore: (json['default_score'] as num?)?.toInt(),
    );

Map<String, dynamic> _$UpdateDutyTypeDtoToJson(_UpdateDutyTypeDto instance) =>
    <String, dynamic>{
      'name': instance.name,
      'description': instance.description,
      'default_score': instance.defaultScore,
    };
