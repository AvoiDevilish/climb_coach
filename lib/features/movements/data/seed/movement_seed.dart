import '../../domain/models/movement.dart';

class MovementSeed {
  static const List<Movement> movements = [
        // ======================
    // Climbing
    // ======================

    Movement(
      id: 'dead_hang',
      categoryId: 'climbing',
      title: 'Dead Hang',
      recordType: 'time',
      unit: 'sec',
    ),

    Movement(
      id: 'max_hang',
      categoryId: 'climbing',
      title: 'Max Hang',
      recordType: 'time',
      unit: 'sec',
    ),

    Movement(
      id: 'repeaters',
      categoryId: 'climbing',
      title: 'Repeaters',
      recordType: 'reps',
      unit: 'rep',
    ),

    Movement(
      id: 'campus_ladder',
      categoryId: 'climbing',
      title: 'Campus Ladder',
      recordType: 'reps',
      unit: 'rep',
    ),

    Movement(
      id: 'campus_double',
      categoryId: 'climbing',
      title: 'Campus Double Dyno',
      recordType: 'reps',
      unit: 'rep',
    ),

    Movement(
      id: 'lock_off_90',
      categoryId: 'climbing',
      title: 'Lock Off 90°',
      recordType: 'time',
      unit: 'sec',
    ),

    Movement(
      id: 'front_lever',
      categoryId: 'climbing',
      title: 'Front Lever',
      recordType: 'time',
      unit: 'sec',
    ),

    Movement(
      id: 'one_arm_hang',
      categoryId: 'climbing',
      title: 'One Arm Hang',
      recordType: 'time',
      unit: 'sec',
    ),

        // ======================
    // Strength
    // ======================

    Movement(
      id: 'pull_up',
      categoryId: 'strength',
      title: 'Pull Up',
      recordType: 'reps',
      unit: 'rep',
    ),

    Movement(
      id: 'weighted_pull_up',
      categoryId: 'strength',
      title: 'Weighted Pull Up',
      recordType: 'weight',
      unit: 'kg',
    ),

    Movement(
      id: 'bench_press',
      categoryId: 'strength',
      title: 'Bench Press',
      recordType: 'weight',
      unit: 'kg',
    ),

    Movement(
      id: 'deadlift',
      categoryId: 'strength',
      title: 'Deadlift',
      recordType: 'weight',
      unit: 'kg',
    ),

    Movement(
      id: 'barbell_row',
      categoryId: 'strength',
      title: 'Barbell Row',
      recordType: 'weight',
      unit: 'kg',
    ),

    Movement(
      id: 'biceps_curl',
      categoryId: 'strength',
      title: 'Biceps Curl',
      recordType: 'weight',
      unit: 'kg',
    ),

  ];
}