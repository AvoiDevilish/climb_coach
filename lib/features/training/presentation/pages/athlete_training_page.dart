import 'package:flutter/material.dart';

import '../../../athletes/domain/models/athlete.dart';
import '../../../movements/data/repositories/movement_repository.dart';
import '../../../movements/domain/models/movement.dart';
import '../../data/repositories/training_repository.dart';
import '../../domain/models/athlete_training_assignment.dart';
import '../../domain/models/training_program.dart';

class AthleteTrainingPage extends StatefulWidget {
  const AthleteTrainingPage({super.key});

  @override
  State<AthleteTrainingPage> createState() => _AthleteTrainingPageState();
}

class _AthleteTrainingPageState extends State<AthleteTrainingPage> with SingleTickerProviderStateMixin {
  final TrainingRepository _trainingRepository = TrainingRepository();
  final MovementRepository _movementRepository = MovementRepository();

  Athlete? _athlete;
  List<TrainingProgram> _programs = [];
  List<Movement> _movements = [];
  List<AthleteTrainingAssignment> _assignments = [];
  bool _loading = true;
  int _tab = 0;

  bool get _injured {
    if (_athlete == null) return false;
    return _athlete!.healthStatus == 'injured';
  }

  bool _allowed(Movement movement) {
    if (!_injured) return true;
    if (!movement.isCorrective) return false;
    if (_athlete!.injuryAreas.isEmpty) return true;
    return movement.injuryAreas.any(_athlete!.injuryAreas.contains);
  }

  Future<void> _load() async {
    final args = ModalRoute.of(context)?.settings.arguments;
    if (args is! Athlete) {
      setState(() => _loading = false);
      return;
    }
    _athlete = args;
    final programs = await _trainingRepository.getPrograms();
    final movements = await _movementRepository.getAllMovements();
    final assignments = await _trainingRepository.getAssignments(args.id!);
    if (!mounted) return;
    setState(() {
      _programs = programs;
      _movements = movements.where(_allowed).toList();
      _assignments = assignments.where((a) => a.status == 'active').toList();
      _loading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _load());
  }

  Future<void> _assignProgram(TrainingProgram program) async {
    final items = await _trainingRepository.getProgramItems(program.id);
    final allowedItems = <String>{};
    for (final item in items) {
      final movement = await _movementRepository.getById(item.movementId);
      if (movement != null && _allowed(movement)) allowedItems.add(item.movementId);
    }
    if (_injured && allowedItems.length != items.length) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('این برنامه شامل حرکات غیرمجاز برای وضعیت فعلی ورزشکار است.')));
      return;
    }
    await _trainingRepository.assignProgram(AthleteTrainingAssignment(
      id: 'assignment_${DateTime.now().microsecondsSinceEpoch}',
      athleteId: _athlete!.id!,
      assignmentType: 'program',
      programId: program.id,
      assignedAt: DateTime.now(),
      startDate: DateTime.now(),
      status: 'active',
    ));
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('برنامه «${program.title}» اختصاص داده شد.')));
  }

  Future<void> _assignMovement(Movement movement) async {
    if (!_allowed(movement)) return;
    final setsController = TextEditingController(text: '3');
    final repsController = TextEditingController(text: movement.measurementType == 'reps' ? '10' : '');
    final secondsController = TextEditingController(text: movement.measurementType == 'time' ? '20' : '');
    final result = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('اختصاص ${movement.name}'),
        content: Column(mainAxisSize: MainAxisSize.min, children: [
          TextField(controller: setsController, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: 'ست')),
          if (movement.measurementType == 'reps') TextField(controller: repsController, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: 'تکرار')),
          if (movement.measurementType == 'time') TextField(controller: secondsController, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: 'زمان (ثانیه)')),
        ]),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('انصراف')),
          FilledButton(onPressed: () => Navigator.pop(context, true), child: const Text('اختصاص')),
        ],
      ),
    );
    if (result != true || !mounted) return;
    await _trainingRepository.assignMovement(AthleteTrainingAssignment(
      id: 'assignment_${DateTime.now().microsecondsSinceEpoch}',
      athleteId: _athlete!.id!,
      assignmentType: 'movement',
      movementId: movement.id,
      sets: int.tryParse(setsController.text),
      reps: int.tryParse(repsController.text),
      seconds: int.tryParse(secondsController.text),
      assignedAt: DateTime.now(),
      startDate: DateTime.now(),
      status: 'active',
    ));
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('حرکت اختصاص داده شد.')));
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) return const Scaffold(body: Center(child: CircularProgressIndicator()));
    if (_athlete == null || _athlete!.id == null) return const Scaffold(body: Center(child: Text('ورزشکار معتبر نیست')));
    final programs = _programs.where((p) => !_injured || p.type == 'corrective').toList();
    return Scaffold(
      appBar: AppBar(title: Text('تمرین ${_athlete!.firstName} ${_athlete!.lastName}')),
      body: Column(children: [
        if (_injured)
          Container(width: double.infinity, padding: const EdgeInsets.all(12), color: Colors.orange.withValues(alpha: .15), child: Text('وضعیت مصدوم: ${_athlete!.injuryAreas.join('، ')}\nفقط حرکات و برنامه‌های اصلاحی مجاز نمایش داده می‌شوند.')),
        if (_assignments.isNotEmpty)
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 4),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Expanded(child: Text('تمرین‌های اختصاص‌یافته', style: TextStyle(fontWeight: FontWeight.bold))),
                    TextButton.icon(
                      onPressed: () => Navigator.pushNamed(context, '/athlete/training/execute', arguments: _athlete),
                      icon: const Icon(Icons.play_arrow_outlined),
                      label: const Text('ثبت اجرای تمرین'),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                ..._assignments.map((a) => Card(
                  child: ListTile(
                    dense: true,
                    title: Text(a.assignmentType == 'program' ? 'برنامه تمرینی' : 'حرکت اختصاصی'),
                    subtitle: Text(a.assignmentType == 'program' ? (a.programId ?? '') : (a.movementId ?? '')),
                    trailing: IconButton(
                      tooltip: 'حذف از برنامه ورزشکار',
                      onPressed: () async {
                        await _trainingRepository.cancelAssignment(a.id);
                        if (mounted) setState(() => _assignments.remove(a));
                      },
                      icon: const Icon(Icons.remove_circle_outline),
                    ),
                  ),
                )),
              ],
            ),
          ),

        Padding(padding: const EdgeInsets.all(12), child: SegmentedButton<int>(segments: const [ButtonSegment(value: 0, label: Text('برنامه‌ها')), ButtonSegment(value: 1, label: Text('حرکت‌ها'))], selected: {_tab}, onSelectionChanged: (s) => setState(() => _tab = s.first))),
        Expanded(child: _tab == 0
          ? ListView.builder(padding: const EdgeInsets.all(16), itemCount: programs.length, itemBuilder: (_, i) { final p = programs[i]; return Card(child: ListTile(title: Text(p.title), subtitle: Text(p.description), trailing: FilledButton.tonal(onPressed: () => _assignProgram(p), child: const Text('اختصاص')))); })
          : ListView.builder(padding: const EdgeInsets.all(16), itemCount: _movements.length, itemBuilder: (_, i) { final m = _movements[i]; return Card(child: ListTile(title: Text(m.name), subtitle: Text('${m.bodyRegion} • ${m.measurementUnit}'), trailing: FilledButton.tonal(onPressed: () => _assignMovement(m), child: const Text('اختصاص')))); }),
        ),
      ]),
    );
  }
}
