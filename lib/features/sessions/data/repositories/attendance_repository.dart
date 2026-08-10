import 'package:climb_coach/core/database/database_helper.dart';
import 'package:climb_coach/core/database/tables.dart';

import '../../domain/models/attendance.dart';



class AttendanceRepository {


  Future<int> insertAttendance(
    Attendance attendance,
  ) async {

    final db =
        await DatabaseHelper.instance.database;


    return db.insert(
      Tables.attendance,
      attendance.toMap(),
    );

  }



  Future<List<Attendance>> getSessionAttendance(
    String sessionId,
  ) async {

    final db =
        await DatabaseHelper.instance.database;


    final result =
        await db.query(

          Tables.attendance,

          where:
              'session_id = ?',

          whereArgs:
              [sessionId],

        );


    return result
        .map(
          (e) =>
              Attendance.fromMap(e),
        )
        .toList();

  }



  Future<int> updateAttendance(
    Attendance attendance,
  ) async {

    final db =
        await DatabaseHelper.instance.database;


    final data =
        attendance.toMap();


    data.remove('id');


    return db.update(

      Tables.attendance,

      data,

      where:
          'id = ?',

      whereArgs:
          [attendance.id],

    );

  }

}