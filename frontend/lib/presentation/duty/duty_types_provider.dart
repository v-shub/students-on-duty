import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/data/models/duty_type.dart';

// Мок-список типов дежурств
final List<DutyType> _mockDutyTypes = [
  const DutyType(
    id: 1,
    name: 'Мытьё посуды',
    defaultScore: 5,
    description: 'Мытьё посуды после обеда',
  ),
  const DutyType(
    id: 2,
    name: 'Уборка комнаты',
    defaultScore: 3,
    description: 'Влажная уборка',
  ),
  const DutyType(
    id: 3,
    name: 'Полив цветов',
    defaultScore: 2,
    description: 'Полив комнатных растений',
  ),
  const DutyType(
    id: 4,
    name: 'Вынос мусора',
    defaultScore: 1,
    description: 'Вынести мусор',
  ),
  const DutyType(
    id: 5,
    name: 'Помощь преподавателю',
    defaultScore: 4,
    description: 'Раздать материалы',
  ),
];

// Провайдер, который сразу возвращает данные (без Future)
final dutyTypesProvider = Provider<List<DutyType>>((ref) {
  return _mockDutyTypes;
});

// Если нужен FutureProvider (для совместимости с будущим API), можно оставить и такой,
// но в текущем экране мы будем использовать простой Provider.
// Для создания расписания лучше использовать Provider, чтобы избежать загрузки.
