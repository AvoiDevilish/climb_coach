import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import 'tables.dart';
import 'create_tables.dart';

class DatabaseHelper {
  DatabaseHelper._();

  static final DatabaseHelper instance =
      DatabaseHelper._();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }

    _database = await _initDatabase();

    return _database!;
  }

  Future<Database> _initDatabase() async {
    final directory =
        await getApplicationDocumentsDirectory();

    final path = join(
      directory.path,
      Tables.databaseName,
    );

    return await openDatabase(
      path,
      version: Tables.databaseVersion,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
    );
  }

  Future<void> _onCreate(
    Database db,
    int version,
  ) async {
    await db.execute(
      CreateTables.createAthletesTable,
    );

    await db.execute(
      CreateTables.createCustomFieldsTable,
    );

    await db.execute(
      CreateTables.createAthleteValuesTable,
    );

    await db.execute(
      CreateTables.createMovementCategoriesTable,
    );

    await db.execute(
      CreateTables.createMovementsTable,
    );

    await db.execute(
      CreateTables.createSessionsTable,
    );

    await db.execute(
      CreateTables.createSessionOccurrencesTable,
    );

    await db.execute(
      CreateTables.createSessionMembersTable,
    );

    await db.execute(
      CreateTables.createAttendanceTable,
    );

    await db.execute(
      CreateTables.createMovementPerformancesTable,
    );

    await db.execute(CreateTables.createAssessmentsTable);
    await db.execute(CreateTables.createAssessmentItemsTable);
    await db.execute(CreateTables.createAssessmentResultsTable);
    await db.execute(CreateTables.createTrainingProgramsTable);
    await db.execute(CreateTables.createTrainingProgramItemsTable);
    await db.execute(CreateTables.createAthleteTrainingAssignmentsTable);
    await db.execute(CreateTables.createTrainingLogsTable);

    await db.execute(
      CreateTables.createIndexes,
    );
  }

  Future<void> _onUpgrade(
    Database db,
    int oldVersion,
    int newVersion,
  ) async {
    if (oldVersion < 2) {
      await db.execute(
        'ALTER TABLE athletes ADD COLUMN gender TEXT',
      );

      await db.execute(
        'ALTER TABLE athletes ADD COLUMN age INTEGER',
      );

      await db.execute(
        'ALTER TABLE athletes ADD COLUMN height REAL',
      );

      await db.execute(
        'ALTER TABLE athletes ADD COLUMN weight REAL',
      );

      await db.execute(
        'ALTER TABLE athletes ADD COLUMN profile_image TEXT',
      );
    }

    if (oldVersion < 4) {
      await db.execute(
        CreateTables.createSessionsTable,
      );

      await db.execute(
        CreateTables.createAttendanceTable,
      );
    }

    if (oldVersion < 5) {
      await db.execute(
        CreateTables.createSessionMembersTable,
      );
    }

    if (oldVersion < 6) {
      await db.execute(
        'ALTER TABLE sessions ADD COLUMN coach_id TEXT',
      );
    }

    if (oldVersion < 9) {
      final columns = await db.rawQuery(
        'PRAGMA table_info(sessions)',
      );

      final columnNames = columns
          .map(
            (column) => column['name'],
          )
          .toList();

      if (!columnNames.contains('is_recurring')) {
        await db.execute(
          'ALTER TABLE sessions '
          'ADD COLUMN is_recurring '
          'INTEGER NOT NULL DEFAULT 0;',
        );
      }

      if (!columnNames.contains('weekday')) {
        await db.execute(
          'ALTER TABLE sessions '
          'ADD COLUMN weekday INTEGER;',
        );
      }

      if (!columnNames.contains('club')) {
        await db.execute(
          'ALTER TABLE sessions '
          'ADD COLUMN club TEXT;',
        );
      }
    }

    if (oldVersion < 10) {
      await db.execute(
        'CREATE INDEX IF NOT EXISTS '
        'idx_attendance_athlete '
        'ON attendance(athlete_id)',
      );

      await db.execute(
        'CREATE INDEX IF NOT EXISTS '
        'idx_session_members_athlete '
        'ON session_members(athlete_id)',
      );
    }

    if (oldVersion < 11) {
      await db.execute(
        CreateTables.createMovementPerformancesTable,
      );

      await db.execute(
        'CREATE INDEX IF NOT EXISTS '
        'idx_movement_performances_athlete '
        'ON movement_performances(athlete_id)',
      );

      await db.execute(
        'CREATE INDEX IF NOT EXISTS '
        'idx_movement_performances_movement '
        'ON movement_performances(movement_id)',
      );
    }

    if (oldVersion < 13) {
      final athleteColumns = await db.rawQuery('PRAGMA table_info(${Tables.athletes})');
      final athleteNames = athleteColumns.map((e) => e['name']).toSet();
      if (!athleteNames.contains('health_status')) {
        await db.execute("ALTER TABLE ${Tables.athletes} ADD COLUMN health_status TEXT NOT NULL DEFAULT 'healthy'");
      }
      if (!athleteNames.contains('injury_areas')) {
        await db.execute('ALTER TABLE ${Tables.athletes} ADD COLUMN injury_areas TEXT');
      }
      if (!athleteNames.contains('injury_since')) {
        await db.execute('ALTER TABLE ${Tables.athletes} ADD COLUMN injury_since TEXT');
      }
      if (!athleteNames.contains('recovery_until')) {
        await db.execute('ALTER TABLE ${Tables.athletes} ADD COLUMN recovery_until TEXT');
      }

      final movementColumns = await db.rawQuery('PRAGMA table_info(${Tables.movements})');
      final names = movementColumns.map((e) => e['name']).toSet();
      if (!names.contains('is_corrective')) {
        await db.execute('ALTER TABLE ${Tables.movements} ADD COLUMN is_corrective INTEGER NOT NULL DEFAULT 0');
      }
      if (!names.contains('injury_areas')) {
        await db.execute('ALTER TABLE ${Tables.movements} ADD COLUMN injury_areas TEXT');
      }
      await db.execute(CreateTables.createAssessmentsTable);
      await db.execute(CreateTables.createAssessmentItemsTable);
      await db.execute(CreateTables.createAssessmentResultsTable);
      await db.execute(CreateTables.createTrainingProgramsTable);
      await db.execute(CreateTables.createTrainingProgramItemsTable);
      await db.execute(CreateTables.createAthleteTrainingAssignmentsTable);
      await db.execute(CreateTables.createTrainingLogsTable);
      await db.execute('CREATE INDEX IF NOT EXISTS idx_assignment_athlete ON ${Tables.athleteTrainingAssignments}(athlete_id)');
      await db.execute('CREATE INDEX IF NOT EXISTS idx_training_logs_athlete ON ${Tables.trainingLogs}(athlete_id)');
    }

    if (oldVersion < 12) {
      await db.execute(
        CreateTables.createSessionOccurrencesTable,
      );

      await db.execute(
        'CREATE INDEX IF NOT EXISTS '
        'idx_session_occurrences_session '
        'ON session_occurrences(session_id)',
      );

      await db.execute(
        'CREATE INDEX IF NOT EXISTS '
        'idx_session_occurrences_date '
        'ON session_occurrences(occurrence_date)',
      );

      await db.execute(
        'CREATE INDEX IF NOT EXISTS '
        'idx_session_occurrences_session_date '
        'ON session_occurrences(session_id, occurrence_date)',
      );
    }

  }
}
