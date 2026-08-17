import '../../domain/models/movement.dart';
import '../../domain/models/movement_category.dart';

import '../seed/category_seed.dart';
import '../seed/movement_seed.dart';

class MovementRepository {
  Future<List<MovementCategory>> getCategories() async {
    return CategorySeed.categories;
  }

  Future<List<Movement>> getAllMovements() async {
    return MovementSeed.movements;
  }

  Future<List<Movement>> getByCategory(
    String category,
  ) async {
    return MovementSeed.movements
        .where(
          (movement) => movement.category == category,
        )
        .toList();
  }

  Future<Movement?> getById(
    String id,
  ) async {
    try {
      return MovementSeed.movements.firstWhere(
        (movement) => movement.id == id,
      );
    } catch (_) {
      return null;
    }
  }
}