import 'dart:async';

import 'package:flutter/material.dart';

import '../../../../core/calendar/calendar_helper.dart';
import '../../../../core/database/database_helper.dart';
import '../../../../core/database/tables.dart';
import '../../../../core/design/app_spacing.dart';
import '../../../../core/design/app_text_styles.dart';
import '../../../../core/utils/date_helper.dart';

class DashboardCurrentSession extends StatefulWidget {
  const DashboardCurrentSession({
    super.key,
  });

  @override
  State<DashboardCurrentSession> createState() =>
      _DashboardCurrentSessionState();
}

class _DashboardCurrentSessionState
    extends State<DashboardCurrentSession> {
  Timer? _timer;

  bool _loading = true;

  Map<String, dynamic>? _currentSession;

  Map<String, dynamic>? _nextSession;

  @override
  void initState() {
    super.initState();

    _loadSessions();

    _timer = Timer.periodic(
      const Duration(seconds: 30),
      (_) => _loadSessions(),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  Future<void> _loadSessions() async {
    final db = await DatabaseHelper.instance.database;

    final now = DateTime.now();

    final today = CalendarHelper.normalizeDate(
      CalendarHelper.toPersianDate(now),
    );

    final result = await db.query(
      Tables.sessions,
      where: 'is_deleted = ?',
      whereArgs: [0],
      orderBy: 'start_time ASC',
    );

    final todaySessions = result.where((row) {
      final isRecurring =
          (row['is_recurring'] ?? 0) == 1;

      if (isRecurring) {
        return row['weekday'] == now.weekday;
      }

      return CalendarHelper.normalizeDate(
            row['date']?.toString() ?? '',
          ) ==
          today;
    }).toList();

    Map<String, dynamic>? current;
    Map<String, dynamic>? next;

    for (final row in todaySessions) {
      final start = _parseTime(row['start_time']);
      final end = _parseTime(row['end_time']);

      if (start == null || end == null) {
        continue;
      }

      final startDateTime = DateTime(
        now.year,
        now.month,
        now.day,
        start.hour,
        start.minute,
      );

      final endDateTime = DateTime(
        now.year,
        now.month,
        now.day,
        end.hour,
        end.minute,
      );

      if (!now.isBefore(startDateTime) &&
          now.isBefore(endDateTime)) {
        current = row;
        continue;
      }

      if (startDateTime.isAfter(now)) {
        next = row;
        break;
      }
    }

    if (!mounted) return;

    setState(() {
      _currentSession = current;
      _nextSession = next;
      _loading = false;
    });
  }

  TimeOfDay? _parseTime(dynamic value) {
    if (value == null) return null;

    final text = value.toString().trim();

    final parts = text.split(':');

    if (parts.length < 2) {
      return null;
    }

    final hour = int.tryParse(parts[0]);
    final minute = int.tryParse(parts[1]);

    if (hour == null || minute == null) {
      return null;
    }

    return TimeOfDay(
      hour: hour,
      minute: minute,
    );
  }

  Duration _remainingTime(
    Map<String, dynamic> session,
  ) {
    final end = _parseTime(
      session['end_time'],
    );

    if (end == null) {
      return Duration.zero;
    }

    final now = DateTime.now();

    final endDateTime = DateTime(
      now.year,
      now.month,
      now.day,
      end.hour,
      end.minute,
    );

    final remaining =
        endDateTime.difference(now);

    return remaining.isNegative
        ? Duration.zero
        : remaining;
  }

  Duration _timeUntil(
    Map<String, dynamic> session,
  ) {
    final start = _parseTime(
      session['start_time'],
    );

    if (start == null) {
      return Duration.zero;
    }

    final now = DateTime.now();

    final startDateTime = DateTime(
      now.year,
      now.month,
      now.day,
      start.hour,
      start.minute,
    );

    final remaining =
        startDateTime.difference(now);

    return remaining.isNegative
        ? Duration.zero
        : remaining;
  }

  String _formatDuration(
    Duration duration,
  ) {
    final totalMinutes =
        duration.inMinutes;

    final hours =
        totalMinutes ~/ 60;

    final minutes =
        totalMinutes % 60;

    if (hours > 0) {
      return DateHelper.persianNumbers(
        '$hours ساعت و $minutes دقیقه',
      );
    }

    return DateHelper.persianNumbers(
      '$minutes دقیقه',
    );
  }

  Widget _buildCurrentSession(
    BuildContext context,
  ) {
    final session = _currentSession!;

    final colorScheme =
        Theme.of(context).colorScheme;

    final background =
        Colors.green.shade50;

    final foreground =
        Colors.green.shade800;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(
        AppSpacing.md,
      ),
      decoration: BoxDecoration(
        borderRadius:
            BorderRadius.circular(14),
        color: background,
        border: Border.all(
          color: Colors.green.shade200,
        ),
      ),
      child: Row(
        children: [
          Icon(
            Icons.play_circle_outline,
            color: foreground,
            size: 28,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Text(
                  'سانس در حال برگزاری',
                  style:
                      AppTextStyles.body.copyWith(
                    color: foreground,
                    fontWeight:
                        FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  session['title']
                          ?.toString() ??
                      '',
                  style:
                      AppTextStyles.body.copyWith(
                    color: colorScheme
                        .onSurface,
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment:
                CrossAxisAlignment.end,
            children: [
              const Text(
                'مانده',
              ),
              const SizedBox(height: 2),
              Text(
                _formatDuration(
                  _remainingTime(session),
                ),
                style:
                    AppTextStyles.body.copyWith(
                  color: foreground,
                  fontWeight:
                      FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildNextSession(
    BuildContext context,
  ) {
    final session = _nextSession!;

    final foreground =
        Colors.orange.shade800;

    final background =
        Colors.orange.shade50;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(
        AppSpacing.md,
      ),
      decoration: BoxDecoration(
        borderRadius:
            BorderRadius.circular(14),
        color: background,
        border: Border.all(
          color: Colors.orange.shade200,
        ),
      ),
      child: Row(
        children: [
          Icon(
            Icons.upcoming_outlined,
            color: foreground,
            size: 26,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Text(
                  'سانس بعدی',
                  style:
                      AppTextStyles.body.copyWith(
                    color: foreground,
                    fontWeight:
                        FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  session['title']
                          ?.toString() ??
                      '',
                  style:
                      AppTextStyles.body,
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment:
                CrossAxisAlignment.end,
            children: [
              Text(
                '${session['start_time']}',
                style:
                    AppTextStyles.body.copyWith(
                  color: foreground,
                  fontWeight:
                      FontWeight.bold,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                'تا شروع: '
                '${_formatDuration(
                  _timeUntil(session),
                )}',
                style:
                    AppTextStyles.body.copyWith(
                  color: foreground,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const SizedBox.shrink();
    }

    if (_currentSession == null &&
        _nextSession == null) {
      return const SizedBox.shrink();
    }

    return Column(
      children: [
        if (_currentSession != null)
          _buildCurrentSession(context),

        if (_currentSession != null &&
            _nextSession != null)
          const SizedBox(height: 10),

        if (_nextSession != null)
          _buildNextSession(context),
      ],
    );
  }
}