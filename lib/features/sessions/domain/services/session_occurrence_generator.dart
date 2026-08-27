import 'package:shamsi_date/shamsi_date.dart';

import '../models/session.dart';

class SessionOccurrenceGenerator {
  /// تعداد روزهایی که برای سانس‌های دائمی جلو می‌رویم.
  ///
  /// فعلاً یک سال آینده را پوشش می‌دهیم تا:
  /// - هفته
  /// - ماه
  /// - گزارش‌های آینده
  /// - حسابداری
  /// قابل محاسبه باشند.
  static const int defaultDays = 365;

  /// تمام occurrenceهای یک سانس را در بازه مشخص تولید می‌کند.
  ///
  /// برای سانس دائمی:
  /// بر اساس weekday، occurrence ساخته می‌شود.
  ///
  /// برای سانس موقتی:
  /// فقط همان تاریخ خودش تولید می‌شود.
  static List<SessionOccurrenceData> generate(
    Session session, {
    DateTime? from,
    DateTime? to,
  }) {
    final startDate = _normalizeDate(
      from ?? DateTime.now(),
    );

    final endDate = _normalizeDate(
      to ??
          startDate.add(
            const Duration(days: defaultDays),
          ),
    );

    if (endDate.isBefore(startDate)) {
      return [];
    }

    // -----------------------------
    // سانس موقتی
    // -----------------------------

    if (!session.isRecurring) {
      final date = _parseSessionDate(
        session.date,
      );

      if (date == null) {
        return [];
      }

      final normalized = _normalizeDate(date);

      if (normalized.isBefore(startDate) ||
          normalized.isAfter(endDate)) {
        return [];
      }

      return [
        _buildOccurrence(
          session,
          normalized,
        ),
      ];
    }

    // -----------------------------
    // سانس دائمی
    // -----------------------------

    if (session.weekday == null) {
      return [];
    }

    final occurrences =
        <SessionOccurrenceData>[];

    var current = startDate;

    while (!current.isAfter(endDate)) {
      if (current.weekday == session.weekday) {
        occurrences.add(
          _buildOccurrence(
            session,
            current,
          ),
        );
      }

      current = current.add(
        const Duration(days: 1),
      );
    }

    return occurrences;
  }

  /// occurrenceهای ۷ روز آینده
  static List<SessionOccurrenceData> generateNextSevenDays(
    Session session,
  ) {
    final now = _normalizeDate(
      DateTime.now(),
    );

    final end = now.add(
      const Duration(days: 6),
    );

    return generate(
      session,
      from: now,
      to: end,
    );
  }

  /// occurrenceهای ماه شمسی جاری
  ///
  /// مثال:
  /// ۱۴۰۵/۰۴/۰۱ تا ۱۴۰۵/۰۴/۳۱
  static List<SessionOccurrenceData> generateCurrentJalaliMonth(
    Session session,
  ) {
    final today =
        Jalali.fromDateTime(
      DateTime.now(),
    );

    final firstDay =
        Jalali(
      today.year,
      today.month,
      1,
    ).toDateTime();

    final daysInMonth =
        _daysInJalaliMonth(
      today.year,
      today.month,
    );

    final lastDay =
        Jalali(
      today.year,
      today.month,
      daysInMonth,
    ).toDateTime();

    return generate(
      session,
      from: firstDay,
      to: lastDay,
    );
  }

  /// occurrenceهای هفته جاری شمسی/تقویمی پروژه
  ///
  /// شروع هفته = شنبه
  /// پایان هفته = جمعه
  static List<SessionOccurrenceData> generateCurrentWeek(
    Session session,
  ) {
    final today =
        _normalizeDate(
      DateTime.now(),
    );

    // DateTime:
    // Monday = 1
    // ...
    // Saturday = 6
    // Sunday = 7
    //
    // برای رسیدن به شنبه:
    // اگر شنبه باشد => 0
    // یکشنبه => 1
    // دوشنبه => 2
    // ...
    final daysFromSaturday =
        (today.weekday + 1) % 7;

    final saturday =
        today.subtract(
      Duration(
        days: daysFromSaturday,
      ),
    );

    final friday =
        saturday.add(
      const Duration(days: 6),
    );

    return generate(
      session,
      from: saturday,
      to: friday,
    );
  }

  // --------------------------------------------------
  // Helpers
  // --------------------------------------------------

  static SessionOccurrenceData _buildOccurrence(
    Session session,
    DateTime date,
  ) {
    return SessionOccurrenceData(
      sessionId: session.id!,
      occurrenceDate: date,
      startTime: session.startTime,
      endTime: session.endTime,
      status: 'scheduled',
    );
  }

  static DateTime _normalizeDate(
    DateTime date,
  ) {
    return DateTime(
      date.year,
      date.month,
      date.day,
    );
  }

  /// تاریخ ذخیره‌شده در Session را از فرمت شمسی:
  ///
  /// 1405/04/15
  ///
  /// به DateTime تبدیل می‌کند.
  static DateTime? _parseSessionDate(
    String value,
  ) {
    final normalized =
        value
            .trim()
            .replaceAll(
              '۰',
              '0',
            )
            .replaceAll(
              '۱',
              '1',
            )
            .replaceAll(
              '۲',
              '2',
            )
            .replaceAll(
              '۳',
              '3',
            )
            .replaceAll(
              '۴',
              '4',
            )
            .replaceAll(
              '۵',
              '5',
            )
            .replaceAll(
              '۶',
              '6',
            )
            .replaceAll(
              '۷',
              '7',
            )
            .replaceAll(
              '۸',
              '8',
            )
            .replaceAll(
              '۹',
              '9',
            );

    final parts =
        normalized.split('/');

    if (parts.length != 3) {
      return null;
    }

    final year =
        int.tryParse(parts[0]);

    final month =
        int.tryParse(parts[1]);

    final day =
        int.tryParse(parts[2]);

    if (year == null ||
        month == null ||
        day == null) {
      return null;
    }

    try {
      return Jalali(
        year,
        month,
        day,
      ).toDateTime();
    } catch (_) {
      return null;
    }
  }

  static int _daysInJalaliMonth(
    int year,
    int month,
  ) {
    if (month <= 6) {
      return 31;
    }

    if (month <= 11) {
      return 30;
    }

    final isLeap =
        Jalali(year).isLeapYear();

    return isLeap ? 30 : 29;
  }
}

/// نتیجه محاسبه یک occurrence واقعی از یک Session
///
/// فعلاً فقط در domain نگه داشته می‌شود.
/// در قدم بعدی همین ساختار را به جدول
/// session_occurrences متصل می‌کنیم.
class SessionOccurrenceData {
  final String sessionId;

  final DateTime occurrenceDate;

  final String startTime;

  final String endTime;

  final String status;

  const SessionOccurrenceData({
    required this.sessionId,
    required this.occurrenceDate,
    required this.startTime,
    required this.endTime,
    required this.status,
  });
}