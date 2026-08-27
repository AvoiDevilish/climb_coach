import 'package:flutter/material.dart';

import '../../../movements/data/repositories/movement_repository.dart';
import '../../../movements/domain/models/movement.dart';
import '../../data/repositories/training_repository.dart';
import '../../domain/models/training_program.dart';
import '../../domain/models/training_program_item.dart';

class TrainingProgramBuilderPage extends StatefulWidget {
  const TrainingProgramBuilderPage({super.key});

  @override
  State<TrainingProgramBuilderPage> createState() => _TrainingProgramBuilderPageState();
}

class _TrainingProgramBuilderPageState extends State<TrainingProgramBuilderPage> {
  final TrainingRepository _repository = TrainingRepository();
  final MovementRepository _movementRepository = MovementRepository();
  final _title = TextEditingController();
  final _description = TextEditingController();
  List<Movement> _movements = [];
  final List<TrainingProgramItem> _items = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    _movements = await _movementRepository.getAllMovements();
    if (mounted) setState(() => _loading = false);
  }

  Future<void> _addMovement() async {
    Movement? selected;
    int sets = 3;
    int? reps;
    int? seconds;
    final result = await showDialog<bool>(context: context, builder: (context) => StatefulBuilder(builder: (context, setState) => AlertDialog(
      title: const Text('افزودن حرکت به برنامه'),
      content: SingleChildScrollView(child: Column(mainAxisSize: MainAxisSize.min, children: [
        DropdownButtonFormField<Movement>(
          initialValue: selected,
          decoration: const InputDecoration(labelText: 'حرکت'),
          items: _movements.map((m) => DropdownMenuItem(value: m, child: Text(m.name))).toList(),
          onChanged: (v) => setState(() => selected = v),
        ),
        TextField(keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: 'ست'), onChanged: (v) => sets = int.tryParse(v) ?? 3),
        TextField(keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: 'تکرار (در صورت نیاز)'), onChanged: (v) => reps = int.tryParse(v)),
        TextField(keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: 'زمان ثانیه (در صورت نیاز)'), onChanged: (v) => seconds = int.tryParse(v)),
      ])),
      actions: [TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('انصراف')), FilledButton(onPressed: selected == null ? null : () => Navigator.pop(context, true), child: const Text('افزودن'))],
    )));
    if (result != true || selected == null) return;
    setState(() => _items.add(TrainingProgramItem(id: 'item_${DateTime.now().microsecondsSinceEpoch}', programId: '', movementId: selected!.id!, sets: sets, reps: reps, seconds: seconds, displayOrder: _items.length + 1)));
  }

  Future<void> _save() async {
    if (_title.text.trim().isEmpty || _items.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('عنوان برنامه و حداقل یک حرکت لازم است.')));
      return;
    }
    final id = 'program_${DateTime.now().microsecondsSinceEpoch}';
    await _repository.createProgram(TrainingProgram(id: id, title: _title.text.trim(), description: _description.text.trim(), type: 'custom'), _items.map((e) => TrainingProgramItem(id: e.id, programId: id, movementId: e.movementId, sets: e.sets, reps: e.reps, seconds: e.seconds, restSeconds: e.restSeconds, displayOrder: e.displayOrder)).toList());
    if (mounted) Navigator.pop(context, true);
  }

  @override
  void dispose() { _title.dispose(); _description.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    if (_loading) return const Scaffold(body: Center(child: CircularProgressIndicator()));
    return Scaffold(appBar: AppBar(title: const Text('ساخت برنامه تمرینی')), body: ListView(padding: const EdgeInsets.all(16), children: [
      TextField(controller: _title, decoration: const InputDecoration(labelText: 'نام برنامه', border: OutlineInputBorder())),
      const SizedBox(height: 12),
      TextField(controller: _description, maxLines: 3, decoration: const InputDecoration(labelText: 'توضیحات', border: OutlineInputBorder())),
      const SizedBox(height: 20),
      Row(children: [const Expanded(child: Text('حرکات برنامه', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold))), FilledButton.tonalIcon(onPressed: _addMovement, icon: const Icon(Icons.add), label: const Text('افزودن حرکت'))]),
      const SizedBox(height: 8),
      if (_items.isEmpty) const Padding(padding: EdgeInsets.all(24), child: Center(child: Text('هنوز حرکتی انتخاب نشده است.'))),
      ..._items.map((item) { final m = _movements.firstWhere((x) => x.id == item.movementId); return Card(child: ListTile(title: Text(m.name), subtitle: Text('${item.sets} ست${item.reps == null ? '' : ' • ${item.reps} تکرار'}${item.seconds == null ? '' : ' • ${item.seconds} ثانیه'}'), trailing: IconButton(onPressed: () => setState(() => _items.remove(item)), icon: const Icon(Icons.delete_outline)))); }),
      const SizedBox(height: 20),
      FilledButton.icon(onPressed: _save, icon: const Icon(Icons.save_outlined), label: const Text('ذخیره برنامه')),
    ]));
  }
}
