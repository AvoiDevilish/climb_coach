import '../models/movement.dart';

class MovementFilterService {
  static List<Movement> search(
    List<Movement> movements,
    String query,
  ) {
    if (query.trim().isEmpty) {
      return movements;
    }

    final q = query.trim().toLowerCase();

    return movements.where((movement) {
      final name = movement.name.toLowerCase();

      final bodyRegion =
          movement.bodyRegion.toLowerCase();

      final muscles =
          movement.primaryMuscles.join(' ').toLowerCase();

      return name.contains(q) ||
          bodyRegion.contains(q) ||
          muscles.contains(q);
    }).toList();
  }

  static List<Movement> byCategory(
    List<Movement> movements,
    String category,
  ) {
    return movements.where(
      (movement) => movement.categoryId == category,
    ).toList();
  }
}