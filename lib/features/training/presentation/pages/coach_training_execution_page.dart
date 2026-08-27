import 'package:flutter/material.dart';

import '../../../athletes/domain/models/athlete.dart';
import '../../../movements/data/repositories/movement_repository.dart';
import '../../../movements/domain/models/movement.dart';
import '../../data/repositories/training_repository.dart';
import '../../domain/models/athlete_training_assignment.dart';
import '../../domain/models/training_log.dart';

class CoachTrainingExecutionPage extends StatefulWidget {
  const CoachTrainingExecutionPage({super.key});

  @override
  State<CoachTrainingExecutionPage> createState() => _CoachTrainingExecutionPageState();
}

class _CoachTrainingExecutionPageState extends State<CoachTrainingExecutionPage> {
  final _repository = TrainingRepository();
  final _movementRepository = MovementRepository();
  Athlete? athlete;
  List<AthleteTrainingAssignment> assignments = [];
  List<Movement> movements = [];
  bool loading = true;

  Future<void> _load() async {
    final arg = ModalRoute.of(context)?.settings.arguments;
    if (arg is! Athlete || arg.id == null) { if (mounted) setState(() => loading = false); return; }
    athlete = arg;
    assignments = await _repository.getAssignments(arg.id!);
    movements = await _movementRepository.getAllMovements();
    if (mounted) setState(() => loading = false);
  }

  @override
  void initState() { super.initState(); WidgetsBinding.instance.addPostFrameCallback((_) => _load()); }

  Future<void> _record(AthleteTrainingAssignment assignment) async {
    final movementId = assignment.movementId;
    if (movementId == null) return;
    final movement = await _movementRepository.getById(movementId);
    if (movement == null) return;
    final valueController = TextEditingController();
    final noteController = TextEditingController();
    final ok = await showDialog<bool>(context: context, builder: (context) => AlertDialog(title: Text('ثبت اجرای ${movement.name}'), content: Column(mainAxisSize: MainAxisSize.min, children: [TextField(controller: valueController, keyboardType: const TextInputType.numberWithOptions(decimal: true), decoration: InputDecoration(labelText: 'مقدار (${movement.measurementUnit})')), const SizedBox(height: 8), TextField(controller: noteController, decoration: const InputDecoration(labelText: 'یادداشت'))]), actions: [TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('انصراف')), FilledButton(onPressed: () => Navigator.pop(context, true), child: const Text('ثبت'))]));
    if (ok != true) return;
    final value = double.tryParse(valueController.text.trim().replaceAll(',', '.'));
    if (value == null) {
      if (mounted) ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('مقدار معتبر وارد کنید.')));
      return;
    }
    await _repository.recordLog(TrainingLog(
      id: 'log_${DateTime.now().microsecondsSinceEpoch}',
      assignmentId: assignment.id,
      athleteId: athlete!.id!,
      movementId: movement.id!,
      value: value,
      unit: movement.measurementUnit,
      setsCompleted: assignment.sets,
      repsCompleted: assignment.reps,
      durationSeconds: assignment.seconds,
      note: noteController.text.trim().isEmpty ? null : noteController.text.trim(),
      performedAt: DateTime.now(),
    ));
    if (mounted) ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('اجرای حرکت توسط مربی ثبت شد.')));
  }

  @override
  Widget build(BuildContext context) {
    if (loading) return const Scaffold(body: Center(child: CircularProgressIndicator()));
    return Scaffold(appBar: AppBar(title: Text('ثبت تمرین ${athlete?.firstName ?? ''}')), body: assignments.isEmpty ? const Center(child: Text('تمرین اختصاص‌یافته‌ای وجود ندارد.')) : ListView.builder(padding: const EdgeInsets.all(16), itemCount: assignments.length, itemBuilder: (_, i) {
      final a = assignments[i];
      Movement? m;
      if (a.movementId != null) {
        for (final candidate in movements) {
          if (candidate.id == a.movementId) { m = candidate; break; }
        }
      }
      return Card(child: ListTile(title: Text(a.assignmentType == 'program' ? 'برنامه تمرینی' : (m?.name ?? 'حرکت')), subtitle: Text(a.status == 'active' ? 'فعال' : a.status), trailing: a.assignmentType == 'movement' ? FilledButton.tonal(onPressed: () => _record(a), child: const Text('ثبت اجرا')) : null));
    }));
  }
}
