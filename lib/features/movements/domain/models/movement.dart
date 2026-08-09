class Movement {
  final String? id;

  final String categoryId;

  final String title;

  final String recordType;

  final String unit;

  final bool isSystem;

  final bool isDeleted;

  const Movement({
    this.id,
    required this.categoryId,
    required this.title,
    required this.recordType,
    required this.unit,
    this.isSystem = true,
    this.isDeleted = false,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'category_id': categoryId,
      'title': title,
      'record_type': recordType,
      'unit': unit,
      'is_system': isSystem ? 1 : 0,
      'is_deleted': isDeleted ? 1 : 0,
    };
  }

  factory Movement.fromMap(Map<String, dynamic> map) {
    return Movement(
      id: map['id']?.toString(),
      categoryId: map['category_id'] ?? '',
      title: map['title'] ?? '',
      recordType: map['record_type'] ?? '',
      unit: map['unit'] ?? '',
      isSystem: (map['is_system'] ?? 1) == 1,
      isDeleted: (map['is_deleted'] ?? 0) == 1,
    );
  }
}