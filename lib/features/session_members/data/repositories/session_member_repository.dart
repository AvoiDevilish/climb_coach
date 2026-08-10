import 'package:climb_coach/core/database/database_helper.dart';
import 'package:climb_coach/core/database/tables.dart';

import '../../domain/models/session_member.dart';

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

}