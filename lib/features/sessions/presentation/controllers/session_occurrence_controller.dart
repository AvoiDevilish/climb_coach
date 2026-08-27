import 'package:flutter/foundation.dart';

import '../../data/repositories/session_occurrence_repository.dart';
import '../../domain/models/session.dart';
import '../../domain/models/session_occurrence.dart';
import '../../domain/services/session_occurrence_generator.dart';

class SessionOccurrenceController extends ChangeNotifier {
  final SessionOccurrenceRepository _repository =
      SessionOccurrenceRepository();

  List<SessionOccurrence> _occurrences = [];

  List<SessionOccurrence> get occurrences =>
      _occurrences;

  Future<void> loadOccurrences(
    String sessionId,
  ) async {
    _occurrences =
        await _repository.getOccurrencesOfSession(
      sessionId,
    );

    notifyListeners();
  }

  Future<void> ensureOccurrencesForRange(
    Session session, {
    required DateTime from,
    required DateTime to,
  }) async {
    if (session.id == null) {
      return;
    }

    final generated =
        SessionOccurrenceGenerator.generate(
      session,
      from: from,
      to: to,
    );

    await _repository.insertGeneratedOccurrences(
      generated,
    );

    await loadOccurrences(
      session.id!,
    );
  }

  Future<void> ensureNextSevenDays(
    Session session,
  ) async {
    final now = DateTime.now();

    final from = DateTime(
      now.year,
      now.month,
      now.day,
    );

    final to = from.add(
      const Duration(days: 6),
    );

    await ensureOccurrencesForRange(
      session,
      from: from,
      to: to,
    );
  }

  Future<void> ensureCurrentWeek(
    Session session,
  ) async {
    final occurrences =
        SessionOccurrenceGenerator
            .generateCurrentWeek(
      session,
    );

    await _repository.insertGeneratedOccurrences(
      occurrences,
    );

    if (session.id != null) {
      await loadOccurrences(
        session.id!,
      );
    }
  }

  Future<void> ensureCurrentMonth(
    Session session,
  ) async {
    final occurrences =
        SessionOccurrenceGenerator
            .generateCurrentJalaliMonth(
      session,
    );

    await _repository.insertGeneratedOccurrences(
      occurrences,
    );

    if (session.id != null) {
      await loadOccurrences(
        session.id!,
      );
    }
  }
}
