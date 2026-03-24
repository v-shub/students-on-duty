// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'duty_type.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_DutyType _$DutyTypeFromJson(Map<String, dynamic> json) => _DutyType(
  id: (json['id'] as num).toInt(),
  name: json['name'] as String,
  description: json['description'] as String?,
  defaultScore: (json['default_score'] as num).toInt(),
);

Map<String, dynamic> _$DutyTypeToJson(_DutyType instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'description': instance.description,
  'default_score': instance.defaultScore,
};
