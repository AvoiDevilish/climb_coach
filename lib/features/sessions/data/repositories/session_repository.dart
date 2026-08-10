import 'package:climb_coach/core/database/database_helper.dart';
import 'package:climb_coach/core/database/tables.dart';

import '../../domain/models/session.dart';


class SessionRepository {


  Future<int> insertSession(
    Session session,
  ) async {

    final db =
        await DatabaseHelper.instance.database;


    return db.insert(
      Tables.sessions,
      session.toMap(),
    );
  }



  Future<List<Session>> getAllSessions() async {

    final db =
        await DatabaseHelper.instance.database;


    final result =
        await db.query(
          Tables.sessions,

          where: 'is_deleted = ?',

          whereArgs: [0],

          orderBy:
              'date ASC, start_time ASC',
        );


    return result
        .map(
          (e) => Session.fromMap(e),
        )
        .toList();

  }



  Future<Session?> getSession(
    String id,
  ) async {

    final db =
        await DatabaseHelper.instance.database;


    final result =
        await db.query(
          Tables.sessions,

          where:
              'id = ?',

          whereArgs:
              [id],

          limit:
              1,
        );


    if (result.isEmpty) {
      return null;
    }


    return Session.fromMap(
      result.first,
    );
  }




  Future<int> updateSession(
    Session session,
  ) async {

    final db =
        await DatabaseHelper.instance.database;


    final data =
        session.toMap();


    data.remove('id');


    return db.update(

      Tables.sessions,

      data,

      where:
          'id = ?',

      whereArgs:
          [session.id],

    );
  }




  Future<int> deleteSession(
    String id,
  ) async {

    final db =
        await DatabaseHelper.instance.database;


    return db.update(

      Tables.sessions,

      {
        'is_deleted': 1,
        'updated_at': DateTime.now().toIso8601String(),
      },

      where:
          'id = ?',

      whereArgs:
          [id],

    );
  }

}