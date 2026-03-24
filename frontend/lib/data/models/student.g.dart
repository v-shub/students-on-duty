// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'student.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Student _$StudentFromJson(Map<String, dynamic> json) => _Student(
  id: const StringToIntConverter().fromJson(json['id']),
  name: json['name'] as String,
  isActive: json['is_active'] as bool? ?? true,
  dutyScore: (json['duty_score'] as num?)?.toInt() ?? 0,
);

Map<String, dynamic> _$StudentToJson(_Student instance) => <String, dynamic>{
  'id': const StringToIntConverter().toJson(instance.id),
  'name': instance.name,
  'is_active': instance.isActive,
  'duty_score': instance.dutyScore,
};
