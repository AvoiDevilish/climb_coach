class AthleteTrainingAssignment {
  final String id;
  final String athleteId;
  final String assignmentType; // program / movement
  final String? programId;
  final String? movementId;
  final int? sets;
  final int? reps;
  final int? seconds;
  final DateTime assignedAt;
  final DateTime? startDate;
  final DateTime? endDate;
  final String status; // active / completed / cancelled
  final String? note;

  const AthleteTrainingAssignment({
    required this.id,
    required this.athleteId,
    required this.assignmentType,
    this.programId,
    this.movementId,
    this.sets,
    this.reps,
    this.seconds,
    required this.assignedAt,
    this.startDate,
    this.endDate,
    this.status = 'active',
    this.note,
  });

  factory AthleteTrainingAssignment.fromMap(Map<String, dynamic> map) => AthleteTrainingAssignment(
        id: map['id'].toString(),
        athleteId: map['athlete_id'].toString(),
        assignmentType: map['assignment_type'].toString(),
        programId: map['program_id']?.toString(),
        movementId: map['movement_id']?.toString(),
        sets: (map['sets'] as num?)?.toInt(),
        reps: (map['reps'] as num?)?.toInt(),
        seconds: (map['seconds'] as num?)?.toInt(),
        assignedAt: DateTime.tryParse(map['assigned_at'].toString()) ?? DateTime.now(),
        startDate: map['start_date'] == null ? null : DateTime.tryParse(map['start_date'].toString()),
        endDate: map['end_date'] == null ? null : DateTime.tryParse(map['end_date'].toString()),
        status: map['status']?.toString() ?? 'active',
        note: map['note']?.toString(),
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'athlete_id': athleteId,
        'assignment_type': assignmentType,
        'program_id': programId,
        'movement_id': movementId,
        'sets': sets,
        'reps': reps,
        'seconds': seconds,
        'assigned_at': assignedAt.toIso8601String(),
        'start_date': startDate?.toIso8601String(),
        'end_date': endDate?.toIso8601String(),
        'status': status,
        'note': note,
      };
}
