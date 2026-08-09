import 'package:climb_coach/core/database/database_helper.dart';
import 'package:climb_coach/core/database/tables.dart';

import '../../domain/models/session_summary.dart';


class SessionSummaryRepository {


  Future<SessionSummary?> getSummary(
    String sessionId,
  ) async {


    final db =
        await DatabaseHelper.instance.database;



    final sessionResult =
        await db.query(

          Tables.sessions,

          columns: [
            'capacity',
          ],

          where:
              'id = ?',

          whereArgs:
              [
                sessionId,
              ],

          limit:
              1,

        );



    if (sessionResult.isEmpty) {
      return null;
    }



    final capacity =
        sessionResult.first['capacity'] as int;



    final memberResult =
        await db.rawQuery(

          '''
          SELECT COUNT(*) as count

          FROM ${Tables.sessionMembers}

          WHERE session_id = ?

          AND is_deleted = 0

          AND is_active = 1
          ''',

          [
            sessionId,
          ],

        );



    final activeMembers =
        memberResult.first['count'] as int;



    return SessionSummary(

      capacity:
          capacity,

      activeMembers:
          activeMembers,

    );


  }

}