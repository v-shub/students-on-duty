import 'package:freezed_annotation/freezed_annotation.dart';

part 'student.freezed.dart';
part 'student.g.dart';

// Кастомный конвертер для преобразования String/num в int
class StringToIntConverter implements JsonConverter<int, dynamic> {
  const StringToIntConverter();

  @override
  int fromJson(dynamic json) {
    if (json == null) return 0;
    if (json is int) return json;
    if (json is String) return int.parse(json);
    if (json is double) return json.toInt();
    if (json is num) return json.toInt();
    throw ArgumentError('Cannot convert $json to int');
  }

  @override
  dynamic toJson(int object) => object;
}

@freezed
abstract class Student with _$Student {
  const factory Student({
    @StringToIntConverter() required int id,
    required String name,
    @JsonKey(name: 'is_active') @Default(true) bool isActive,
    @JsonKey(name: 'duty_score') @Default(0) int dutyScore,
  }) = _Student;

  factory Student.fromJson(Map<String, dynamic> json) =>
      _$StudentFromJson(json);
}