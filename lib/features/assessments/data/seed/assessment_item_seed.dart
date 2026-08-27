import '../../domain/models/assessment_item.dart';

class AssessmentItemSeed {
  static const List<AssessmentItem> items = [
    AssessmentItem(
      id: 'item_pullup',
      assessmentId: 'assessment_strength_basic',
      movementId: 'pull_up',
      displayOrder: 1,
    ),
    AssessmentItem(
      id: 'item_hang',
      assessmentId: 'assessment_strength_basic',
      movementId: 'dead_hang',
      displayOrder: 2,
    ),
    AssessmentItem(
      id: 'item_campus',
      assessmentId: 'assessment_strength_basic',
      movementId: 'campus_ladder',
      displayOrder: 3,
    ),
  ];
}