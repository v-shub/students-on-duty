// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'student.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$StudentImpl _$$StudentImplFromJson(Map<String, dynamic> json) =>
    _$StudentImpl(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      isActive: json['isActive'] as bool? ?? true,
      dutyScore: (json['dutyScore'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$$StudentImplToJson(_$StudentImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'isActive': instance.isActive,
      'dutyScore': instance.dutyScore,
    };
