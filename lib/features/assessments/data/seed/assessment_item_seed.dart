import '../../domain/models/assessment_item.dart';

class AssessmentItemSeed {

  static const List<AssessmentItem> items = [

    AssessmentItem(
      id: "item_pullup",
      assessmentId: "assessment_strength_basic",
      movementId: "movement_pullup",
      displayOrder: 1,
    ),

    AssessmentItem(
      id: "item_hang",
      assessmentId: "assessment_strength_basic",
      movementId: "movement_hang",
      displayOrder: 2,
    ),

    AssessmentItem(
      id: "item_campus",
      assessmentId: "assessment_strength_basic",
      movementId: "movement_campus",
      displayOrder: 3,
    ),

  ];

}