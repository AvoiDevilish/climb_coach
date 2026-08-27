class SessionOccurrence {
  final String? id;

  final String sessionId;

  final String occurrenceDate;

  final String startTime;

  final String endTime;

  final String status;

  final String? notes;

  final DateTime? createdAt;

  final DateTime? updatedAt;

  final bool isDeleted;

  const SessionOccurrence({
    this.id,
    required this.sessionId,
    required this.occurrenceDate,
    required this.startTime,
    required this.endTime,
    this.status = 'scheduled',
    this.notes,
    this.createdAt,
    this.updatedAt,
    this.isDeleted = false,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id ??
          '${sessionId}_$occurrenceDate',

      'session_id': sessionId,

      'occurrence_date':
          occurrenceDate,

      'start_time':
          startTime,

      'end_time':
          endTime,

      'status':
          status,

      'notes':
          notes,

      'created_at':
          (createdAt ?? DateTime.now())
              .toIso8601String(),

      'updated_at':
          (updatedAt ?? DateTime.now())
              .toIso8601String(),

      'is_deleted':
          isDeleted ? 1 : 0,
    };
  }

  factory SessionOccurrence.fromMap(
    Map<String, dynamic> map,
  ) {
    return SessionOccurrence(
      id: map['id']?.toString(),

      sessionId:
          map['session_id']?.toString() ?? '',

      occurrenceDate:
          map['occurrence_date']
                  ?.toString() ??
              '',

      startTime:
          map['start_time']?.toString() ??
              '',

      endTime:
          map['end_time']?.toString() ??
              '',

      status:
          map['status']?.toString() ??
              'scheduled',

      notes:
          map['notes']?.toString(),

      createdAt:
          map['created_at'] != null
              ? DateTime.parse(
                  map['created_at']
                      .toString(),
                )
              : null,

      updatedAt:
          map['updated_at'] != null
              ? DateTime.parse(
                  map['updated_at']
                      .toString(),
                )
              : null,

      isDeleted:
          (map['is_deleted'] ?? 0) == 1,
    );
  }
}