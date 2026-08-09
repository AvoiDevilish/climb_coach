class MovementCategory {
  final String? id;

  final String title;

  final String icon;

  final int displayOrder;

  const MovementCategory({
    this.id,
    required this.title,
    required this.icon,
    required this.displayOrder,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'icon': icon,
      'display_order': displayOrder,
    };
  }

  factory MovementCategory.fromMap(
    Map<String, dynamic> map,
  ) {
    return MovementCategory(
      id: map['id']?.toString(),
      title: map['title'] ?? '',
      icon: map['icon'] ?? '',
      displayOrder: map['display_order'] ?? 0,
    );
  }
}