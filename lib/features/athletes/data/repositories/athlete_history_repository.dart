import 'package:climb_coach/core/database/database_helper.dart';
import 'package:climb_coach/core/database/tables.dart';

import '../../domain/models/athlete_history_item.dart';

class AthleteHistoryRepository {
  Future<List<AthleteHistoryItem>> getHistory(
    String athleteId,
  ) async {
    final db = await DatabaseHelper.instance.database;

    final result = await db.rawQuery(
      '''
      SELECT
        s.id AS session_id,
        s.title AS session_title,
        s.date AS session_date,
        s.start_time AS session_start_time,
        s.end_time AS session_end_time,
        s.weekday AS session_weekday,

        sm.member_type AS member_type,
        sm.note AS membership_note,
        sm.joined_at AS joined_at,

        a.attendance_type AS attendance_type,
        a.status AS attendance_status,
        a.note AS attendance_note

      FROM ${Tables.sessionMembers} sm

      INNER JOIN ${Tables.sessions} s
        ON s.id = sm.session_id

      LEFT JOIN ${Tables.attendance} a
        ON a.session_id = sm.session_id
        AND a.athlete_id = sm.athlete_id

      WHERE sm.athlete_id = ?
        AND sm.is_deleted = 0
        AND s.is_deleted = 0

      ORDER BY
        CASE
          WHEN s.date IS NULL OR TRIM(s.date) = '' THEN 1
          ELSE 0
        END ASC,
        s.date DESC,
        s.start_time DESC
      ''',
      [athleteId],
    );

    return result.map(
      (row) {
        return AthleteHistoryItem(
          sessionId:
              row['session_id']?.toString() ?? '',

          sessionTitle:
              row['session_title']?.toString() ?? '',

          date:
              row['session_date']?.toString() ?? '',

          startTime:
              row['session_start_time']?.toString() ?? '',

          endTime:
              row['session_end_time']?.toString() ?? '',

          weekday: row['session_weekday'] == null
              ? null
              : int.tryParse(
                  row['session_weekday'].toString(),
                ),

          memberType:
              row['member_type']?.toString() ?? '',

          membershipNote:
              row['membership_note']?.toString(),

          attendanceType:
              row['attendance_type']?.toString(),

          attendanceStatus:
              row['attendance_status']?.toString(),

          attendanceNote:
              row['attendance_note']?.toString(),

          joinedAt:
              row['joined_at'] != null
                  ? DateTime.tryParse(
                      row['joined_at'].toString(),
                    )
                  : null,
        );
      },
    ).toList();
  }
}