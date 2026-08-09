import '../../data/repositories/assessment_repository.dart';
import '../../domain/models/assessment.dart';

class AssessmentController {

  final AssessmentRepository repository =
      AssessmentRepository();

  List<Assessment> get assessments =>
      repository.getAllAssessments();

}