import 'tables.dart';

class CreateTables {
  static const String createAthletesTable = '''
CREATE TABLE ${Tables.athletes} (

id TEXT PRIMARY KEY,

first_name TEXT NOT NULL,

last_name TEXT NOT NULL,

gender TEXT,

age INTEGER,

height REAL,

weight REAL,

profile_image TEXT,

created_at TEXT NOT NULL,

updated_at TEXT NOT NULL,

is_deleted INTEGER NOT NULL DEFAULT 0

);
''';

  static const String createCustomFieldsTable = '''
CREATE TABLE ${Tables.customFields} (

id TEXT PRIMARY KEY,

title TEXT NOT NULL,

field_key TEXT NOT NULL UNIQUE,

field_type TEXT NOT NULL,

is_required INTEGER NOT NULL DEFAULT 0,

display_order INTEGER NOT NULL DEFAULT 0,

options TEXT,

created_at TEXT NOT NULL,

updated_at TEXT NOT NULL,

is_deleted INTEGER NOT NULL DEFAULT 0

);
''';

  static const String createAthleteValuesTable = '''
CREATE TABLE ${Tables.athleteValues} (

id TEXT PRIMARY KEY,

athlete_id TEXT NOT NULL,

field_id TEXT NOT NULL,

value TEXT,

created_at TEXT NOT NULL,

updated_at TEXT NOT NULL,

FOREIGN KEY (athlete_id)
REFERENCES athletes(id),

FOREIGN KEY (field_id)
REFERENCES custom_fields(id)

);
''';

static const String createMovementCategoriesTable = '''
CREATE TABLE movement_categories (

id TEXT PRIMARY KEY,

title TEXT NOT NULL,

icon TEXT NOT NULL,

display_order INTEGER NOT NULL

);
''';

static const String createMovementsTable = '''
CREATE TABLE movements (

id TEXT PRIMARY KEY,

category_id TEXT NOT NULL,

title TEXT NOT NULL,

record_type TEXT NOT NULL,

unit TEXT NOT NULL,

is_system INTEGER NOT NULL DEFAULT 1,

is_deleted INTEGER NOT NULL DEFAULT 0,

FOREIGN KEY(category_id)
REFERENCES movement_categories(id)

);
''';
}