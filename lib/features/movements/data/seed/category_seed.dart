import '../../domain/models/movement_category.dart';

class CategorySeed {
  static const List<MovementCategory> categories = [
    MovementCategory(
      id: 'climbing',
      title: 'سنگ‌نوردی',
      icon: '🧗',
      displayOrder: 1,
    ),
    MovementCategory(
      id: 'strength',
      title: 'قدرت عمومی',
      icon: '🏋️',
      displayOrder: 2,
    ),
    MovementCategory(
      id: 'core',
      title: 'Core',
      icon: '🔥',
      displayOrder: 3,
    ),
    MovementCategory(
      id: 'mobility',
      title: 'انعطاف و Mobility',
      icon: '🤸',
      displayOrder: 4,
    ),
    MovementCategory(
      id: 'corrective',
      title: 'حرکات اصلاحی',
      icon: '🩹',
      displayOrder: 6,
    ),
    MovementCategory(
      id: 'cardio',
      title: 'هوازی',
      icon: '🏃',
      displayOrder: 5,
    ),
  ];
}