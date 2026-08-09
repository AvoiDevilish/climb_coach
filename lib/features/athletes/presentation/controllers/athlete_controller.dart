import 'package:flutter/foundation.dart';

import '../../data/repositories/athlete_repository.dart';
import '../../domain/models/athlete.dart';

class AthleteController extends ChangeNotifier {
  final AthleteRepository _repository = AthleteRepository();

  List<Athlete> _athletes = [];

  List<Athlete> get athletes => _athletes;

  Future<void> loadAthletes() async {
    _athletes = await _repository.getAllAthletes();
    notifyListeners();
  }

  Future<void> addAthlete(Athlete athlete) async {
    await _repository.insertAthlete(athlete);
    await loadAthletes();
  }

  Future<bool> athleteExists(
    String firstName,
    String lastName,
  ) async {
    return await _repository.athleteExists(
      firstName,
      lastName,
    );
  }

  Future<Athlete?> getAthlete(String id) async {
    return _repository.getAthlete(id);
  }


  Future<void> updateAthlete(Athlete athlete) async {

    debugPrint(
      'UPDATE ATHLETE ID: ${athlete.id}',
    );

    debugPrint(
      'UPDATE IMAGE: ${athlete.profileImage}',
    );


    final result =
        await _repository.updateAthlete(
          athlete,
        );

    debugPrint(
      'UPDATE ATHLETE ID: ${athlete.id}',
    );

    debugPrint(
      'UPDATE RESULT ROWS: $result',
    );


    await loadAthletes();
  }
}