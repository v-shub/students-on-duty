// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_duty_type_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CreateDutyTypeDtoImpl _$$CreateDutyTypeDtoImplFromJson(
  Map<String, dynamic> json,
) => _$CreateDutyTypeDtoImpl(
  name: json['name'] as String,
  description: json['description'] as String?,
  defaultScore: (json['defaultScore'] as num).toInt(),
);

Map<String, dynamic> _$$CreateDutyTypeDtoImplToJson(
  _$CreateDutyTypeDtoImpl instance,
) => <String, dynamic>{
  'name': instance.name,
  'description': instance.description,
  'defaultScore': instance.defaultScore,
};
