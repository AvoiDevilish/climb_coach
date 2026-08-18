class MovementPerformance {
  final String? id;

  final String athleteId;
  final String movementId;
  final String? sessionId;

  final double value;
  final String unit;

  final String? note;

  final DateTime recordedAt;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  final bool isDeleted;

  const MovementPerformance({
    this.id,
    required this.athleteId,
    required this.movementId,
    this.sessionId,
    required this.value,
    required this.unit,
    this.note,
    required this.recordedAt,
    this.createdAt,
    this.updatedAt,
    this.isDeleted = false,
  });

  Map<String, dynamic> toMap() {
    final now = DateTime.now();

    return {
      'id': id,
      'athlete_id': athleteId,
      'movement_id': movementId,
      'session_id': sessionId,
      'value': value,
      'unit': unit,
      'note': note,
      'recorded_at': recordedAt.toIso8601String(),
      'created_at':
          (createdAt ?? now).toIso8601String(),
      'updated_at':
          (updatedAt ?? now).toIso8601String(),
      'is_deleted': isDeleted ? 1 : 0,
    };
  }

  factory MovementPerformance.fromMap(
    Map<String, dynamic> map,
  ) {
    return MovementPerformance(
      id: map['id']?.toString(),
      athleteId:
          map['athlete_id']?.toString() ?? '',
      movementId:
          map['movement_id']?.toString() ?? '',
      sessionId:
          map['session_id']?.toString(),
      value: map['value'] == null
          ? 0
          : (map['value'] as num).toDouble(),
      unit:
          map['unit']?.toString() ?? '',
      note:
          map['note']?.toString(),
      recordedAt:
          DateTime.parse(
        map['recorded_at'].toString(),
      ),
      createdAt:
          map['created_at'] != null
              ? DateTime.parse(
                  map['created_at'].toString(),
                )
              : null,
      updatedAt:
          map['updated_at'] != null
              ? DateTime.parse(
                  map['updated_at'].toString(),
                )
              : null,
      isDeleted:
          (map['is_deleted'] ?? 0) == 1,
    );
  }
}
