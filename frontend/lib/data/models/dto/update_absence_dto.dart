import 'package:freezed_annotation/freezed_annotation.dart';

part 'update_absence_dto.freezed.dart';
part 'update_absence_dto.g.dart';

@freezed
class UpdateAbsenceDto with _$UpdateAbsenceDto {
  const factory UpdateAbsenceDto({
    int? studentId,
    String? dateFrom,
    String? dateTo,
    String? reason,
    bool? isApproved,
  }) = _UpdateAbsenceDto;

  factory UpdateAbsenceDto.fromJson(Map<String, dynamic> json) =>
      _$UpdateAbsenceDtoFromJson(json);
}
