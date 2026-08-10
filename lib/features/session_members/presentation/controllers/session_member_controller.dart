import 'package:flutter/foundation.dart';

import '../../data/repositories/session_member_repository.dart';
import '../../domain/models/session_member.dart';

class SessionMemberController extends ChangeNotifier {

  final SessionMemberRepository repository =
      SessionMemberRepository();

  List<SessionMember> members = [];

  Future<void> loadMembers(
    String sessionId,
  ) async {

    members =
        await repository.getMembersOfSession(
      sessionId,
    );

    notifyListeners();

  }

  Future<void> addMember(
    SessionMember member,
  ) async {

    await repository.insertMember(member);

    await loadMembers(member.sessionId);

  }

  Future<void> removeMember(
    SessionMember member,
  ) async {

    if (member.id == null) return;

    await repository.removeMember(
      member.id!,
    );

    await loadMembers(member.sessionId);

  }

}