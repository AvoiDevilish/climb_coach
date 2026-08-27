import '../../domain/models/training_program.dart';
import '../../domain/models/training_program_item.dart';

class TrainingProgramSeed {
  static const programs = [
    TrainingProgram(
      id: 'program_climbing_strength',
      title: 'تقویت پایه سنگ‌نوردی',
      description: 'ترکیبی از حرکات کشش، Grip و Core برای تقویت عمومی سنگ‌نورد.',
      type: 'strength',
      isSystem: true,
    ),
    TrainingProgram(
      id: 'program_shoulder_correction',
      title: 'حرکات اصلاحی شانه',
      description: 'برنامه اصلاحی نمونه برای ورزشکار دارای آسیب شانه.',
      type: 'corrective',
      isSystem: true,
    ),
  ];

  static const items = [
    TrainingProgramItem(id: 'pcs_1', programId: 'program_climbing_strength', movementId: 'pull_up', sets: 3, reps: 8, restSeconds: 90, displayOrder: 1),
    TrainingProgramItem(id: 'pcs_2', programId: 'program_climbing_strength', movementId: 'dead_hang', sets: 3, seconds: 20, restSeconds: 90, displayOrder: 2),
    TrainingProgramItem(id: 'pcs_3', programId: 'program_climbing_strength', movementId: 'front_lever', sets: 3, seconds: 10, restSeconds: 90, displayOrder: 3),
    TrainingProgramItem(id: 'psc_1', programId: 'program_shoulder_correction', movementId: 'scapular_wall_slide', sets: 3, reps: 12, restSeconds: 45, displayOrder: 1),
    TrainingProgramItem(id: 'psc_2', programId: 'program_shoulder_correction', movementId: 'external_rotation_band', sets: 3, reps: 15, restSeconds: 45, displayOrder: 2),
  ];
}
