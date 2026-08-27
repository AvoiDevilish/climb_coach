import 'package:flutter/material.dart';

import '../controllers/assessment_controller.dart';
import '../widgets/assessment_tile.dart';
import '../../../training/data/repositories/training_repository.dart';
import '../../../training/domain/models/training_program.dart';

class AssessmentBrowserPage extends StatefulWidget {
  const AssessmentBrowserPage({super.key});
  @override
  State<AssessmentBrowserPage> createState() => _AssessmentBrowserPageState();
}

class _AssessmentBrowserPageState extends State<AssessmentBrowserPage> {
  final AssessmentController _assessmentController = AssessmentController();
  final TrainingRepository _trainingRepository = TrainingRepository();
  List<TrainingProgram> _programs = [];
  bool _loadingPrograms = true;

  @override
  void initState() { super.initState(); _loadPrograms(); }

  Future<void> _loadPrograms() async {
    _programs = await _trainingRepository.getPrograms();
    if (mounted) setState(() => _loadingPrograms = false);
  }

  @override
  Widget build(BuildContext context) {
    final assessments = _assessmentController.assessments;
    final corrective = _programs.where((p) => p.type == 'corrective').toList();
    final ready = _programs.where((p) => p.type != 'corrective').toList();
    return Scaffold(
      appBar: AppBar(title: const Text('آزمون‌ها و برنامه‌های تمرینی'), centerTitle: true),
      body: ListView(padding: const EdgeInsets.all(16), children: [
        const Text('آزمون‌ها', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        if (assessments.isEmpty) const Text('آزمونی تعریف نشده است.') else ...assessments.map((a) => Padding(padding: const EdgeInsets.only(bottom: 8), child: AssessmentTile(assessment: a, onTap: () => Navigator.pushNamed(context, '/assessment/detail', arguments: a)))),
        const SizedBox(height: 24),
        const Text('برنامه‌های تمرینی آماده', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        if (_loadingPrograms) const Center(child: CircularProgressIndicator()) else ...ready.map((p) => Card(child: ListTile(title: Text(p.title), subtitle: Text(p.description), trailing: const Icon(Icons.chevron_right), onTap: () => _showProgram(context, p)))),
        const SizedBox(height: 24),
        const Text('برنامه‌های آماده حرکات اصلاحی', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        if (!_loadingPrograms && corrective.isEmpty) const Text('برنامه اصلاحی آماده‌ای ثبت نشده است.') else ...corrective.map((p) => Card(child: ListTile(leading: const Icon(Icons.healing_outlined), title: Text(p.title), subtitle: Text(p.description), onTap: () => _showProgram(context, p)))),
        const SizedBox(height: 24),
        SizedBox(width: double.infinity, child: FilledButton.icon(onPressed: () async { final changed = await Navigator.pushNamed(context, '/training/program/new'); if (changed == true) _loadPrograms(); }, icon: const Icon(Icons.add), label: const Text('ساخت برنامه توسط مربی'))),
      ]),
    );
  }

  Future<void> _showProgram(BuildContext context, TrainingProgram program) async {
    final items = await _trainingRepository.getProgramItems(program.id);
    if (!context.mounted) return;
    showModalBottomSheet(context: context, isScrollControlled: true, builder: (_) => SafeArea(child: Padding(padding: const EdgeInsets.all(16), child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [Text(program.title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)), const SizedBox(height: 8), Text(program.description), const SizedBox(height: 16), ...items.map((i) => Text('${i.displayOrder}. ${i.movementId} — ${i.sets} ست${i.reps == null ? '' : ' × ${i.reps} تکرار'}${i.seconds == null ? '' : ' × ${i.seconds} ثانیه'}')), const SizedBox(height: 16)]))));
  }
}
