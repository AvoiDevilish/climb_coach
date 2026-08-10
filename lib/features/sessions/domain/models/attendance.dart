class Attendance {

  final String? id;

  final String sessionId;

  final String athleteId;

  final String attendanceType;

  final String status;

  final String? note;

  final DateTime? createdAt;

  final DateTime? updatedAt;


  Attendance({

    this.id,

    required this.sessionId,

    required this.athleteId,

    required this.attendanceType,

    required this.status,

    this.note,

    this.createdAt,

    this.updatedAt,

  });



  Map<String, dynamic> toMap() {

    return {

      'id': id,

      'session_id': sessionId,

      'athlete_id': athleteId,

      'attendance_type':
          attendanceType,

      'status':
          status,

      'note':
          note,

      'created_at':
          (createdAt ?? DateTime.now())
              .toIso8601String(),

      'updated_at':
          (updatedAt ?? DateTime.now())
              .toIso8601String(),

    };
  }



  factory Attendance.fromMap(
    Map<String, dynamic> map,
  ) {

    return Attendance(

      id: map['id']?.toString(),

      sessionId:
          map['session_id'] ?? '',

      athleteId:
          map['athlete_id'] ?? '',

      attendanceType:
          map['attendance_type'] ?? 'regular',

      status:
          map['status'] ?? 'pending',

      note:
          map['note'],

      createdAt:
          map['created_at'] != null
              ? DateTime.parse(
                  map['created_at'],
                )
              : null,

      updatedAt:
          map['updated_at'] != null
              ? DateTime.parse(
                  map['updated_at'],
                )
              : null,

    );
  }
}