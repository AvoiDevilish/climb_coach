import 'package:flutter/foundation.dart';

import '../../data/repositories/movement_repository.dart';
import '../../domain/models/movement.dart';

class MovementController extends ChangeNotifier {

  final MovementRepository _repository =
      MovementRepository();

  List<Movement> _movements = [];

  List<Movement> get movements => _movements;

  Future<void> loadMovements() async {

    _movements =
        await _repository.getAllMovements();

    notifyListeners();

  }

  Future<List<Movement>> getByCategory(
    String categoryId,
  ) async {

    return await _repository.getByCategory(
      categoryId,
    );

  }

  Future<Movement?> getById(
    String id,
  ) async {

    return await _repository.getById(id);

  }

}