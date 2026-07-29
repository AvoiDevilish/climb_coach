class Athlete {
  final String? id;

  final String firstName;
  final String lastName;

  final DateTime? createdAt;
  final DateTime? updatedAt;

  final bool isDeleted;

  Athlete({
    this.id,
    required this.firstName,
    required this.lastName,
    this.createdAt,
    this.updatedAt,
    this.isDeleted = false,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'first_name': firstName,
      'last_name': lastName,
      'created_at':
          (createdAt ?? DateTime.now()).toIso8601String(),
      'updated_at':
          (updatedAt ?? DateTime.now()).toIso8601String(),
      'is_deleted': isDeleted ? 1 : 0,
    };
  }

  factory Athlete.fromMap(Map<String, dynamic> map) {
    return Athlete(
      id: map['id']?.toString(),
      firstName: map['first_name'] ?? '',
      lastName: map['last_name'] ?? '',
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