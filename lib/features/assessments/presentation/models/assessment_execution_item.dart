import '../../../movements/domain/models/movement.dart';
import '../../domain/models/assessment_item.dart';

class AssessmentExecutionItem {
  final AssessmentItem item;
  final Movement movement;

  const AssessmentExecutionItem({
    required this.item,
    required this.movement,
  });
}