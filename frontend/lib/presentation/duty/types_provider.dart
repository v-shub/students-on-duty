import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/data/models/dto/create_duty_type_dto.dart';
import 'package:frontend/data/models/dto/update_duty_type_dto.dart';
import 'package:frontend/data/models/duty_type.dart';
import 'package:frontend/data/services/api_client.dart';

final dutyTypesProvider = FutureProvider<List<DutyType>>((ref) async {
  final apiClient = ref.read(apiClientProvider);
  return await apiClient.getDutyTypes();
});

class DutyTypeNotifier extends StateNotifier<AsyncValue<List<DutyType>>> {
  final Ref ref;

  DutyTypeNotifier(this.ref) : super(const AsyncValue.loading()) {
    _loadTypes();
  }

  Future<void> _loadTypes() async {
    state = const AsyncValue.loading();
    try {
      final types = await ref.read(apiClientProvider).getDutyTypes();
      state = AsyncValue.data(types);
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }

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
      await _loadTypes();
      return true;
    } catch (e) {
      return false;
    }
  }

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
      await _loadTypes();
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> deleteType(int id) async {
    try {
      await ref.read(apiClientProvider).deleteDutyType(id);
      await _loadTypes();
      return true;
    } catch (e) {
      return false;
    }
  }
}

final dutyTypeProvider =
    StateNotifierProvider<DutyTypeNotifier, AsyncValue<List<DutyType>>>((ref) {
      return DutyTypeNotifier(ref);
    });
