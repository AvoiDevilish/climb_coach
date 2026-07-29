import 'tables.dart';

class CreateTables {
  static const String createAthletesTable = '''
CREATE TABLE ${Tables.athletes} (

id TEXT PRIMARY KEY,

first_name TEXT NOT NULL,

last_name TEXT NOT NULL,

created_at TEXT NOT NULL,

updated_at TEXT NOT NULL,

is_deleted INTEGER NOT NULL DEFAULT 0

);
''';


  static const String createCustomFieldsTable = '''
CREATE TABLE ${Tables.customFields} (

id TEXT PRIMARY KEY,

name TEXT NOT NULL,

type TEXT NOT NULL,

is_required INTEGER NOT NULL DEFAULT 0,

created_at TEXT NOT NULL

);
''';


  static const String createAthleteValuesTable = '''
CREATE TABLE ${Tables.athleteValues} (

id TEXT PRIMARY KEY,

athlete_id TEXT NOT NULL,

field_id TEXT NOT NULL,

value TEXT,

created_at TEXT NOT NULL

);
''';
}
