import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/data/models/dto/create_duty_type_dto.dart';
import 'package:frontend/data/models/dto/update_duty_type_dto.dart';
import 'package:frontend/data/models/duty_type.dart';
import 'package:frontend/data/services/api_client.dart';

/// Провайдер типов дежурств — загружается из API
/// Используется в экране создания расписания и экране управления типами
class DutyTypesNotifier extends AsyncNotifier<List<DutyType>> {
  @override
  Future<List<DutyType>> build() async {
    return await ref.read(apiClientProvider).getDutyTypes();
  }

  /// Перезагрузить список из API
  Future<void> reload() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(
      () => ref.read(apiClientProvider).getDutyTypes(),
    );
  }

  /// Создать новый тип дежурства через API
  Future<bool> createType(
    String name,
    int defaultScore, {
    String? description,
  }) async {
    try {
      final dto = CreateDutyTypeDto(
        name: name,
        defaultScore: defaultScore,
        description: description,
      );
      await ref.read(apiClientProvider).createDutyType(dto);
      await reload();
      return true;
    } catch (e) {
      return false;
    }
  }

  /// Обновить тип дежурства через API
  Future<bool> updateType(
    int id,
    String name,
    int defaultScore, {
    String? description,
  }) async {
    try {
      final dto = UpdateDutyTypeDto(
        name: name,
        defaultScore: defaultScore,
        description: description,
      );
      await ref.read(apiClientProvider).updateDutyType(id, dto);
      await reload();
      return true;
    } catch (e) {
      return false;
    }
  }

  /// Удалить тип дежурства через API
  Future<bool> deleteType(int id) async {
    try {
      await ref.read(apiClientProvider).deleteDutyType(id);
      await reload();
      return true;
    } catch (e) {
      return false;
    }
  }
}

final dutyTypesProvider =
    AsyncNotifierProvider<DutyTypesNotifier, List<DutyType>>(
      DutyTypesNotifier.new,
    );
