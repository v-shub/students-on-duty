import 'package:freezed_annotation/freezed_annotation.dart';

part 'absence.freezed.dart';
part 'absence.g.dart';

@freezed
abstract class Absence with _$Absence {
  const factory Absence({
    required int id,
    @JsonKey(name: 'student_id') required int studentId,
    @JsonKey(name: 'date_from') required DateTime dateFrom,
    @JsonKey(name: 'date_to') required DateTime dateTo,
    String? reason,
    @JsonKey(name: 'is_approved') @Default(false) bool isApproved,
  }) = _Absence;

  factory Absence.fromJson(Map<String, dynamic> json) =>
      _$AbsenceFromJson(json);
}
