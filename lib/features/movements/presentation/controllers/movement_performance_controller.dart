import 'package:flutter/foundation.dart';

import '../../data/repositories/movement_performance_repository.dart';
import '../../domain/models/movement_performance.dart';

class MovementPerformanceController extends ChangeNotifier {
  final MovementPerformanceRepository _repository =
      MovementPerformanceRepository();

  List<MovementPerformance> _performances = [];

  bool _loading = false;

  List<MovementPerformance> get performances =>
      _performances;

  bool get loading => _loading;

  Future<void> loadByAthlete(
    String athleteId,
  ) async {
    _loading = true;
    notifyListeners();

    try {
      _performances =
          await _repository.getByAthlete(
        athleteId,
      );
    } finally {
      _loading = false;
      notifyListeners();
    }
  }

  Future<void> addPerformance(
    MovementPerformance performance,
  ) async {
    await _repository.insertPerformance(
      performance,
    );

    await loadByAthlete(
      performance.athleteId,
    );
  }

  Future<MovementPerformance?> getLatest(
    String athleteId,
    String movementId,
  ) async {
    return _repository.getLatest(
      athleteId,
      movementId,
    );
  }

  Future<List<MovementPerformance>>
      getByMovement(
    String movementId,
  ) async {
    return _repository.getByMovement(
      movementId,
    );
  }
}