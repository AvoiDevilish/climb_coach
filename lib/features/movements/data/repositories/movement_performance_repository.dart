import '../../../../core/database/database_helper.dart';
import '../../../../core/database/tables.dart';
import '../../domain/models/movement_performance.dart';

class MovementPerformanceRepository {
  Future<int> insertPerformance(
    MovementPerformance performance,
  ) async {
    final db =
        await DatabaseHelper.instance.database;

    return db.insert(
      Tables.movementPerformances,
      performance.toMap(),
    );
  }

  Future<List<MovementPerformance>>
      getByAthlete(
    String athleteId,
  ) async {
    final db =
        await DatabaseHelper.instance.database;

    final result = await db.query(
      Tables.movementPerformances,
      where:
          'athlete_id = ? AND is_deleted = ?',
      whereArgs: [
        athleteId,
        0,
      ],
      orderBy: 'recorded_at DESC',
    );

    return result
        .map(
          (e) =>
              MovementPerformance.fromMap(e),
        )
        .toList();
  }

  Future<List<MovementPerformance>>
      getByMovement(
    String movementId,
  ) async {
    final db =
        await DatabaseHelper.instance.database;

    final result = await db.query(
      Tables.movementPerformances,
      where:
          'movement_id = ? AND is_deleted = ?',
      whereArgs: [
        movementId,
        0,
      ],
      orderBy: 'recorded_at DESC',
    );

    return result
        .map(
          (e) =>
              MovementPerformance.fromMap(e),
        )
        .toList();
  }

  Future<MovementPerformance?> getLatest(
    String athleteId,
    String movementId,
  ) async {
    final db =
        await DatabaseHelper.instance.database;

    final result = await db.query(
      Tables.movementPerformances,
      where:
          'athlete_id = ? '
          'AND movement_id = ? '
          'AND is_deleted = ?',
      whereArgs: [
        athleteId,
        movementId,
        0,
      ],
      orderBy: 'recorded_at DESC',
      limit: 1,
    );

    if (result.isEmpty) {
      return null;
    }

    return MovementPerformance.fromMap(
      result.first,
    );
  }
}