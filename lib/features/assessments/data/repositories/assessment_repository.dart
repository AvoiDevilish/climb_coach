import '../../domain/models/assessment.dart';
import '../../domain/models/assessment_item.dart';

import '../seed/assessment_seed.dart';
import '../seed/assessment_item_seed.dart';

class AssessmentRepository {

  List<Assessment> getAllAssessments() {
    return AssessmentSeed.assessments;
  }

  Assessment? getById(String id) {
    try {
      return AssessmentSeed.assessments.firstWhere(
        (a) => a.id == id,
      );
    } catch (_) {
      return null;
    }
  }

  List<AssessmentItem> getItems(
    String assessmentId,
  ) {
    return AssessmentItemSeed.items
        .where(
          (item) =>
              item.assessmentId == assessmentId,
        )
        .toList()
      ..sort(
        (a, b) =>
            a.displayOrder.compareTo(
              b.displayOrder,
            ),
      );
  }
}