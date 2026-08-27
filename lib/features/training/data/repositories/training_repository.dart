import 'package:sqflite/sqflite.dart';

import '../../../../core/database/database_helper.dart';
import '../../../../core/database/tables.dart';
import '../../domain/models/athlete_training_assignment.dart';
import '../../domain/models/training_program.dart';
import '../../domain/models/training_program_item.dart';
import '../../domain/models/training_log.dart';
import '../seed/training_program_seed.dart';

class TrainingRepository {
  Future<List<TrainingProgram>> getPrograms() async {
    final db = await DatabaseHelper.instance.database;
    final rows = await db.query(Tables.trainingPrograms, where: 'is_deleted = 0', orderBy: 'title');
    if (rows.isEmpty) {
      for (final program in TrainingProgramSeed.programs) {
        await db.insert(Tables.trainingPrograms, program.toMap(), conflictAlgorithm: ConflictAlgorithm.ignore);
      }
      for (final item in TrainingProgramSeed.items) {
        await db.insert(Tables.trainingProgramItems, item.toMap(), conflictAlgorithm: ConflictAlgorithm.ignore);
      }
      final seeded = await db.query(Tables.trainingPrograms, where: 'is_deleted = 0', orderBy: 'title');
      return seeded.map(TrainingProgram.fromMap).toList();
    }
    return rows.map(TrainingProgram.fromMap).toList();
  }

  Future<List<TrainingProgramItem>> getProgramItems(String programId) async {
    final db = await DatabaseHelper.instance.database;
    final rows = await db.query(Tables.trainingProgramItems, where: 'program_id = ?', whereArgs: [programId], orderBy: 'display_order');
    return rows.map(TrainingProgramItem.fromMap).toList();
  }

  Future<int> createProgram(TrainingProgram program, List<TrainingProgramItem> items) async {
    final db = await DatabaseHelper.instance.database;
    return db.transaction((txn) async {
      await txn.insert(Tables.trainingPrograms, program.toMap());
      for (final item in items) {
        await txn.insert(Tables.trainingProgramItems, item.toMap());
      }
      return items.length;
    });
  }

  Future<int> assignProgram(AthleteTrainingAssignment assignment) async {
    final db = await DatabaseHelper.instance.database;
    return db.insert(Tables.athleteTrainingAssignments, assignment.toMap());
  }

  Future<int> assignMovement(AthleteTrainingAssignment assignment) async {
    final db = await DatabaseHelper.instance.database;
    return db.insert(Tables.athleteTrainingAssignments, assignment.toMap());
  }

  Future<int> recordLog(TrainingLog log) async {
    final db = await DatabaseHelper.instance.database;
    return db.insert(Tables.trainingLogs, log.toMap());
  }

  Future<int> cancelAssignment(String id) async {
    final db = await DatabaseHelper.instance.database;
    return db.update(Tables.athleteTrainingAssignments, {'status': 'cancelled'}, where: 'id = ?', whereArgs: [id]);
  }

  Future<List<AthleteTrainingAssignment>> getAssignments(String athleteId) async {
    final db = await DatabaseHelper.instance.database;
    final rows = await db.query(Tables.athleteTrainingAssignments, where: 'athlete_id = ?', whereArgs: [athleteId], orderBy: 'assigned_at DESC');
    return rows.map(AthleteTrainingAssignment.fromMap).toList();
  }
}
