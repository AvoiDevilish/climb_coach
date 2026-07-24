import 'tables.dart';

class CreateTables {
  static const String createAthletesTable = '''
CREATE TABLE ${Tables.athletes} (

id TEXT PRIMARY KEY,

full_name TEXT NOT NULL,

created_at TEXT NOT NULL,

updated_at TEXT NOT NULL,

is_deleted INTEGER NOT NULL DEFAULT 0

);
''';
}
