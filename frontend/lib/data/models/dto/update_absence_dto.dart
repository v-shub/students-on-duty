import 'package:freezed_annotation/freezed_annotation.dart';

part 'update_absence_dto.freezed.dart';
part 'update_absence_dto.g.dart';

@freezed
abstract class UpdateAbsenceDto with _$UpdateAbsenceDto {
    const factory UpdateAbsenceDto({
    @JsonKey(name: 'student_id') int? studentId,
    @JsonKey(name: 'date_from') String? dateFrom,
    @JsonKey(name: 'date_to') String? dateTo,
    String? reason,
    @JsonKey(name: 'is_approved') bool? isApproved,
  }) = _UpdateAbsenceDto;

  factory UpdateAbsenceDto.fromJson(Map<String, dynamic> json) =>
      _$UpdateAbsenceDtoFromJson(json);
}
