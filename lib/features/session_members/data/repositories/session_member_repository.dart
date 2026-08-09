import 'package:climb_coach/core/database/database_helper.dart';
import 'package:climb_coach/core/database/tables.dart';

import '../../domain/models/session_member_detail.dart';
import '../../domain/models/session_member.dart';
import '../../../sessions/domain/models/session_summary.dart';

class SessionMemberRepository {

  Future<int> insertMember(
    SessionMember member,
  ) async {

    final db =
        await DatabaseHelper.instance.database;

    return db.insert(
      Tables.sessionMembers,
      member.toMap(),
    );

  }

  Future<List<SessionMember>> getMembersOfSession(
    String sessionId,
  ) async {

    final db =
        await DatabaseHelper.instance.database;

    final result =
        await db.query(

      Tables.sessionMembers,

      where:
          'session_id = ? AND is_deleted = 0',

      whereArgs:
          [sessionId],

      orderBy:
          'joined_at ASC',

    );

    return result
        .map(
          (e) => SessionMember.fromMap(e),
        )
        .toList();

  }

    Future<List<SessionMemberDetail>> getMemberDetailsOfSession(
    String sessionId,
    ) async {

    final db =
        await DatabaseHelper.instance.database;


    final result = await db.rawQuery(
        '''

        SELECT

        sm.id,

        sm.athlete_id,

        a.first_name,

        a.last_name,

        sm.member_type,

        sm.is_active


        FROM ${Tables.sessionMembers} sm


        INNER JOIN ${Tables.athletes} a

        ON a.id = sm.athlete_id


        WHERE

        sm.session_id = ?

        AND sm.is_deleted = 0

        AND a.is_deleted = 0


        ORDER BY

        sm.joined_at ASC


        ''',

        [
        sessionId,
        ],

    );



    return result.map(

        (e) => SessionMemberDetail(

        id: e['id'].toString(),

        athleteId:
            e['athlete_id'].toString(),

        firstName:
            e['first_name']?.toString() ?? '',

        lastName:
            e['last_name']?.toString() ?? '',

        memberType:
            e['member_type']?.toString() ?? 'NORMAL',

        isActive:
            (e['is_active'] ?? 1) == 1,

        ),

    ).toList();

    }

  Future<int> updateMember(
    SessionMember member,
  ) async {

    final db =
        await DatabaseHelper.instance.database;

    final data =
        member.toMap();

    data.remove('id');

    return db.update(

      Tables.sessionMembers,

      data,

      where:
          'id = ?',

      whereArgs:
          [member.id],

    );

  }




  Future<int> removeMember(
    String id,
  ) async {

    final db =
        await DatabaseHelper.instance.database;

    return db.update(

      Tables.sessionMembers,

      {

        'is_deleted': 1,

        'updated_at':
            DateTime.now().toIso8601String(),

      },

      where:
          'id = ?',

      whereArgs:
          [id],

    );

  }

    Future<int> getActiveMemberCount(
    String sessionId,
    ) async {

    final db =
        await DatabaseHelper.instance.database;


    final result = await db.rawQuery(
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


    return result.first['count'] as int;
    }

    Future<SessionSummary> getSessionSummary(
    String sessionId,
    int capacity,
    ) async {

    final activeMembers =
        await getActiveMemberCount(
            sessionId,
        );


    return SessionSummary(

        capacity: capacity,

        activeMembers: activeMembers,

    );

    }

}