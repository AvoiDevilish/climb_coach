import 'package:flutter/foundation.dart';

import '../../data/repositories/assessment_repository.dart';
import '../../domain/models/assessment.dart';
import '../../domain/models/assessment_item.dart';
import '../../domain/models/result/assessment_result.dart';



class AssessmentExecutionController
    extends ChangeNotifier {

  final AssessmentRepository repository =
      AssessmentRepository();

  String? athleteId;


  late Assessment assessment;


  List<AssessmentItem> items = [];


  int currentIndex = 0;


  final Map<String, dynamic> values = {};


  void initialize(
    Assessment assessment, {
    String? athleteId,
  }) {

    this.assessment = assessment;

    this.athleteId = athleteId;


    final assessmentId =
        assessment.id;

    if (assessmentId == null) {

      items = [];

      notifyListeners();

      return;
    }


    items =
        repository.getItems(
          assessmentId,
        );


    currentIndex = 0;

    values.clear();


    notifyListeners();

  }


  AssessmentItem? get currentItem {

    if (items.isEmpty) {
      return null;
    }


    return items[currentIndex];

  }


  bool get hasNext {

    return currentIndex < items.length - 1;

  }


  void setValue(
    String key,
    dynamic value,
  ) {

    values[key] = value;


    notifyListeners();

  }


  void next() {

    if (!hasNext) {
      return;
    }


    currentIndex++;


    notifyListeners();

  }


  AssessmentResult? buildResult() {

    final assessmentId =
        assessment.id;


    if (assessmentId == null) {
      return null;
    }


    return AssessmentResult(

      assessmentId:
          assessmentId,

      athleteId:
          athleteId,

      createdAt:
          DateTime.now(),

      values:
          Map<String, dynamic>.from(
            values,
          ),

    );

  }

}