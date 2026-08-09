class AssessmentItem {
  final String? id;

  final String assessmentId;

  final String movementId;

  final int displayOrder;

  const AssessmentItem({
    this.id,
    required this.assessmentId,
    required this.movementId,
    required this.displayOrder,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'assessment_id': assessmentId,
      'movement_id': movementId,
      'display_order': displayOrder,
    };
  }

  factory AssessmentItem.fromMap(
    Map<String, dynamic> map,
  ) {
    return AssessmentItem(
      id: map['id']?.toString(),
      assessmentId: map['assessment_id'] ?? '',
      movementId: map['movement_id'] ?? '',
      displayOrder: map['display_order'] ?? 0,
    );
  }
}