import 'package:flutter/material.dart';

import '../../domain/models/assessment.dart';
import '../../presentation/controllers/assessment_execution_controller.dart';
import '../../presentation/models/assessment_execution_item.dart';
import '../widgets/assessment_execution_card.dart';
import '../../../movements/data/repositories/movement_repository.dart';
import '../../data/repositories/assessment_result_repository.dart';

class AssessmentExecutionPage extends StatefulWidget {
  const AssessmentExecutionPage({
    super.key,
  });

  @override
  State<AssessmentExecutionPage> createState() =>
      _AssessmentExecutionPageState();
}

class _AssessmentExecutionPageState
    extends State<AssessmentExecutionPage> {
  final AssessmentExecutionController _controller =
      AssessmentExecutionController();

  final MovementRepository _movementRepository =
      MovementRepository();

  final AssessmentResultRepository _resultRepository =
      AssessmentResultRepository();

  final TextEditingController _valueController =
      TextEditingController();

  bool _initialized = false;
  bool _loading = true;

  List<AssessmentExecutionItem> _executionItems = [];

  String? _athleteId;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (_initialized) {
      return;
    }

    final arguments =
        ModalRoute.of(context)?.settings.arguments;

    if (arguments is! Map<String, dynamic>) {
      _initialized = true;
      _loading = false;
      return;
    }

    final assessment =
        arguments['assessment'] as Assessment?;

    _athleteId =
        arguments['athleteId']?.toString();

    if (assessment == null) {
      _initialized = true;
      _loading = false;
      return;
    }

    _controller.initialize(
      assessment,
      athleteId: _athleteId,
    );

    _loadExecutionItems();

    _initialized = true;
  }

  Future<void> _loadExecutionItems() async {
    final assessmentItems = _controller.items;

    final List<AssessmentExecutionItem> result = [];

    for (final item in assessmentItems) {
      final movement =
          await _movementRepository.getById(
        item.movementId,
      );

      if (movement == null) {
        continue;
      }

      result.add(
        AssessmentExecutionItem(
          item: item,
          movement: movement,
        ),
      );
    }

    if (!mounted) {
      return;
    }

    setState(() {
      _executionItems = result;
      _loading = false;
    });

    _syncCurrentValue();
  }

  void _syncCurrentValue() {
    if (_executionItems.isEmpty) {
      _valueController.clear();
      return;
    }

    final current =
        _executionItems[_controller.currentIndex];

    final existingValue =
        _controller.values[current.movement.id];

    _valueController.text =
        existingValue?.toString() ?? '';
  }

  void _saveCurrentValue() {
    if (_executionItems.isEmpty) {
      return;
    }

    final current =
        _executionItems[_controller.currentIndex];

    final text =
        _valueController.text.trim();

    if (text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'لطفاً مقدار حرکت را وارد کنید',
          ),
        ),
      );

      return;
    }

    final value =
        double.tryParse(
      text.replaceAll(',', '.'),
    );

    if (value == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'مقدار وارد شده معتبر نیست',
          ),
        ),
      );

      return;
    }

    _controller.setValue(
      current.movement.id ?? current.item.movementId,
      value,
    );

    if (_controller.hasNext) {
      _controller.next();

      _syncCurrentValue();

      setState(() {});
      return;
    }

    _finishAssessment();
  }

  Future<void> _finishAssessment() async {
    final result =
        _controller.buildResult();

    if (result == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'نتیجه آزمون قابل ایجاد نیست',
          ),
        ),
      );

      return;
    }

    await _resultRepository.insert(result);

    if (!mounted) return;

    Navigator.pop(
      context,
      result,
    );
  }

  String _measurementLabel(
    String type,
  ) {
    switch (type) {
      case 'reps':
        return 'تکرار';

      case 'time':
        return 'زمان';

      case 'weight':
        return 'وزنه';

      case 'distance':
        return 'مسافت';

      case 'angle':
        return 'زاویه';

      default:
        return 'مقدار';
    }
  }

  @override
  void dispose() {
    _valueController.dispose();
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_initialized || _loading) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    if (_executionItems.isEmpty) {
      return Scaffold(
        appBar: AppBar(
          title: const Text(
            'اجرای آزمون',
          ),
        ),
        body: const Center(
          child: Text(
            'حرکتی برای این آزمون ثبت نشده است',
          ),
        ),
      );
    }

    final current =
        _executionItems[_controller.currentIndex];

    final movement =
        current.movement;

    final currentNumber =
        _controller.currentIndex + 1;

    final total =
        _executionItems.length;

    final progress =
        currentNumber / total;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'اجرای آزمون',
        ),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    'حرکت $currentNumber از $total',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Text(
                  '${(progress * 100).round()}٪',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 10),

            ClipRRect(
              borderRadius:
                  BorderRadius.circular(8),
              child: LinearProgressIndicator(
                value: progress,
                minHeight: 8,
              ),
            ),

            const SizedBox(height: 24),

            Card(
              elevation: 0,
              color: Theme.of(context)
                  .colorScheme
                  .surfaceContainerHighest,
              child: Padding(
                padding:
                    const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    Text(
                      movement.name,
                      style:
                          const TextStyle(
                        fontSize: 24,
                        fontWeight:
                            FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 8),

                    Text(
                      movement.bodyRegion,
                      style:
                          Theme.of(context)
                              .textTheme
                              .bodyMedium,
                    ),

                    if (movement
                        .primaryMuscles
                        .isNotEmpty) ...[
                      const SizedBox(height: 8),

                      Text(
                        'عضلات: '
                        '${movement.primaryMuscles.join('، ')}',
                        style:
                            Theme.of(context)
                                .textTheme
                                .bodySmall,
                      ),
                    ],

                    const SizedBox(height: 14),

                    Row(
                      children: [
                        const Icon(
                          Icons.analytics_outlined,
                          size: 20,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'معیار: ${_measurementLabel(movement.measurementType)}',
                        ),
                      ],
                    ),

                    const SizedBox(height: 6),

                    Row(
                      children: [
                        const Icon(
                          Icons.straighten,
                          size: 20,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'واحد: ${movement.measurementUnit}',
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            TextField(
              controller: _valueController,
              keyboardType:
                  const TextInputType.numberWithOptions(
                decimal: true,
              ),
              textDirection:
                  TextDirection.ltr,
              textAlign:
                  TextAlign.center,
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
              decoration: InputDecoration(
                labelText:
                    'مقدار ${movement.measurementUnit}',
                suffixText:
                    movement.measurementUnit,
                border:
                    const OutlineInputBorder(),
              ),
              onSubmitted: (_) {
                _saveCurrentValue();
              },
            ),

            const SizedBox(height: 24),

            AssessmentExecutionCard(
              executionItem: current,
              controller: _valueController,
              onNext: _saveCurrentValue,
            ),

            const SizedBox(height: 12),

            if (!_controller.hasNext)
              const Text(
                'با ثبت این حرکت، آزمون به پایان می‌رسد.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
