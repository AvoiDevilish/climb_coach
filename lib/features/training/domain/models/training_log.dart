class TrainingLog {
  final String id;
  final String assignmentId;
  final String athleteId;
  final String movementId;
  final double? value;
  final String? unit;
  final int? setsCompleted;
  final int? repsCompleted;
  final int? durationSeconds;
  final String status;
  final String? note;
  final DateTime performedAt;

  const TrainingLog({
    required this.id,
    required this.assignmentId,
    required this.athleteId,
    required this.movementId,
    this.value,
    this.unit,
    this.setsCompleted,
    this.repsCompleted,
    this.durationSeconds,
    this.status = 'completed',
    this.note,
    required this.performedAt,
  });

  Map<String, dynamic> toMap() => {
        'id': id,
        'assignment_id': assignmentId,
        'athlete_id': athleteId,
        'movement_id': movementId,
        'value': value,
        'unit': unit,
        'sets_completed': setsCompleted,
        'reps_completed': repsCompleted,
        'duration_seconds': durationSeconds,
        'status': status,
        'note': note,
        'performed_at': performedAt.toIso8601String(),
      };
}
