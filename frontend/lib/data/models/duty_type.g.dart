// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'duty_type.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DutyTypeImpl _$$DutyTypeImplFromJson(Map<String, dynamic> json) =>
    _$DutyTypeImpl(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      description: json['description'] as String?,
      defaultScore: (json['defaultScore'] as num).toInt(),
    );

Map<String, dynamic> _$$DutyTypeImplToJson(_$DutyTypeImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'defaultScore': instance.defaultScore,
    };
