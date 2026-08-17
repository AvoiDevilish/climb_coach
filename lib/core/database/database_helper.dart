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
      CreateTables.createSessionMembersTable,
    );

    await db.execute(
      CreateTables.createAttendanceTable,
    );

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
  }
}
