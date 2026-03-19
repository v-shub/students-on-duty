import 'package:freezed_annotation/freezed_annotation.dart';

part 'create_absence_dto.freezed.dart';
part 'create_absence_dto.g.dart';

@freezed
class CreateAbsenceDto with _$CreateAbsenceDto {
  const factory CreateAbsenceDto({
    required int studentId,
    required String dateFrom,
    required String dateTo,
    String? reason,
    bool? isApproved,
  }) = _CreateAbsenceDto;

  factory CreateAbsenceDto.fromJson(Map<String, dynamic> json) =>
      _$CreateAbsenceDtoFromJson(json);
}
