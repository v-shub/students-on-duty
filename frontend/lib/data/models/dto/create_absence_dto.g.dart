// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_absence_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CreateAbsenceDtoImpl _$$CreateAbsenceDtoImplFromJson(
  Map<String, dynamic> json,
) => _$CreateAbsenceDtoImpl(
  studentId: (json['studentId'] as num).toInt(),
  dateFrom: json['dateFrom'] as String,
  dateTo: json['dateTo'] as String,
  reason: json['reason'] as String?,
  isApproved: json['isApproved'] as bool?,
);

Map<String, dynamic> _$$CreateAbsenceDtoImplToJson(
  _$CreateAbsenceDtoImpl instance,
) => <String, dynamic>{
  'studentId': instance.studentId,
  'dateFrom': instance.dateFrom,
  'dateTo': instance.dateTo,
  'reason': instance.reason,
  'isApproved': instance.isApproved,
};
