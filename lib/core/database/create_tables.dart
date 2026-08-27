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

is_deleted INTEGER NOT NULL DEFAULT 0,

health_status TEXT NOT NULL DEFAULT 'healthy',

injury_areas TEXT,

injury_since TEXT,

recovery_until TEXT

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

is_corrective INTEGER NOT NULL DEFAULT 0,

injury_areas TEXT,

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

static const String createSessionOccurrencesTable = '''
CREATE TABLE ${Tables.sessionOccurrences} (

id TEXT PRIMARY KEY,

session_id TEXT NOT NULL,

occurrence_date TEXT NOT NULL,

start_time TEXT NOT NULL,

end_time TEXT NOT NULL,

status TEXT NOT NULL DEFAULT 'scheduled',

notes TEXT,

created_at TEXT NOT NULL,

updated_at TEXT NOT NULL,

is_deleted INTEGER NOT NULL DEFAULT 0,

FOREIGN KEY(session_id)
REFERENCES sessions(id),

UNIQUE(session_id, occurrence_date)

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

CREATE INDEX idx_attendance_athlete
ON attendance(athlete_id);

CREATE INDEX idx_session_members_athlete
ON session_members(athlete_id);

CREATE INDEX idx_movement_performances_athlete
ON movement_performances(athlete_id);

CREATE INDEX idx_movement_performances_movement
ON movement_performances(movement_id);

CREATE INDEX idx_session_occurrences_session
ON session_occurrences(session_id);

CREATE INDEX idx_session_occurrences_date
ON session_occurrences(occurrence_date);

CREATE INDEX idx_session_occurrences_session_date
ON session_occurrences(session_id, occurrence_date);

CREATE INDEX idx_assessment_items_assessment
ON assessment_items(assessment_id);

CREATE INDEX idx_assessment_items_movement
ON assessment_items(movement_id);

CREATE INDEX idx_training_program_items_program
ON training_program_items(program_id);

CREATE INDEX idx_assignment_athlete
ON athlete_training_assignments(athlete_id);

CREATE INDEX idx_training_logs_athlete
ON training_logs(athlete_id);

CREATE INDEX idx_training_logs_movement
ON training_logs(movement_id);

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

static const String createMovementPerformancesTable = '''
CREATE TABLE ${Tables.movementPerformances} (

id TEXT PRIMARY KEY,

athlete_id TEXT NOT NULL,

movement_id TEXT NOT NULL,

session_id TEXT,

value REAL NOT NULL,

unit TEXT NOT NULL,

note TEXT,

recorded_at TEXT NOT NULL,

created_at TEXT NOT NULL,

updated_at TEXT NOT NULL,

is_deleted INTEGER NOT NULL DEFAULT 0,

FOREIGN KEY (athlete_id)
REFERENCES athletes(id),

FOREIGN KEY (movement_id)
REFERENCES movements(id),

FOREIGN KEY (session_id)
REFERENCES sessions(id)

);
''';

static const String createAssessmentsTable = '''
CREATE TABLE ${Tables.assessments} (

id TEXT PRIMARY KEY,

title TEXT NOT NULL,

description TEXT NOT NULL,

is_system INTEGER NOT NULL DEFAULT 1,

is_deleted INTEGER NOT NULL DEFAULT 0

);
''';

static const String createAssessmentItemsTable = '''
CREATE TABLE ${Tables.assessmentItems} (

id TEXT PRIMARY KEY,

assessment_id TEXT NOT NULL,

movement_id TEXT NOT NULL,

display_order INTEGER NOT NULL,

FOREIGN KEY (assessment_id)
REFERENCES ${Tables.assessments}(id),

FOREIGN KEY (movement_id)
REFERENCES ${Tables.movements}(id)

);
''';

static const String createAssessmentResultsTable = '''
CREATE TABLE ${Tables.assessmentResults} (

id TEXT PRIMARY KEY,

assessment_id TEXT NOT NULL,

athlete_id TEXT,

created_at TEXT NOT NULL,

values_json TEXT NOT NULL,

FOREIGN KEY (assessment_id)
REFERENCES ${Tables.assessments}(id),

FOREIGN KEY (athlete_id)
REFERENCES ${Tables.athletes}(id)

);
''';

static const String createTrainingProgramsTable = '''
CREATE TABLE ${Tables.trainingPrograms} (

id TEXT PRIMARY KEY,

title TEXT NOT NULL,

description TEXT NOT NULL,

type TEXT NOT NULL,

is_system INTEGER NOT NULL DEFAULT 0,

is_deleted INTEGER NOT NULL DEFAULT 0

);
''';

static const String createTrainingProgramItemsTable = '''
CREATE TABLE ${Tables.trainingProgramItems} (

id TEXT PRIMARY KEY,

program_id TEXT NOT NULL,

movement_id TEXT NOT NULL,

sets INTEGER NOT NULL DEFAULT 1,

reps INTEGER,

seconds INTEGER,

rest_seconds INTEGER NOT NULL DEFAULT 60,

display_order INTEGER NOT NULL DEFAULT 0,

FOREIGN KEY (program_id)
REFERENCES ${Tables.trainingPrograms}(id),

FOREIGN KEY (movement_id)
REFERENCES ${Tables.movements}(id)

);
''';

static const String createAthleteTrainingAssignmentsTable = '''
CREATE TABLE ${Tables.athleteTrainingAssignments} (

id TEXT PRIMARY KEY,

athlete_id TEXT NOT NULL,

assignment_type TEXT NOT NULL,

program_id TEXT,

movement_id TEXT,

sets INTEGER,

reps INTEGER,

seconds INTEGER,

assigned_at TEXT NOT NULL,

start_date TEXT,

end_date TEXT,

status TEXT NOT NULL DEFAULT 'active',

note TEXT,

FOREIGN KEY (athlete_id)
REFERENCES ${Tables.athletes}(id),

FOREIGN KEY (program_id)
REFERENCES ${Tables.trainingPrograms}(id),

FOREIGN KEY (movement_id)
REFERENCES ${Tables.movements}(id)

);
''';

static const String createTrainingLogsTable = '''
CREATE TABLE ${Tables.trainingLogs} (

id TEXT PRIMARY KEY,

assignment_id TEXT NOT NULL,

athlete_id TEXT NOT NULL,

movement_id TEXT NOT NULL,

value REAL,

unit TEXT,

sets_completed INTEGER,

reps_completed INTEGER,

duration_seconds INTEGER,

status TEXT NOT NULL DEFAULT 'completed',

note TEXT,

performed_at TEXT NOT NULL,

FOREIGN KEY (assignment_id)
REFERENCES ${Tables.athleteTrainingAssignments}(id),

FOREIGN KEY (athlete_id)
REFERENCES ${Tables.athletes}(id),

FOREIGN KEY (movement_id)
REFERENCES ${Tables.movements}(id)

);
''';

}