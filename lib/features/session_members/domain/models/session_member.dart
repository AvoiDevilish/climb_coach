class SessionMember {

  final String? id;

  final String sessionId;

  final String athleteId;

  final String memberType;

  final bool isActive;

  final DateTime? joinedAt;

  final DateTime? leftAt;

  final String? note;

  final DateTime? createdAt;

  final DateTime? updatedAt;

  final bool isDeleted;

  const SessionMember({
    this.id,
    required this.sessionId,
    required this.athleteId,
    this.memberType = 'NORMAL',
    this.isActive = true,
    this.joinedAt,
    this.leftAt,
    this.note,
    this.createdAt,
    this.updatedAt,
    this.isDeleted = false,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'session_id': sessionId,
      'athlete_id': athleteId,
      'member_type': memberType,
      'is_active': isActive ? 1 : 0,
      'joined_at':
          (joinedAt ?? DateTime.now()).toIso8601String(),
      'left_at':
          leftAt?.toIso8601String(),
      'note': note,
      'created_at':
          (createdAt ?? DateTime.now()).toIso8601String(),
      'updated_at':
          (updatedAt ?? DateTime.now()).toIso8601String(),
      'is_deleted': isDeleted ? 1 : 0,
    };
  }

  factory SessionMember.fromMap(
    Map<String, dynamic> map,
  ) {
    return SessionMember(
      id: map['id']?.toString(),
      sessionId: map['session_id'],
      athleteId: map['athlete_id'],
      memberType: map['member_type'] ?? 'NORMAL',
      isActive: (map['is_active'] ?? 1) == 1,
      joinedAt: map['joined_at'] != null
          ? DateTime.parse(map['joined_at'])
          : null,
      leftAt: map['left_at'] != null
          ? DateTime.parse(map['left_at'])
          : null,
      note: map['note'],
      createdAt: map['created_at'] != null
          ? DateTime.parse(map['created_at'])
          : null,
      updatedAt: map['updated_at'] != null
          ? DateTime.parse(map['updated_at'])
          : null,
      isDeleted: (map['is_deleted'] ?? 0) == 1,
    );
  }
}