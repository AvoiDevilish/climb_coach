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
}