import 'package:freezed_annotation/freezed_annotation.dart';

part 'create_absence_dto.freezed.dart';
part 'create_absence_dto.g.dart';

@freezed
abstract class CreateAbsenceDto with _$CreateAbsenceDto {
    const factory CreateAbsenceDto({
    @JsonKey(name: 'student_id') required int studentId,
    @JsonKey(name: 'date_from') required String dateFrom,
    @JsonKey(name: 'date_to') required String dateTo,
    String? reason,
    @JsonKey(name: 'is_approved') bool? isApproved,
  }) = _CreateAbsenceDto;

  factory CreateAbsenceDto.fromJson(Map<String, dynamic> json) =>
      _$CreateAbsenceDtoFromJson(json);
}
