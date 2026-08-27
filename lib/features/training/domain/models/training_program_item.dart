class TrainingProgramItem {
  final String id;
  final String programId;
  final String movementId;
  final int sets;
  final int? reps;
  final int? seconds;
  final int restSeconds;
  final int displayOrder;

  const TrainingProgramItem({
    required this.id,
    required this.programId,
    required this.movementId,
    this.sets = 1,
    this.reps,
    this.seconds,
    this.restSeconds = 60,
    this.displayOrder = 0,
  });

  factory TrainingProgramItem.fromMap(Map<String, dynamic> map) => TrainingProgramItem(
        id: map['id'].toString(),
        programId: map['program_id'].toString(),
        movementId: map['movement_id'].toString(),
        sets: (map['sets'] as num?)?.toInt() ?? 1,
        reps: (map['reps'] as num?)?.toInt(),
        seconds: (map['seconds'] as num?)?.toInt(),
        restSeconds: (map['rest_seconds'] as num?)?.toInt() ?? 60,
        displayOrder: (map['display_order'] as num?)?.toInt() ?? 0,
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'program_id': programId,
        'movement_id': movementId,
        'sets': sets,
        'reps': reps,
        'seconds': seconds,
        'rest_seconds': restSeconds,
        'display_order': displayOrder,
      };
}
