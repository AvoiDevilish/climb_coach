import 'package:flutter/foundation.dart';

import '../../data/repositories/session_repository.dart';
import '../../domain/models/session.dart';


class SessionController extends ChangeNotifier {

  final SessionRepository _repository =
      SessionRepository();


  List<Session> _sessions = [];


  List<Session> get sessions => _sessions;



  Future<void> loadSessions() async {

    _sessions =
        await _repository.getAllSessions();

    notifyListeners();

  }



  Future<void> addSession(
    Session session,
  ) async {

    await _repository.insertSession(
      session,
    );


    await loadSessions();

  }



  Future<void> updateSession(
    Session session,
  ) async {

    await _repository.updateSession(
      session,
    );


    await loadSessions();

  }



  Future<void> deleteSession(
    String id,
  ) async {

    await _repository.deleteSession(
      id,
    );


    await loadSessions();

  }



  Future<Session?> getSession(
    String id,
  ) async {

    return _repository.getSession(id);

  }

}