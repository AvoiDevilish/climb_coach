import 'package:flutter/material.dart';

import '../../domain/models/session.dart';
import '../controllers/session_controller.dart';
import '../pages/session_detail_page.dart';

import '../../../../core/calendar/calendar_helper.dart';
import '../../../../core/design/app_spacing.dart';

class TodaySessionsPage extends StatefulWidget {
  const TodaySessionsPage({
    super.key,
  });

  @override
  State<TodaySessionsPage> createState() =>
      _TodaySessionsPageState();
}

class _TodaySessionsPageState
    extends State<TodaySessionsPage> {
  final SessionController controller =
      SessionController();

  @override
  void initState() {
    super.initState();

    controller.loadSessions();

    controller.addListener(_refresh);
  }

  void _refresh() {
    if (!mounted) return;

    setState(() {});
  }

  List<Session> get todaySessions {
    final now = DateTime.now();

    final today =
        CalendarHelper.normalizeDate(
      CalendarHelper.toPersianDate(now),
    );

    return controller.sessions
        .where((session) {
      if (session.isRecurring) {
        return session.weekday ==
            now.weekday;
      }

      return CalendarHelper.normalizeDate(
            session.date,
          ) ==
          today;
    }).toList();
  }

  @override
  void dispose() {
    controller.removeListener(_refresh);
    controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final sessions =
        todaySessions;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'سانس‌های امروز',
        ),
        centerTitle: true,
      ),
      body: sessions.isEmpty
          ? const Center(
              child: Text(
                'امروز سانسی ثبت نشده است.',
              ),
            )
          : GridView.builder(
              padding:
                  const EdgeInsets.all(
                AppSpacing.md,
              ),
              gridDelegate:
                  const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 280,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                childAspectRatio: 1.45,
              ),
              itemCount: sessions.length,
              itemBuilder:
                  (context, index) {
                final session =
                    sessions[index];

                return _TodaySessionCard(
                  session: session,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                            SessionDetailPage(
                          session: session,
                        ),
                      ),
                    );
                  },
                );
              },
            ),
    );
  }
}

class _TodaySessionCard
    extends StatelessWidget {
  final Session session;
  final VoidCallback onTap;

  const _TodaySessionCard({
    required this.session,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();

    final start =
        _parseTime(session.startTime);

    final end =
        _parseTime(session.endTime);

    bool active = false;

    if (start != null && end != null) {
      final startDate = DateTime(
        now.year,
        now.month,
        now.day,
        start.hour,
        start.minute,
      );

      final endDate = DateTime(
        now.year,
        now.month,
        now.day,
        end.hour,
        end.minute,
      );

      active =
          !now.isBefore(startDate) &&
          now.isBefore(endDate);
    }

    final color =
        active
            ? Colors.green
            : Theme.of(context)
                .colorScheme
                .primary;

    return InkWell(
      onTap: onTap,
      borderRadius:
          BorderRadius.circular(16),
      child: Container(
        padding:
            const EdgeInsets.all(14),
        decoration: BoxDecoration(
          borderRadius:
              BorderRadius.circular(16),
          color: color.withValues(
            alpha: 0.08,
          ),
          border: Border.all(
            color: color.withValues(
              alpha: 0.30,
            ),
          ),
        ),
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    session.title,
                    maxLines: 2,
                    overflow:
                        TextOverflow.ellipsis,
                    style:
                        const TextStyle(
                      fontWeight:
                          FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
                Icon(
                  active
                      ? Icons.play_circle
                      : Icons.schedule,
                  color: color,
                  size: 22,
                ),
              ],
            ),
            const Spacer(),
            Text(
              '${session.startTime} تا ${session.endTime}',
              style:
                  TextStyle(
                color: color,
                fontWeight:
                    FontWeight.bold,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              active
                  ? 'در حال برگزاری'
                  : 'مشاهده جزئیات',
              style:
                  const TextStyle(
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }

  static TimeOfDay? _parseTime(
    String value,
  ) {
    final parts =
        value.trim().split(':');

    if (parts.length < 2) {
      return null;
    }

    final hour =
        int.tryParse(parts[0]);

    final minute =
        int.tryParse(parts[1]);

    if (hour == null ||
        minute == null) {
      return null;
    }

    return TimeOfDay(
      hour: hour,
      minute: minute,
    );
  }
}
