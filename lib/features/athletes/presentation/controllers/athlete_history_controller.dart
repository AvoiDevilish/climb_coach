import 'package:flutter/foundation.dart';

import '../../data/repositories/athlete_history_repository.dart';
import '../../domain/models/athlete_history_item.dart';

class AthleteHistoryController extends ChangeNotifier {
  final AthleteHistoryRepository _repository =
      AthleteHistoryRepository();

  List<AthleteHistoryItem> _history = [];

  bool _loading = false;

  String? _error;

  List<AthleteHistoryItem> get history =>
      List.unmodifiable(_history);

  bool get loading => _loading;

  String? get error => _error;

  Future<void> loadHistory(
    String athleteId,
  ) async {
    if (athleteId.trim().isEmpty) {
      _history = [];
      _error = 'شناسه ورزشکار معتبر نیست';
      notifyListeners();
      return;
    }

    _loading = true;
    _error = null;

    notifyListeners();

    try {
      _history =
          await _repository.getHistory(
        athleteId,
      );
    } catch (e) {
      _history = [];
      _error =
          'بارگذاری تاریخچه ورزشکار ناموفق بود: $e';
    } finally {
      _loading = false;
      notifyListeners();
    }
  }

  void clear() {
    _history = [];
    _error = null;
    _loading = false;

    notifyListeners();
  }
}