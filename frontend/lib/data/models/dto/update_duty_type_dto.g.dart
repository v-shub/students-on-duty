// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_duty_type_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UpdateDutyTypeDtoImpl _$$UpdateDutyTypeDtoImplFromJson(
  Map<String, dynamic> json,
) => _$UpdateDutyTypeDtoImpl(
  name: json['name'] as String?,
  description: json['description'] as String?,
  defaultScore: (json['defaultScore'] as num?)?.toInt(),
);

Map<String, dynamic> _$$UpdateDutyTypeDtoImplToJson(
  _$UpdateDutyTypeDtoImpl instance,
) => <String, dynamic>{
  'name': instance.name,
  'description': instance.description,
  'defaultScore': instance.defaultScore,
};
