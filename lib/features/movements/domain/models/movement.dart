class Movement {
  final String? id;

  /// شناسه دسته‌بندی
  final String categoryId;

  /// نام نمایشی حرکت
  final String name;

  /// ناحیه کلی بدن درگیر
  final String bodyRegion;

  /// نوع معیار ثبت:
  /// reps / time / weight / distance / angle
  final String measurementType;

  /// واحد نمایش معیار:
  /// rep / sec / kg / m / degree
  final String measurementUnit;

  /// عضلات اصلی درگیر
  final List<String> primaryMuscles;

  final bool isCorrective;
  final List<String> injuryAreas;

  final bool isSystem;
  final bool isDeleted;

  const Movement({
    this.id,
    required this.categoryId,
    required this.name,
    required this.bodyRegion,
    required this.measurementType,
    required this.measurementUnit,
    required this.primaryMuscles,
    this.isCorrective = false,
    this.injuryAreas = const [],
    this.isSystem = true,
    this.isDeleted = false,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'category_id': categoryId,
      'name': name,
      'body_region': bodyRegion,
      'measurement_type': measurementType,
      'measurement_unit': measurementUnit,
      'primary_muscles': primaryMuscles.join(','),
      'is_corrective': isCorrective ? 1 : 0,
      'injury_areas': injuryAreas.join(','),
      'is_system': isSystem ? 1 : 0,
      'is_deleted': isDeleted ? 1 : 0,
    };
  }

  factory Movement.fromMap(
    Map<String, dynamic> map,
  ) {
    final musclesValue = map['primary_muscles'];

    return Movement(
      id: map['id']?.toString(),

      categoryId:
          map['category_id']?.toString() ?? '',

      name:
          map['name']?.toString() ?? '',

      bodyRegion:
          map['body_region']?.toString() ?? '',

      measurementType:
          map['measurement_type']?.toString() ?? '',

      measurementUnit:
          map['measurement_unit']?.toString() ?? '',

      primaryMuscles:
          musclesValue is String
              ? musclesValue
                  .split(',')
                  .map(
                    (e) => e.trim(),
                  )
                  .where(
                    (e) => e.isNotEmpty,
                  )
                  .toList()
              : const [],

      isCorrective: (map['is_corrective'] ?? 0) == 1,
      injuryAreas: (map['injury_areas']?.toString() ?? '')
          .split(',')
          .map((e) => e.trim())
          .where((e) => e.isNotEmpty)
          .toList(),

      isSystem:
          (map['is_system'] ?? 1) == 1,

      isDeleted:
          (map['is_deleted'] ?? 0) == 1,
    );
  }
}