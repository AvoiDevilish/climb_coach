import 'package:flutter/material.dart';

import '../../../athletes/domain/models/athlete.dart';
import '../../domain/models/movement.dart';
import '../../domain/models/movement_performance.dart';
import '../controllers/movement_performance_controller.dart';

class MovementPerformanceFormArguments {
  final Athlete athlete;
  final Movement movement;

  const MovementPerformanceFormArguments({
    required this.athlete,
    required this.movement,
  });
}

class MovementPerformanceFormPage extends StatefulWidget {
  const MovementPerformanceFormPage({
    super.key,
  });

  @override
  State<MovementPerformanceFormPage> createState() =>
      _MovementPerformanceFormPageState();
}

class _MovementPerformanceFormPageState
    extends State<MovementPerformanceFormPage> {
  final MovementPerformanceController _controller =
      MovementPerformanceController();

  final TextEditingController _valueController =
      TextEditingController();

  final TextEditingController _noteController =
      TextEditingController();

  MovementPerformanceFormArguments? _arguments;

  bool _saving = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (_arguments != null) {
      return;
    }

    final argument =
        ModalRoute.of(context)?.settings.arguments;

    if (argument is MovementPerformanceFormArguments) {
      _arguments = argument;
    }
  }

  @override
  void dispose() {
    _valueController.dispose();
    _noteController.dispose();
    _controller.dispose();

    super.dispose();
  }

  String _measurementLabel(String type) {
    switch (type) {
      case 'reps':
        return 'تعداد تکرار';

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

  String _measurementUnit(Movement movement) {
    switch (movement.measurementUnit) {
      case 'rep':
        return 'تکرار';

      case 'sec':
        return 'ثانیه';

      case 'kg':
        return 'کیلوگرم';

      case 'm':
        return 'متر';

      case 'degree':
        return 'درجه';

      default:
        return movement.measurementUnit;
    }
  }

  IconData _measurementIcon(String type) {
    switch (type) {
      case 'reps':
        return Icons.repeat;

      case 'time':
        return Icons.timer_outlined;

      case 'weight':
        return Icons.fitness_center;

      case 'distance':
        return Icons.straighten;

      case 'angle':
        return Icons.architecture;

      default:
        return Icons.analytics_outlined;
    }
  }

  bool _isValidValue(String value) {
    final normalized =
        value.trim().replaceAll(',', '.');

    final parsed = double.tryParse(normalized);

    return parsed != null && parsed >= 0;
  }

  Future<void> _save() async {
    final arguments = _arguments;

    if (arguments == null) {
      _showError(
        'اطلاعات ورزشکار و حرکت قابل بارگذاری نیست.',
      );
      return;
    }

    // -----------------------------------------
    // Validate athlete ID
    // -----------------------------------------

    final athleteId =
        arguments.athlete.id?.trim();

    if (athleteId == null || athleteId.isEmpty) {
      _showError(
        'شناسه ورزشکار معتبر نیست.',
      );
      return;
    }

    // -----------------------------------------
    // Validate movement ID
    // -----------------------------------------

    final movementId =
        arguments.movement.id?.trim();

    if (movementId == null || movementId.isEmpty) {
      _showError(
        'شناسه حرکت معتبر نیست.',
      );
      return;
    }

    // -----------------------------------------
    // Validate value
    // -----------------------------------------

    final rawValue =
        _valueController.text.trim().replaceAll(
              ',',
              '.',
            );

    if (!_isValidValue(rawValue)) {
      _showError(
        'لطفاً یک مقدار معتبر وارد کنید.',
      );
      return;
    }

    final value = double.tryParse(rawValue);

    if (value == null) {
      _showError(
        'مقدار واردشده معتبر نیست.',
      );
      return;
    }

    if (_saving) {
      return;
    }

    setState(() {
      _saving = true;
    });

    try {
      final noteText =
          _noteController.text.trim();

      final performance =
          MovementPerformance(
        athleteId: athleteId,
        movementId: movementId,
        value: value,
        unit: arguments.movement.measurementUnit,
        note: noteText.isEmpty
            ? null
            : noteText,
        recordedAt: DateTime.now(),
      );

      await _controller.addPerformance(
        performance,
      );

      if (!mounted) {
        return;
      }

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'عملکرد حرکت با موفقیت ثبت شد.',
          ),
        ),
      );

      Navigator.pop(
        context,
        true,
      );
    } catch (e) {
      if (!mounted) {
        return;
      }

      _showError(
        'ثبت عملکرد ناموفق بود:\n$e',
      );
    } finally {
      if (mounted) {
        setState(() {
          _saving = false;
        });
      }
    }
  }

  void _showError(String message) {
    if (!mounted) {
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final arguments = _arguments;

    if (arguments == null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text(
            'ثبت عملکرد',
          ),
        ),
        body: const Center(
          child: Padding(
            padding: EdgeInsets.all(24),
            child: Text(
              'اطلاعات ورزشکار و حرکت قابل بارگذاری نیست.',
              textAlign: TextAlign.center,
            ),
          ),
        ),
      );
    }

    final athlete = arguments.athlete;
    final movement = arguments.movement;

    final measurementLabel =
        _measurementLabel(
      movement.measurementType,
    );

    final measurementUnit =
        _measurementUnit(
      movement,
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'ثبت عملکرد',
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Container(
                      width: 52,
                      height: 52,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Theme.of(context)
                            .colorScheme
                            .surfaceContainerHighest,
                        borderRadius:
                            BorderRadius.circular(14),
                      ),
                      child: Icon(
                        _measurementIcon(
                          movement.measurementType,
                        ),
                        size: 28,
                      ),
                    ),

                    const SizedBox(width: 14),

                    Expanded(
                      child: Column(
                        crossAxisAlignment:
                            CrossAxisAlignment.start,
                        children: [
                          Text(
                            movement.name,
                            style: const TextStyle(
                              fontSize: 19,
                              fontWeight:
                                  FontWeight.bold,
                            ),
                          ),

                          const SizedBox(height: 4),

                          Text(
                            '${athlete.firstName} '
                            '${athlete.lastName}',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onSurfaceVariant,
                                ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            Text(
              measurementLabel,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            TextField(
              controller: _valueController,
              keyboardType:
                  const TextInputType.numberWithOptions(
                decimal: true,
              ),
              textDirection: TextDirection.ltr,
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                hintText: 'مثلاً 45',
                suffixText: measurementUnit,
                prefixIcon: Icon(
                  _measurementIcon(
                    movement.measurementType,
                  ),
                ),
                border: const OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 20),

            const Text(
              'یادداشت',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            TextField(
              controller: _noteController,
              maxLines: 4,
              textDirection: TextDirection.rtl,
              decoration: const InputDecoration(
                hintText:
                    'توضیحات اختیاری درباره عملکرد...',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 28),

            SizedBox(
              width: double.infinity,
              child: FilledButton.icon(
                onPressed:
                    _saving ? null : _save,
                icon: _saving
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child:
                            CircularProgressIndicator(
                          strokeWidth: 2,
                        ),
                      )
                    : const Icon(
                        Icons.save_outlined,
                      ),
                label: Text(
                  _saving
                      ? 'در حال ثبت...'
                      : 'ثبت عملکرد',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}