import 'package:flutter/foundation.dart';

import '../../data/repositories/attendance_repository.dart';
import '../../domain/models/attendance.dart';



class AttendanceController
    extends ChangeNotifier {


  final AttendanceRepository _repository =
      AttendanceRepository();



  List<Attendance> _attendance = [];



  List<Attendance> get attendance =>
      _attendance;




  Future<void> loadSessionAttendance(
    String sessionId,
  ) async {


    _attendance =
        await _repository
            .getSessionAttendance(
              sessionId,
            );


    notifyListeners();

  }





  Future<void> addAttendance(
    Attendance item,
  ) async {


    await _repository
        .insertAttendance(
          item,
        );


    await loadSessionAttendance(
      item.sessionId,
    );

  }




  Future<void> updateAttendance(
    Attendance item,
  ) async {


    await _repository
        .updateAttendance(
          item,
        );


    await loadSessionAttendance(
      item.sessionId,
    );

  }


}