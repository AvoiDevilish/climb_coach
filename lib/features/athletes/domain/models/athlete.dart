class Athlete {
  final String? id;

  final String firstName;
  final String lastName;

  final String? gender;
  final int? age;
  final double? height;
  final double? weight;

  final String? profileImage;

  final DateTime? createdAt;
  final DateTime? updatedAt;

  final bool isDeleted;

  Athlete({
    this.id,
    required this.firstName,
    required this.lastName,

    this.gender,
    this.age,
    this.height,
    this.weight,

    this.profileImage,

    this.createdAt,
    this.updatedAt,

    this.isDeleted = false,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'first_name': firstName,
      'last_name': lastName,

      'gender': gender,
      'age': age,
      'height': height,
      'weight': weight,

      'profile_image': profileImage,

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

      gender: map['gender'],

      age: map['age'],

      height: map['height'] == null
          ? null
          : (map['height'] as num).toDouble(),

      weight: map['weight'] == null
          ? null
          : (map['weight'] as num).toDouble(),

      profileImage: map['profile_image'],

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