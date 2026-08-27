import 'dart:convert';

import '../../../../core/database/database_helper.dart';
import '../../../../core/database/tables.dart';
import '../../domain/models/result/assessment_result.dart';

class AssessmentResultRepository {
  Future<int> insert(AssessmentResult result) async {
    final db = await DatabaseHelper.instance.database;
    return db.insert(Tables.assessmentResults, {
      'id': 'assessment_result_${DateTime.now().microsecondsSinceEpoch}',
      'assessment_id': result.assessmentId,
      'athlete_id': result.athleteId,
      'created_at': result.createdAt.toIso8601String(),
      'values_json': jsonEncode(result.values),
    });
  }

  Future<List<AssessmentResult>> getByAthlete(String athleteId) async {
    final db = await DatabaseHelper.instance.database;
    final rows = await db.query(Tables.assessmentResults, where: 'athlete_id = ?', whereArgs: [athleteId], orderBy: 'created_at DESC');
    return rows.map((row) => AssessmentResult(
      assessmentId: row['assessment_id'].toString(),
      athleteId: row['athlete_id']?.toString(),
      createdAt: DateTime.tryParse(row['created_at'].toString()) ?? DateTime.now(),
      values: Map<String, dynamic>.from(jsonDecode(row['values_json'].toString()) as Map),
    )).toList();
  }
}
