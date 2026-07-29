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
      orderBy: 'id DESC',
    );

    return result.map((e) => Athlete.fromMap(e)).toList();
  }
}