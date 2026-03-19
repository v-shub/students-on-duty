import 'package:freezed_annotation/freezed_annotation.dart';

part 'absence.freezed.dart';
part 'absence.g.dart';

@freezed
class Absence with _$Absence {
  const factory Absence({
    required int id,
    required int studentId,
    required DateTime dateFrom,
    required DateTime dateTo,
    String? reason,
    @Default(false) bool isApproved,
  }) = _Absence;

  factory Absence.fromJson(Map<String, dynamic> json) =>
      _$AbsenceFromJson(json);
}
