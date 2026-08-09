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
      return movement.title
          .toLowerCase()
          .contains(q);
    }).toList();
  }

  static List<Movement> byCategory(
    List<Movement> movements,
    String categoryId,
  ) {
    return movements.where(
      (movement) =>
          movement.categoryId == categoryId,
    ).toList();
  }
}