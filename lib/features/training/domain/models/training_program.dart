class TrainingProgram {
  final String id;
  final String title;
  final String description;
  final String type;
  final bool isSystem;
  final bool isDeleted;

  const TrainingProgram({
    required this.id,
    required this.title,
    required this.description,
    required this.type,
    this.isSystem = false,
    this.isDeleted = false,
  });

  factory TrainingProgram.fromMap(Map<String, dynamic> map) => TrainingProgram(
        id: map['id'].toString(),
        title: map['title']?.toString() ?? '',
        description: map['description']?.toString() ?? '',
        type: map['type']?.toString() ?? 'strength',
        isSystem: (map['is_system'] ?? 0) == 1,
        isDeleted: (map['is_deleted'] ?? 0) == 1,
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'title': title,
        'description': description,
        'type': type,
        'is_system': isSystem ? 1 : 0,
        'is_deleted': isDeleted ? 1 : 0,
      };
}
