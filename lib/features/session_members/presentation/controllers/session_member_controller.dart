import 'package:flutter/foundation.dart';

import '../../data/repositories/session_member_repository.dart';
import '../../domain/models/session_member.dart';
import '../../domain/models/session_member_detail.dart';

class SessionMemberController extends ChangeNotifier {

  final SessionMemberRepository repository =
      SessionMemberRepository();


  List<SessionMemberDetail> members = [];



  Future loadMembers(
    String sessionId,
  ) async {

    members =
        await repository.getMemberDetailsOfSession(
          sessionId,
        );


    notifyListeners();

  }





  Future addMember(
    SessionMember member,
  ) async {

    await repository.insertMember(
      member,
    );


    await loadMembers(
      member.sessionId,
    );

  }





  Future removeMember(
    SessionMember member,
  ) async {

    if (member.id == null) return;


    await repository.removeMember(
      member.id!,
    );


    await loadMembers(
      member.sessionId,
    );

  }

}