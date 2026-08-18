import 'package:flutter/material.dart';

import '../../../athletes/domain/models/athlete.dart';
import '../../domain/models/movement.dart';
import '../../domain/models/movement_performance.dart';
import '../controllers/movement_performance_controller.dart';
import 'movement_performance_form_page.dart';

class MovementDetailArguments {
  final Athlete athlete;
  final Movement movement;

  const MovementDetailArguments({
    required this.athlete,
    required this.movement,
  });
}

class MovementDetailPage extends StatefulWidget {
  const MovementDetailPage({
    super.key,
  });

  @override
  State<MovementDetailPage> createState() =>
      _MovementDetailPageState();
}

class _MovementDetailPageState
    extends State<MovementDetailPage> {
  final MovementPerformanceController _controller =
      MovementPerformanceController();

  MovementDetailArguments? _arguments;

  MovementPerformance? _latestPerformance;

  bool _loadingLatestPerformance = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (_arguments != null) {
      return;
    }

    final argument =
        ModalRoute.of(context)?.settings.arguments;

    if (argument is MovementDetailArguments) {
      _arguments = argument;
      _loadLatestPerformance();
    }
  }

  Future<void> _loadLatestPerformance() async {
    final arguments = _arguments;

    if (arguments == null) {
      return;
    }

    final athleteId =
        arguments.athlete.id?.trim();

    final movementId =
        arguments.movement.id?.trim();

    if (athleteId == null ||
        athleteId.isEmpty ||
        movementId == null ||
        movementId.isEmpty) {
      return;
    }

    setState(() {
      _loadingLatestPerformance = true;
    });

    try {
      final performance =
          await _controller.getLatest(
        athleteId,
        movementId,
      );

      if (!mounted) {
        return;
      }

      setState(() {
        _latestPerformance = performance;
      });
    } catch (_) {
      if (!mounted) {
        return;
      }

      setState(() {
        _latestPerformance = null;
      });
    } finally {
      if (mounted) {
        setState(() {
          _loadingLatestPerformance = false;
        });
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  String measurementLabel(
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
        return type;
    }
  }

  IconData measurementIcon(
    String type,
  ) {
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

  String performanceUnit(
    String unit,
  ) {
    switch (unit) {
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
        return unit;
    }
  }

  String formatPerformanceValue(
    double value,
  ) {
    if (value == value.roundToDouble()) {
      return value.toInt().toString();
    }

    return value
        .toStringAsFixed(2)
        .replaceFirst(
          RegExp(r'\.?0+$'),
          '',
        );
  }

  String formatDateTime(
    DateTime dateTime,
  ) {
    final date =
        '${dateTime.year}/'
        '${dateTime.month.toString().padLeft(2, '0')}/'
        '${dateTime.day.toString().padLeft(2, '0')}';

    final time =
        '${dateTime.hour.toString().padLeft(2, '0')}:'
        '${dateTime.minute.toString().padLeft(2, '0')}';

    return '$date - $time';
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    final argument = _arguments;

    if (argument == null) {
      return const Scaffold(
        body: Center(
          child: Text(
            'اطلاعات ورزشکار و حرکت قابل بارگذاری نیست',
          ),
        ),
      );
    }

    final athlete =
        argument.athlete;

    final movement =
        argument.movement;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'جزئیات حرکت',
        ),
        centerTitle: true,
      ),
      body: ListView(
        padding:
            const EdgeInsets.all(16),
        children: [
          Container(
            width: double.infinity,
            padding:
                const EdgeInsets.all(24),
            decoration:
                BoxDecoration(
              color: Theme.of(context)
                  .colorScheme
                  .surfaceContainerHighest,
              borderRadius:
                  BorderRadius.circular(16),
            ),
            child: Column(
              children: [
                Icon(
                  measurementIcon(
                    movement.measurementType,
                  ),
                  size: 48,
                ),

                const SizedBox(
                  height: 16,
                ),

                Text(
                  movement.name,
                  textAlign:
                      TextAlign.center,
                  style:
                      const TextStyle(
                    fontSize: 24,
                    fontWeight:
                        FontWeight.bold,
                  ),
                ),

                const SizedBox(
                  height: 8,
                ),

                Text(
                  movement.bodyRegion,
                  style: Theme.of(
                    context,
                  )
                      .textTheme
                      .bodyMedium
                      ?.copyWith(
                        color:
                            Colors.grey.shade700,
                      ),
                ),

                const SizedBox(
                  height: 8,
                ),

                Text(
                  '${athlete.firstName} '
                  '${athlete.lastName}',
                  style: Theme.of(
                    context,
                  )
                      .textTheme
                      .bodySmall
                      ?.copyWith(
                        color: Theme.of(
                          context,
                        )
                            .colorScheme
                            .onSurfaceVariant,
                      ),
                ),
              ],
            ),
          ),

          const SizedBox(
            height: 20,
          ),

          const Text(
            'اطلاعات حرکت',
            style: TextStyle(
              fontSize: 18,
              fontWeight:
                  FontWeight.bold,
            ),
          ),

          const SizedBox(
            height: 12,
          ),

          _InfoRow(
            label: 'نوع معیار',
            value: measurementLabel(
              movement.measurementType,
            ),
          ),

          _InfoRow(
            label: 'واحد ثبت',
            value:
                movement.measurementUnit,
          ),

          _InfoRow(
            label: 'ناحیه بدن',
            value:
                movement.bodyRegion,
          ),

          const SizedBox(
            height: 20,
          ),

          if (movement
              .primaryMuscles
              .isNotEmpty) ...[
            const Text(
              'عضلات اصلی درگیر',
              style: TextStyle(
                fontSize: 18,
                fontWeight:
                    FontWeight.bold,
              ),
            ),

            const SizedBox(
              height: 12,
            ),

            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: movement
                  .primaryMuscles
                  .map<Widget>(
                    (muscle) => Chip(
                      label:
                          Text(muscle),
                    ),
                  )
                  .toList(),
            ),

            const SizedBox(
              height: 24,
            ),
          ],

          _buildLatestPerformanceCard(
            context,
          ),

          const SizedBox(
            height: 20,
          ),

          SizedBox(
            width:
                double.infinity,
            child:
                FilledButton.icon(
              onPressed: () async {
                await Navigator
                    .pushNamed(
                  context,
                  '/movement/performance',
                  arguments:
                      MovementPerformanceFormArguments(
                    athlete: athlete,
                    movement: movement,
                  ),
                );

                if (!mounted) {
                  return;
                }

                await _loadLatestPerformance();
              },
              icon: const Icon(
                Icons.add_chart,
              ),
              label: const Text(
                'ثبت عملکرد',
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLatestPerformanceCard(
    BuildContext context,
  ) {
    if (_loadingLatestPerformance) {
      return const Card(
        child: Padding(
          padding:
              EdgeInsets.all(20),
          child: Center(
            child:
                CircularProgressIndicator(),
          ),
        ),
      );
    }

    final performance =
        _latestPerformance;

    if (performance == null) {
      return Card(
        child: Padding(
          padding:
              const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [
              const Text(
                'آخرین عملکرد',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight:
                      FontWeight.bold,
                ),
              ),

              const SizedBox(
                height: 12,
              ),

              Text(
                'هنوز عملکردی برای این حرکت ثبت نشده است.',
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
      );
    }

    return Card(
      child: Padding(
        padding:
            const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Expanded(
                  child: Text(
                    'آخرین عملکرد',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight:
                          FontWeight.bold,
                    ),
                  ),
                ),

                Icon(
                  Icons.history,
                  color: Theme.of(context)
                      .colorScheme
                      .primary,
                ),
              ],
            ),

            const SizedBox(
              height: 16,
            ),

            Center(
              child: Text(
                '${formatPerformanceValue(performance.value)} '
                '${performanceUnit(performance.unit)}',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight:
                      FontWeight.bold,
                  color: Theme.of(context)
                      .colorScheme
                      .primary,
                ),
              ),
            ),

            const SizedBox(
              height: 12,
            ),

            Row(
              children: [
                const Icon(
                  Icons.schedule,
                  size: 18,
                ),

                const SizedBox(
                  width: 6,
                ),

                Text(
                  formatDateTime(
                    performance.recordedAt,
                  ),
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall,
                ),
              ],
            ),

            if (performance.note != null &&
                performance.note!
                    .trim()
                    .isNotEmpty) ...[
              const SizedBox(
                height: 12,
              ),

              const Divider(),

              const SizedBox(
                height: 8,
              ),

              Row(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  const Icon(
                    Icons.notes,
                    size: 18,
                  ),

                  const SizedBox(
                    width: 8,
                  ),

                  Expanded(
                    child: Text(
                      performance.note!,
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium,
                    ),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _InfoRow
    extends StatelessWidget {
  final String label;
  final String value;

  const _InfoRow({
    required this.label,
    required this.value,
  });

  @override
  Widget build(
    BuildContext context,
  ) {
    return Card(
      elevation: 0,
      margin:
          const EdgeInsets.only(
        bottom: 8,
      ),
      child: Padding(
        padding:
            const EdgeInsets.symmetric(
          horizontal: 14,
          vertical: 13,
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                label,
                style: Theme.of(
                  context,
                )
                    .textTheme
                    .bodyMedium,
              ),
            ),

            Text(
              value,
              style:
                  const TextStyle(
                fontWeight:
                    FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}