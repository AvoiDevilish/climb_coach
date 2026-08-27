import 'package:climb_coach/core/database/database_helper.dart';
import 'package:climb_coach/core/database/tables.dart';
import 'package:sqflite/sqflite.dart';
import '../../domain/models/session_occurrence.dart';
import '../../domain/services/session_occurrence_generator.dart';

class SessionOccurrenceRepository {
  Future<int> insertOccurrence(
    SessionOccurrence occurrence,
  ) async {
    final db =
        await DatabaseHelper.instance.database;

    return db.insert(
      Tables.sessionOccurrences,
      occurrence.toMap(),
    );
  }

  Future<int> insertOccurrenceIfNotExists(
    SessionOccurrence occurrence,
  ) async {
    final db =
        await DatabaseHelper.instance.database;

    return db.insert(
      Tables.sessionOccurrences,
      occurrence.toMap(),
      conflictAlgorithm: ConflictAlgorithm.ignore,
    );
  }

  Future<void> insertGeneratedOccurrences(
    List<SessionOccurrenceData> items,
  ) async {
    if (items.isEmpty) return;

    final db =
        await DatabaseHelper.instance.database;

    final batch = db.batch();

    for (final data in items) {
      final occurrence =
          SessionOccurrence(
        sessionId: data.sessionId,
        occurrenceDate:
            _formatDate(data.occurrenceDate),
        startTime: data.startTime,
        endTime: data.endTime,
        status: data.status,
      );

      batch.insert(
        Tables.sessionOccurrences,
        occurrence.toMap(),
        conflictAlgorithm:
            ConflictAlgorithm.ignore,
      );
    }

    await batch.commit(
      noResult: true,
    );
  }

  Future<List<SessionOccurrence>>
      getOccurrencesOfSession(
    String sessionId,
  ) async {
    final db =
        await DatabaseHelper.instance.database;

    final result = await db.query(
      Tables.sessionOccurrences,
      where:
          'session_id = ? AND is_deleted = 0',
      whereArgs: [
        sessionId,
      ],
      orderBy:
          'occurrence_date ASC, start_time ASC',
    );

    return result
        .map(
          (e) => SessionOccurrence.fromMap(e),
        )
        .toList();
  }

  String _formatDate(DateTime date) {
    final year =
        date.year.toString().padLeft(4, '0');

    final month =
        date.month.toString().padLeft(2, '0');

    final day =
        date.day.toString().padLeft(2, '0');

    return '$year-$month-$day';
  }

  Future<int> insertGeneratedOccurrence(
    SessionOccurrenceData data,
  ) async {
    final occurrence =
        SessionOccurrence(
      sessionId: data.sessionId,
      occurrenceDate:
          data.occurrenceDate
              .toIso8601String()
              .substring(0, 10),
      startTime: data.startTime,
      endTime: data.endTime,
      status: data.status,
    );

    return insertOccurrenceIfNotExists(
      occurrence,
    );
  }

  Future<SessionOccurrence?> getOccurrence(
    String id,
  ) async {
    final db =
        await DatabaseHelper.instance.database;

    final result = await db.query(
      Tables.sessionOccurrences,
      where: 'id = ?',
      whereArgs: [id],
      limit: 1,
    );

    if (result.isEmpty) {
      return null;
    }

    return SessionOccurrence.fromMap(
      result.first,
    );
  }

  Future<int> updateOccurrence(
    SessionOccurrence occurrence,
  ) async {
    final db =
        await DatabaseHelper.instance.database;

    final data = occurrence.toMap();

    data.remove('id');

    return db.update(
      Tables.sessionOccurrences,
      data,
      where: 'id = ?',
      whereArgs: [occurrence.id],
    );
  }

  Future<int> deleteOccurrence(
    String id,
  ) async {
    final db =
        await DatabaseHelper.instance.database;

    return db.update(
      Tables.sessionOccurrences,
      {
        'is_deleted': 1,
        'updated_at':
            DateTime.now().toIso8601String(),
      },
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<List<SessionOccurrence>>
      getOccurrencesBetween(
    String startDate,
    String endDate,
  ) async {
    final db =
        await DatabaseHelper.instance.database;

    final result = await db.query(
      Tables.sessionOccurrences,
      where: '''
        is_deleted = 0
        AND occurrence_date >= ?
        AND occurrence_date <= ?
      ''',
      whereArgs: [
        startDate,
        endDate,
      ],
      orderBy:
          'occurrence_date ASC, start_time ASC',
    );

    return result
        .map(
          (e) => SessionOccurrence.fromMap(e),
        )
        .toList();
  }
}
