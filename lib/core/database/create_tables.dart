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

static const String createSessionsTable = '''
CREATE TABLE ${Tables.sessions} (

id TEXT PRIMARY KEY,

title TEXT NOT NULL,

club TEXT,

coach_id TEXT,

is_permanent INTEGER NOT NULL DEFAULT 0,

is_recurring INTEGER NOT NULL DEFAULT 0,

weekday INTEGER,

date TEXT,

start_time TEXT NOT NULL,

end_time TEXT NOT NULL,

capacity INTEGER NOT NULL,

allow_makeup INTEGER NOT NULL DEFAULT 1,

allow_guest INTEGER NOT NULL DEFAULT 1,

extra_capacity INTEGER NOT NULL DEFAULT 0,

notes TEXT,

created_at TEXT NOT NULL,

updated_at TEXT NOT NULL,

is_deleted INTEGER NOT NULL DEFAULT 0

);
''';


static const String createAttendanceTable = '''
CREATE TABLE ${Tables.attendance} (

id TEXT PRIMARY KEY,

session_id TEXT NOT NULL,

athlete_id TEXT NOT NULL,

attendance_type TEXT NOT NULL,

status TEXT NOT NULL,

note TEXT,

created_at TEXT NOT NULL,

updated_at TEXT NOT NULL,


FOREIGN KEY (session_id)
REFERENCES sessions(id),


FOREIGN KEY (athlete_id)
REFERENCES athletes(id)

);
''';

static const String createIndexes = '''

CREATE INDEX idx_sessions_date
ON sessions(date);

CREATE INDEX idx_attendance_session
ON attendance(session_id);

''';

static const String createSessionMembersTable = '''
CREATE TABLE ${Tables.sessionMembers} (

id TEXT PRIMARY KEY,

session_id TEXT NOT NULL,

athlete_id TEXT NOT NULL,

member_type TEXT NOT NULL,

is_active INTEGER NOT NULL DEFAULT 1,

joined_at TEXT NOT NULL,

left_at TEXT,

note TEXT,

created_at TEXT NOT NULL,

updated_at TEXT NOT NULL,

is_deleted INTEGER NOT NULL DEFAULT 0,

FOREIGN KEY(session_id)
REFERENCES sessions(id),

FOREIGN KEY(athlete_id)
REFERENCES athletes(id),

UNIQUE(session_id, athlete_id)

);
''';

}