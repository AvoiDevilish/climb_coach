import 'package:flutter/material.dart';

import '../../../domain/models/athlete_history_item.dart';

class AthleteHistoryTimeline extends StatelessWidget {
  final List<AthleteHistoryItem> history;

  final bool loading;

  final String? error;

  const AthleteHistoryTimeline({
    super.key,
    required this.history,
    this.loading = false,
    this.error,
  });

  String _attendanceStatusLabel(
    String? status,
  ) {
    switch (status) {
      case 'present':
        return 'حاضر';

      case 'absent':
        return 'غایب';

      case 'pending':
        return 'ثبت نشده';

      case 'late':
        return 'با تأخیر';

      default:
        return status ?? 'ثبت نشده';
    }
  }

  IconData _attendanceIcon(
    String? status,
  ) {
    switch (status) {
      case 'present':
        return Icons.check_circle_outline;

      case 'absent':
        return Icons.cancel_outlined;

      case 'late':
        return Icons.schedule;

      default:
        return Icons.help_outline;
    }
  }

  String _memberTypeLabel(
    String type,
  ) {
    switch (type) {
      case 'regular':
        return 'عضو عادی';

      case 'guest':
        return 'مهمان';

      case 'makeup':
        return 'جلسه جبرانی';

      default:
        return type;
    }
  }

  String _attendanceTypeLabel(
    String? type,
  ) {
    switch (type) {
      case 'normal':
        return 'عادی';

      case 'makeup':
        return 'جبرانی';

      case 'guest':
        return 'مهمان';

      default:
        return type ?? '';
    }
  }

  String _weekdayLabel(
    int? weekday,
  ) {
    switch (weekday) {
      case DateTime.saturday:
        return 'شنبه';

      case DateTime.sunday:
        return 'یکشنبه';

      case DateTime.monday:
        return 'دوشنبه';

      case DateTime.tuesday:
        return 'سه‌شنبه';

      case DateTime.wednesday:
        return 'چهارشنبه';

      case DateTime.thursday:
        return 'پنجشنبه';

      case DateTime.friday:
        return 'جمعه';

      default:
        return '';
    }
  }

  String _formatDate(
    AthleteHistoryItem item,
  ) {
    final date = item.date.trim();

    if (date.isNotEmpty) {
      return date;
    }

    final weekday = _weekdayLabel(
      item.weekday,
    );

    if (weekday.isNotEmpty) {
      return 'هر $weekday';
    }

    return 'تاریخ نامشخص';
  }

  String _formatTime(
    String time,
  ) {
    final value = time.trim();

    if (value.isEmpty) {
      return '';
    }

    final parts = value.split(':');

    if (parts.length < 2) {
      return value;
    }

    final hour =
        int.tryParse(parts[0]);

    final minute =
        int.tryParse(parts[1]);

    if (hour == null ||
        minute == null) {
      return value;
    }

    return '${_toPersianDigits(
      hour.toString().padLeft(2, '0'),
    )}:${_toPersianDigits(
      minute.toString().padLeft(2, '0'),
    )}';
  }

  String _toPersianDigits(
    String value,
  ) {
    const english = '0123456789';

    const persian = '۰۱۲۳۴۵۶۷۸۹';

    var result = value;

    for (var i = 0; i < english.length; i++) {
      result = result.replaceAll(
        english[i],
        persian[i],
      );
    }

    return result;
  }

  Widget _buildHistoryItem(
    BuildContext context,
    AthleteHistoryItem item,
    int index,
  ) {
    final isLast =
        index == history.length - 1;

    final statusColor =
        item.attendanceStatus == 'present'
            ? Colors.green
            : item.attendanceStatus == 'absent'
                ? Colors.red
                : Theme.of(context)
                    .colorScheme
                    .primary;

    final formattedStartTime =
        _formatTime(item.startTime);

    final formattedEndTime =
        _formatTime(item.endTime);

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment:
            CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            width: 34,
            child: Column(
              children: [
                Container(
                  width: 14,
                  height: 14,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: statusColor,
                  ),
                ),
                if (!isLast)
                  Expanded(
                    child: Container(
                      width: 2,
                      color: Theme.of(context)
                          .colorScheme
                          .outlineVariant,
                    ),
                  ),
              ],
            ),
          ),

          const SizedBox(width: 10),

          Expanded(
            child: Card(
              margin: const EdgeInsets.only(
                bottom: 12,
              ),
              elevation: 0,
              child: Padding(
                padding:
                    const EdgeInsets.all(14),
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            item.sessionTitle,
                            style:
                                const TextStyle(
                              fontSize: 16,
                              fontWeight:
                                  FontWeight.bold,
                            ),
                          ),
                        ),
                        if (item.attendanceStatus !=
                            null)
                          Icon(
                            _attendanceIcon(
                              item.attendanceStatus,
                            ),
                            color:
                                statusColor,
                            size: 22,
                          ),
                      ],
                    ),

                    const SizedBox(height: 8),

                    Row(
                      children: [
                        const Icon(
                          Icons.calendar_today_outlined,
                          size: 16,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          _formatDate(item),
                        ),
                      ],
                    ),

                    if (formattedStartTime
                            .isNotEmpty ||
                        formattedEndTime
                            .isNotEmpty) ...[
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          const Icon(
                            Icons.access_time,
                            size: 16,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            '$formattedStartTime - '
                            '$formattedEndTime',
                          ),
                        ],
                      ),
                    ],

                    const SizedBox(height: 8),

                    Wrap(
                      spacing: 6,
                      runSpacing: 6,
                      children: [
                        if (item.memberType
                            .trim()
                            .isNotEmpty)
                          Chip(
                            avatar:
                                const Icon(
                              Icons.person_outline,
                              size: 16,
                            ),
                            label: Text(
                              _memberTypeLabel(
                                item.memberType,
                              ),
                            ),
                            visualDensity:
                                VisualDensity.compact,
                          ),

                        if (item.attendanceType !=
                                null &&
                            _attendanceTypeLabel(
                              item.attendanceType,
                            ).isNotEmpty)
                          Chip(
                            avatar:
                                const Icon(
                              Icons.label_outline,
                              size: 16,
                            ),
                            label: Text(
                              _attendanceTypeLabel(
                                item.attendanceType,
                              ),
                            ),
                            visualDensity:
                                VisualDensity.compact,
                          ),

                        if (item.attendanceStatus !=
                            null)
                          Chip(
                            avatar: Icon(
                              _attendanceIcon(
                                item.attendanceStatus,
                              ),
                              size: 16,
                            ),
                            label: Text(
                              _attendanceStatusLabel(
                                item.attendanceStatus,
                              ),
                            ),
                            visualDensity:
                                VisualDensity.compact,
                          ),
                      ],
                    ),

                    if (item.membershipNote !=
                            null &&
                        item.membershipNote!
                            .trim()
                            .isNotEmpty) ...[
                      const SizedBox(height: 8),
                      Text(
                        'یادداشت عضویت: '
                        '${item.membershipNote}',
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall,
                      ),
                    ],

                    if (item.attendanceNote !=
                            null &&
                        item.attendanceNote!
                            .trim()
                            .isNotEmpty) ...[
                      const SizedBox(height: 4),
                      Text(
                        'یادداشت حضور: '
                        '${item.attendanceNote}',
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall,
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    if (loading) {
      return const Card(
        child: Padding(
          padding: EdgeInsets.all(24),
          child: Center(
            child:
                CircularProgressIndicator(),
          ),
        ),
      );
    }

    if (error != null) {
      return Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Text(
            error!,
            style: TextStyle(
              color: Theme.of(context)
                  .colorScheme
                  .error,
            ),
          ),
        ),
      );
    }

    if (history.isEmpty) {
      return Card(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              Icon(
                Icons.history,
                size: 42,
                color: Theme.of(context)
                    .colorScheme
                    .outline,
              ),
              const SizedBox(height: 12),
              const Text(
                'هنوز سابقه‌ای برای این ورزشکار ثبت نشده است.',
                textAlign:
                    TextAlign.center,
              ),
            ],
          ),
        ),
      );
    }

    return Column(
      crossAxisAlignment:
          CrossAxisAlignment.start,
      children: [
        const Text(
          'تاریخچه فعالیت',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 12),

        ...List.generate(
          history.length,
          (index) => _buildHistoryItem(
            context,
            history[index],
            index,
          ),
        ),
      ],
    );
  }
}