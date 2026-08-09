import 'package:climb_coach/core/database/database_helper.dart';
import 'package:climb_coach/core/database/tables.dart';
import 'package:climb_coach/features/athletes/domain/models/athlete.dart';

class AthleteRepository {
  Future<int> insertAthlete(Athlete athlete) async {
    final db = await DatabaseHelper.instance.database;

    return db.insert(
      Tables.athletes,
      athlete.toMap(),
    );
  }

  Future<List<Athlete>> getAllAthletes() async {
    final db = await DatabaseHelper.instance.database;

    final result = await db.query(
      Tables.athletes,
      orderBy: 'created_at DESC',
    );

    return result.map((e) => Athlete.fromMap(e)).toList();
  }

  Future<Athlete?> getAthlete(String id) async {
    final db = await DatabaseHelper.instance.database;

    final result = await db.query(
      Tables.athletes,
      where: 'id = ?',
      whereArgs: [id],
      limit: 1,
    );

    if (result.isEmpty) return null;

    return Athlete.fromMap(result.first);
  }

  Future<bool> athleteExists(
    String firstName,
    String lastName,
  ) async {
    final db = await DatabaseHelper.instance.database;

    final result = await db.query(
      Tables.athletes,
      where:
          'LOWER(TRIM(first_name)) = ? AND LOWER(TRIM(last_name)) = ?',
      whereArgs: [
        firstName.trim().toLowerCase(),
        lastName.trim().toLowerCase(),
      ],
      limit: 1,
    );

    return result.isNotEmpty;
  }

  Future<int> updateAthlete(Athlete athlete) async {
    final db = await DatabaseHelper.instance.database;

    final data = athlete.toMap();

    data.remove('id');

    return db.update(
      Tables.athletes,
      data,
      where: 'id = ?',
      whereArgs: [athlete.id],
    );
  }
}