import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/data/models/student.dart';

// Мок-список всех студентов пользователя (изначально пустой, можно добавить пару для демонстрации)
final List<Student> _mockAllStudents = [
  const Student(id: 1, name: 'Иванов Иван', isActive: true, dutyScore: 0),
  const Student(id: 2, name: 'Петров Пётр', isActive: true, dutyScore: 5),
  const Student(id: 3, name: 'Сидорова Анна', isActive: false, dutyScore: 2),
  const Student(id: 4, name: 'Кузнецов Дмитрий', isActive: true, dutyScore: 3),
  const Student(id: 5, name: 'Смирнова Елена', isActive: true, dutyScore: 1),
];

class AllStudentsNotifier extends StateNotifier<List<Student>> {
  AllStudentsNotifier() : super(_mockAllStudents);

  // Добавление нового студента
  void addStudent(Student student) {
    state = [...state, student];
  }

  // Обновление существующего
  void updateStudent(Student updated) {
    state = [
      for (final s in state)
        if (s.id == updated.id) updated else s,
    ];
  }

  // Удаление (если потребуется)
  void deleteStudent(int id) {
    state = state.where((s) => s.id != id).toList();
  }

  // Поиск студента по id (для получения)
  Student? getById(int id) {
    try {
      return state.firstWhere((s) => s.id == id);
    } catch (e) {
      return null;
    }
  }
}

final allStudentsProvider =
    StateNotifierProvider<AllStudentsNotifier, List<Student>>((ref) {
      return AllStudentsNotifier();
    });
