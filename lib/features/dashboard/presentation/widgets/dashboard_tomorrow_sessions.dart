import 'dart:async';

import 'package:flutter/material.dart';

import '../../../sessions/domain/models/session.dart';
import '../../../sessions/presentation/controllers/session_controller.dart';

import '../../../../core/calendar/calendar_helper.dart';
import '../../../../core/design/app_spacing.dart';
import '../../../../core/design/app_text_styles.dart';
import '../../../../core/utils/date_helper.dart';
import '../../../../core/widgets/uog_card.dart';

class DashboardTomorrowSessions extends StatefulWidget {
  const DashboardTomorrowSessions({
    super.key,
  });

  @override
  State<DashboardTomorrowSessions> createState() =>
      _DashboardTomorrowSessionsState();
}

class _DashboardTomorrowSessionsState
    extends State<DashboardTomorrowSessions> {
  final SessionController controller =
      SessionController();

  Timer? _timer;

  bool _loading = true;

  bool _expanded = false;

  @override
  void initState() {
    super.initState();

    _load();

    _timer = Timer.periodic(
      const Duration(seconds: 30),
      (_) => _load(),
    );
  }

  Future<void> _load() async {
    await controller.loadSessions();

    if (!mounted) return;

    setState(() {
      _loading = false;
    });
  }

  DateTime get _tomorrow {
    final now = DateTime.now();

    return DateTime(
      now.year,
      now.month,
      now.day + 1,
    );
  }

  List<Session> get tomorrowSessions {
    final tomorrow = _tomorrow;

    final tomorrowPersianDate =
        CalendarHelper.normalizeDate(
      CalendarHelper.toPersianDate(
        tomorrow,
      ),
    );

    return controller.sessions
        .where((session) {
          if (session.isRecurring) {
            return session.weekday ==
                tomorrow.weekday;
          }

          if (session.date.trim().isEmpty) {
            return false;
          }

          return CalendarHelper.normalizeDate(
                session.date,
              ) ==
              tomorrowPersianDate;
        })
        .toList()
      ..sort(
        (a, b) => a.startTime.compareTo(
          b.startTime,
        ),
      );
  }

  String _persianNumbers(String value) {
    return DateHelper.persianNumbers(
      value,
    );
  }

  Color _sessionColor(
    int index,
  ) {
    const colors = [
      Colors.blue,
      Colors.orange,
      Colors.green,
      Colors.purple,
    ];

    return colors[index % colors.length];
  }

  Widget _buildSessionItem(
    BuildContext context,
    Session session,
    int index,
  ) {
    final color =
        _sessionColor(index);

    return Container(
      margin: const EdgeInsets.only(
        bottom: 8,
      ),
      padding: const EdgeInsets.all(
        AppSpacing.sm,
      ),
      decoration: BoxDecoration(
        color: color.withValues(
          alpha: 0.07,
        ),
        borderRadius:
            BorderRadius.circular(12),
        border: Border.all(
          color: color.withValues(
            alpha: 0.18,
          ),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 10,
            height: 10,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
          ),

          const SizedBox(width: 10),

          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Text(
                  session.title,
                  maxLines: 1,
                  overflow:
                      TextOverflow.ellipsis,
                  style:
                      AppTextStyles.body.copyWith(
                    fontWeight:
                        FontWeight.w600,
                  ),
                ),

                const SizedBox(height: 3),

                Text(
                  session.club?.trim().isNotEmpty ==
                          true
                      ? session.club!
                      : 'سانس تمرینی',
                  maxLines: 1,
                  overflow:
                      TextOverflow.ellipsis,
                  style:
                      AppTextStyles.body.copyWith(
                    color: Theme.of(context)
                        .colorScheme
                        .onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(width: 12),

          Column(
            crossAxisAlignment:
                CrossAxisAlignment.end,
            children: [
              Text(
                _persianNumbers(
                  session.startTime,
                ),
                style:
                    AppTextStyles.body.copyWith(
                  color: color,
                  fontWeight:
                      FontWeight.bold,
                ),
              ),

              const SizedBox(height: 2),

              Text(
                _persianNumbers(
                  session.endTime,
                ),
                style:
                    AppTextStyles.body.copyWith(
                  color: Theme.of(context)
                      .colorScheme
                      .onSurfaceVariant,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();

    controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final sessions =
        tomorrowSessions;

    final tomorrowName =
        CalendarHelper.weekdayName(
      _tomorrow.weekday,
    );

    final countText =
        _persianNumbers(
      sessions.length.toString(),
    );

    return UOGCard(
      child: Column(
        children: [
          InkWell(
            borderRadius:
                BorderRadius.circular(16),
            onTap: () {
              setState(() {
                _expanded = !_expanded;
              });
            },
            child: Padding(
              padding:
                  const EdgeInsets.all(
                AppSpacing.md,
              ),
              child: Row(
                children: [
                  Container(
                    width: 42,
                    height: 42,
                    alignment:
                        Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.blue
                          .withValues(
                        alpha: 0.10,
                      ),
                      borderRadius:
                          BorderRadius.circular(
                        12,
                      ),
                    ),
                    child: const Icon(
                      Icons.event_available_outlined,
                      color: Colors.blue,
                    ),
                  ),

                  const SizedBox(width: 12),

                  Expanded(
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,
                      children: [
                        Text(
                          'سانس‌های فردا',
                          style:
                              AppTextStyles.headline,
                        ),
                        const SizedBox(height: 3),
                        Text(
                          _loading
                              ? 'در حال بروزرسانی...'
                              : '$tomorrowName  '
                                '$countText سانس',
                          style:
                              AppTextStyles.body
                                  .copyWith(
                            color: Theme.of(context)
                                .colorScheme
                                .onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ),

                  Icon(
                    _expanded
                        ? Icons
                            .keyboard_arrow_up_rounded
                        : Icons
                            .keyboard_arrow_down_rounded,
                    size: 26,
                    color: Colors.blue,
                  ),
                ],
              ),
            ),
          ),

          AnimatedCrossFade(
            duration:
                const Duration(
              milliseconds: 220,
            ),
            crossFadeState: _expanded
                ? CrossFadeState.showSecond
                : CrossFadeState.showFirst,
            firstChild:
                const SizedBox.shrink(),
            secondChild: Padding(
              padding:
                  const EdgeInsets.fromLTRB(
                AppSpacing.md,
                0,
                AppSpacing.md,
                AppSpacing.md,
              ),
              child: Column(
                children: [
                  const Divider(
                    height: 1,
                  ),

                  const SizedBox(height: 12),

                  if (_loading)
                    const Padding(
                      padding:
                          EdgeInsets.symmetric(
                        vertical: 12,
                      ),
                      child:
                          CircularProgressIndicator(
                        strokeWidth: 2,
                      ),
                    )
                  else if (sessions.isEmpty)
                    Container(
                      width: double.infinity,
                      padding:
                          const EdgeInsets.symmetric(
                        vertical: 16,
                        horizontal: 12,
                      ),
                      decoration: BoxDecoration(
                        color: Theme.of(context)
                            .colorScheme
                            .surfaceContainerHighest,
                        borderRadius:
                            BorderRadius.circular(
                          12,
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons
                                .event_busy_outlined,
                            color: Theme.of(context)
                                .colorScheme
                                .onSurfaceVariant,
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              'برای فردا سانسی ثبت نشده است.',
                              style:
                                  AppTextStyles.body,
                            ),
                          ),
                        ],
                      ),
                    )
                  else
                    Column(
                      children: [
                        for (
                          var i = 0;
                          i < sessions.length;
                          i++
                        )
                          _buildSessionItem(
                            context,
                            sessions[i],
                            i,
                          ),
                      ],
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}