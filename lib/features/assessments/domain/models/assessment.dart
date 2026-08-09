class Assessment {
  final String? id;

  final String title;

  final String description;

  final bool isSystem;

  final bool isDeleted;

  const Assessment({
    this.id,
    required this.title,
    required this.description,
    this.isSystem = true,
    this.isDeleted = false,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'is_system': isSystem ? 1 : 0,
      'is_deleted': isDeleted ? 1 : 0,
    };
  }

  factory Assessment.fromMap(
    Map<String, dynamic> map,
  ) {
    return Assessment(
      id: map['id']?.toString(),
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      isSystem: (map['is_system'] ?? 1) == 1,
      isDeleted: (map['is_deleted'] ?? 0) == 1,
    );
  }
}