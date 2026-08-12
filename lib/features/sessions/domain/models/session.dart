class Session {
  final String? id;

  final String title;

  final String? club;

  final String? coachId;

  final String date;

  final String startTime;

  final String endTime;

  final int capacity;

  final bool allowMakeup;

  final bool allowGuest;

  final int extraCapacity;

  final String? notes;

  final DateTime? createdAt;

  final DateTime? updatedAt;

  final bool isDeleted;

  final bool isRecurring;

  final int? weekday;


  Session({
    this.id,

    required this.title,

    this.club,

    this.coachId,

    required this.date,

    required this.startTime,

    required this.endTime,

    required this.capacity,

    this.allowMakeup = true,

    this.allowGuest = true,

    this.extraCapacity = 0,

    this.notes,

    this.createdAt,

    this.updatedAt,

    this.isDeleted = false,

    this.isRecurring = false,

    this.weekday,

  });


  Map<String, dynamic> toMap() {

    return {

      'id': id ?? DateTime.now()
          .millisecondsSinceEpoch
          .toString(),
  
      'title': title,

      'club': club,

      'coach_id': coachId,

      'date': date,

      'start_time': startTime,

      'end_time': endTime,

      'capacity': capacity,

      'allow_makeup': allowMakeup ? 1 : 0,

      'allow_guest': allowGuest ? 1 : 0,

      'extra_capacity': extraCapacity,

      'notes': notes,

      'created_at':
          (createdAt ?? DateTime.now())
              .toIso8601String(),

      'updated_at':
          (updatedAt ?? DateTime.now())
              .toIso8601String(),

      'is_deleted':
          isDeleted ? 1 : 0,

      'is_recurring':
          isRecurring ? 1 : 0,

      'weekday':
          weekday,

    };
  }


  factory Session.fromMap(
    Map<String, dynamic> map,
  ) {

    return Session(

      id: map['id']?.toString(),

      title: map['title'] ?? '',

      club: map['club'],

      coachId: map['coach_id'],

      date: map['date'] ?? '',

      startTime:
          map['start_time'] ?? '',

      endTime:
          map['end_time'] ?? '',

      capacity:
          map['capacity'] ?? 0,

      allowMakeup:
          (map['allow_makeup'] ?? 0) == 1,

      allowGuest:
          (map['allow_guest'] ?? 0) == 1,

      extraCapacity:
          map['extra_capacity'] ?? 0,

      notes:
          map['notes'],

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

      isDeleted:
          (map['is_deleted'] ?? 0) == 1,

      isRecurring:
          (map['is_recurring'] ?? 0) == 1,


      weekday:
          map['weekday'],

    );
  }
}