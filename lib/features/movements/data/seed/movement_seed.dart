import '../../domain/models/movement.dart';

class MovementSeed {
  static const List<Movement> movements = [
    // ============================================================
    // Climbing | سنگ‌نوردی
    // ============================================================

    Movement(
      id: 'dead_hang',
      category: 'climbing',
      name: 'Dead Hang',
      bodyRegion: 'ساعد و انگشتان',
      measurementType: 'time',
      measurementUnit: 'sec',
      primaryMuscles: [
        'Forearm',
        'Finger Flexors',
        'Grip',
      ],
    ),

    Movement(
      id: 'max_hang',
      category: 'climbing',
      name: 'Max Hang',
      bodyRegion: 'ساعد و انگشتان',
      measurementType: 'time',
      measurementUnit: 'sec',
      primaryMuscles: [
        'Finger Flexors',
        'Forearm',
        'Grip',
      ],
    ),

    Movement(
      id: 'repeaters',
      category: 'climbing',
      name: 'Repeaters',
      bodyRegion: 'ساعد و انگشتان',
      measurementType: 'reps',
      measurementUnit: 'rep',
      primaryMuscles: [
        'Finger Flexors',
        'Forearm',
        'Grip',
      ],
    ),

    Movement(
      id: 'campus_ladder',
      category: 'climbing',
      name: 'Campus Ladder',
      bodyRegion: 'بالاتنه',
      measurementType: 'reps',
      measurementUnit: 'rep',
      primaryMuscles: [
        'Lats',
        'Biceps',
        'Forearm',
        'Grip',
      ],
    ),

    Movement(
      id: 'campus_double',
      category: 'climbing',
      name: 'Campus Double Dyno',
      bodyRegion: 'بالاتنه',
      measurementType: 'reps',
      measurementUnit: 'rep',
      primaryMuscles: [
        'Lats',
        'Shoulders',
        'Core',
        'Grip',
      ],
    ),

    Movement(
      id: 'lock_off_90',
      category: 'climbing',
      name: 'Lock Off 90°',
      bodyRegion: 'بازو و شانه',
      measurementType: 'time',
      measurementUnit: 'sec',
      primaryMuscles: [
        'Biceps',
        'Lats',
        'Shoulders',
      ],
    ),

    Movement(
      id: 'front_lever',
      category: 'climbing',
      name: 'Front Lever',
      bodyRegion: 'بالاتنه و Core',
      measurementType: 'time',
      measurementUnit: 'sec',
      primaryMuscles: [
        'Lats',
        'Core',
        'Shoulders',
      ],
    ),

    Movement(
      id: 'one_arm_hang',
      category: 'climbing',
      name: 'One Arm Hang',
      bodyRegion: 'ساعد و انگشتان',
      measurementType: 'time',
      measurementUnit: 'sec',
      primaryMuscles: [
        'Grip',
        'Forearm',
        'Finger Flexors',
      ],
    ),

    Movement(
      id: 'pull_over',
      category: 'climbing',
      name: 'Pull Over',
      bodyRegion: 'بالاتنه',
      measurementType: 'reps',
      measurementUnit: 'rep',
      primaryMuscles: [
        'Lats',
        'Biceps',
        'Shoulders',
      ],
    ),

    Movement(
      id: 'campus_max_reach',
      category: 'climbing',
      name: 'Campus Max Reach',
      bodyRegion: 'بالاتنه و Grip',
      measurementType: 'distance',
      measurementUnit: 'm',
      primaryMuscles: [
        'Grip',
        'Lats',
        'Shoulders',
      ],
    ),

    // ============================================================
    // Strength | قدرت عمومی
    // ============================================================

    Movement(
      id: 'pull_up',
      category: 'strength',
      name: 'Pull Up',
      bodyRegion: 'پشت و بازو',
      measurementType: 'reps',
      measurementUnit: 'rep',
      primaryMuscles: [
        'Lats',
        'Biceps',
        'Forearm',
      ],
    ),

    Movement(
      id: 'weighted_pull_up',
      category: 'strength',
      name: 'Weighted Pull Up',
      bodyRegion: 'پشت و بازو',
      measurementType: 'weight',
      measurementUnit: 'kg',
      primaryMuscles: [
        'Lats',
        'Biceps',
        'Forearm',
      ],
    ),

    Movement(
      id: 'push_up',
      category: 'strength',
      name: 'Push Up',
      bodyRegion: 'سینه و بازو',
      measurementType: 'reps',
      measurementUnit: 'rep',
      primaryMuscles: [
        'Chest',
        'Triceps',
        'Shoulders',
      ],
    ),

    Movement(
      id: 'bench_press',
      category: 'strength',
      name: 'Bench Press',
      bodyRegion: 'سینه',
      measurementType: 'weight',
      measurementUnit: 'kg',
      primaryMuscles: [
        'Chest',
        'Triceps',
        'Shoulders',
      ],
    ),

    Movement(
      id: 'deadlift',
      category: 'strength',
      name: 'Deadlift',
      bodyRegion: 'کل زنجیره خلفی',
      measurementType: 'weight',
      measurementUnit: 'kg',
      primaryMuscles: [
        'Glutes',
        'Hamstrings',
        'Lower Back',
        'Grip',
      ],
    ),

    Movement(
      id: 'barbell_row',
      category: 'strength',
      name: 'Barbell Row',
      bodyRegion: 'پشت',
      measurementType: 'weight',
      measurementUnit: 'kg',
      primaryMuscles: [
        'Lats',
        'Rhomboids',
        'Biceps',
      ],
    ),

    Movement(
      id: 'biceps_curl',
      category: 'strength',
      name: 'Biceps Curl',
      bodyRegion: 'بازو',
      measurementType: 'weight',
      measurementUnit: 'kg',
      primaryMuscles: [
        'Biceps',
        'Forearm',
      ],
    ),

    Movement(
      id: 'overhead_press',
      category: 'strength',
      name: 'Overhead Press',
      bodyRegion: 'شانه و بازو',
      measurementType: 'weight',
      measurementUnit: 'kg',
      primaryMuscles: [
        'Shoulders',
        'Triceps',
        'Core',
      ],
    ),

    Movement(
      id: 'barbell_squat',
      category: 'strength',
      name: 'Barbell Squat',
      bodyRegion: 'پا و لگن',
      measurementType: 'weight',
      measurementUnit: 'kg',
      primaryMuscles: [
        'Quadriceps',
        'Glutes',
        'Hamstrings',
      ],
    ),

    Movement(
      id: 'split_squat',
      category: 'strength',
      name: 'Split Squat',
      bodyRegion: 'پا و لگن',
      measurementType: 'reps',
      measurementUnit: 'rep',
      primaryMuscles: [
        'Quadriceps',
        'Glutes',
        'Hamstrings',
      ],
    ),

    // ============================================================
    // Core
    // ============================================================

    Movement(
      id: 'plank',
      category: 'core',
      name: 'Plank',
      bodyRegion: 'Core',
      measurementType: 'time',
      measurementUnit: 'sec',
      primaryMuscles: [
        'Abdominals',
        'Obliques',
        'Core',
      ],
    ),

    Movement(
      id: 'side_plank',
      category: 'core',
      name: 'Side Plank',
      bodyRegion: 'Core جانبی',
      measurementType: 'time',
      measurementUnit: 'sec',
      primaryMuscles: [
        'Obliques',
        'Abdominals',
        'Core',
      ],
    ),

    Movement(
      id: 'hollow_body_hold',
      category: 'core',
      name: 'Hollow Body Hold',
      bodyRegion: 'Core',
      measurementType: 'time',
      measurementUnit: 'sec',
      primaryMuscles: [
        'Abdominals',
        'Hip Flexors',
        'Core',
      ],
    ),

    Movement(
      id: 'arch_body_hold',
      category: 'core',
      name: 'Arch Body Hold',
      bodyRegion: 'Core و پشت',
      measurementType: 'time',
      measurementUnit: 'sec',
      primaryMuscles: [
        'Lower Back',
        'Glutes',
        'Core',
      ],
    ),

    Movement(
      id: 'hanging_knee_raise',
      category: 'core',
      name: 'Hanging Knee Raise',
      bodyRegion: 'شکم',
      measurementType: 'reps',
      measurementUnit: 'rep',
      primaryMuscles: [
        'Abdominals',
        'Hip Flexors',
        'Grip',
      ],
    ),

    Movement(
      id: 'hanging_leg_raise',
      category: 'core',
      name: 'Hanging Leg Raise',
      bodyRegion: 'شکم و لگن',
      measurementType: 'reps',
      measurementUnit: 'rep',
      primaryMuscles: [
        'Abdominals',
        'Hip Flexors',
        'Grip',
      ],
    ),

    Movement(
      id: 'l_sit',
      category: 'core',
      name: 'L-Sit',
      bodyRegion: 'Core و لگن',
      measurementType: 'time',
      measurementUnit: 'sec',
      primaryMuscles: [
        'Abdominals',
        'Hip Flexors',
        'Triceps',
      ],
    ),

    Movement(
      id: 'dead_bug',
      category: 'core',
      name: 'Dead Bug',
      bodyRegion: 'Core',
      measurementType: 'reps',
      measurementUnit: 'rep',
      primaryMuscles: [
        'Abdominals',
        'Core',
        'Hip Flexors',
      ],
    ),

    // ============================================================
    // Mobility | انعطاف و Mobility
    // ============================================================

    Movement(
      id: 'shoulder_flexion',
      category: 'mobility',
      name: 'Shoulder Flexion',
      bodyRegion: 'شانه',
      measurementType: 'angle',
      measurementUnit: 'degree',
      primaryMuscles: [
        'Shoulders',
        'Upper Back',
      ],
    ),

    Movement(
      id: 'shoulder_external_rotation',
      category: 'mobility',
      name: 'Shoulder External Rotation',
      bodyRegion: 'شانه',
      measurementType: 'angle',
      measurementUnit: 'degree',
      primaryMuscles: [
        'Shoulders',
        'Rotator Cuff',
      ],
    ),

    Movement(
      id: 'wrist_extension',
      category: 'mobility',
      name: 'Wrist Extension',
      bodyRegion: 'مچ دست',
      measurementType: 'angle',
      measurementUnit: 'degree',
      primaryMuscles: [
        'Forearm',
        'Wrist',
      ],
    ),

    Movement(
      id: 'hip_flexion',
      category: 'mobility',
      name: 'Hip Flexion',
      bodyRegion: 'لگن',
      measurementType: 'angle',
      measurementUnit: 'degree',
      primaryMuscles: [
        'Hip Flexors',
        'Hamstrings',
      ],
    ),

    Movement(
      id: 'ankle_dorsiflexion',
      category: 'mobility',
      name: 'Ankle Dorsiflexion',
      bodyRegion: 'مچ پا',
      measurementType: 'angle',
      measurementUnit: 'degree',
      primaryMuscles: [
        'Calves',
        'Ankle',
      ],
    ),

    Movement(
      id: 'deep_squat_hold',
      category: 'mobility',
      name: 'Deep Squat Hold',
      bodyRegion: 'لگن و مچ پا',
      measurementType: 'time',
      measurementUnit: 'sec',
      primaryMuscles: [
        'Glutes',
        'Hip Flexors',
        'Calves',
      ],
    ),

    // ============================================================
    // Cardio | هوازی
    // ============================================================

    Movement(
      id: 'running_1km',
      category: 'cardio',
      name: 'Running 1 km',
      bodyRegion: 'کل بدن',
      measurementType: 'time',
      measurementUnit: 'sec',
      primaryMuscles: [
        'Legs',
        'Cardio',
      ],
    ),

    Movement(
      id: 'running_3km',
      category: 'cardio',
      name: 'Running 3 km',
      bodyRegion: 'کل بدن',
      measurementType: 'time',
      measurementUnit: 'sec',
      primaryMuscles: [
        'Legs',
        'Cardio',
      ],
    ),

    Movement(
      id: 'running_5km',
      category: 'cardio',
      name: 'Running 5 km',
      bodyRegion: 'کل بدن',
      measurementType: 'time',
      measurementUnit: 'sec',
      primaryMuscles: [
        'Legs',
        'Cardio',
      ],
    ),

    Movement(
      id: 'burpee_test',
      category: 'cardio',
      name: 'Burpee Test',
      bodyRegion: 'کل بدن',
      measurementType: 'reps',
      measurementUnit: 'rep',
      primaryMuscles: [
        'Legs',
        'Chest',
        'Core',
      ],
    ),

    Movement(
      id: 'jump_rope',
      category: 'cardio',
      name: 'Jump Rope',
      bodyRegion: 'کل بدن',
      measurementType: 'time',
      measurementUnit: 'sec',
      primaryMuscles: [
        'Calves',
        'Shoulders',
        'Cardio',
      ],
    ),

    Movement(
      id: 'step_test',
      category: 'cardio',
      name: 'Step Test',
      bodyRegion: 'پا و سیستم هوازی',
      measurementType: 'time',
      measurementUnit: 'sec',
      primaryMuscles: [
        'Quadriceps',
        'Glutes',
        'Calves',
        'Cardio',
      ],
    ),
  ];
}