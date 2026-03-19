// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_absence_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UpdateAbsenceDtoImpl _$$UpdateAbsenceDtoImplFromJson(
  Map<String, dynamic> json,
) => _$UpdateAbsenceDtoImpl(
  studentId: (json['studentId'] as num?)?.toInt(),
  dateFrom: json['dateFrom'] as String?,
  dateTo: json['dateTo'] as String?,
  reason: json['reason'] as String?,
  isApproved: json['isApproved'] as bool?,
);

Map<String, dynamic> _$$UpdateAbsenceDtoImplToJson(
  _$UpdateAbsenceDtoImpl instance,
) => <String, dynamic>{
  'studentId': instance.studentId,
  'dateFrom': instance.dateFrom,
  'dateTo': instance.dateTo,
  'reason': instance.reason,
  'isApproved': instance.isApproved,
};
