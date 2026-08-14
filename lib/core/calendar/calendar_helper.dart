import 'package:shamsi_date/shamsi_date.dart';

class CalendarHelper {


  static List<DateTime> nextSevenDays() {

    final now = DateTime.now();

    return List.generate(
      7,
      (index) {

        return DateTime(
          now.year,
          now.month,
          now.day + index,
        );

      },
    );

  }



  static String weekdayName(
    int weekday,
  ) {

    switch (weekday) {

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

      case DateTime.saturday:
        return 'شنبه';

      case DateTime.sunday:
        return 'یکشنبه';

      default:
        return '';

    }

  }



  static String toPersianDate(
  DateTime date,
  ) {

    final jalali =
        Jalali.fromDateTime(date);


    final month =
        jalali.month.toString().padLeft(2, '0');

    final day =
        jalali.day.toString().padLeft(2, '0');


    return
        '${jalali.year}/$month/$day';

  }


  static String normalizeDate(
  String value,
  ) {

    return value
        .trim()
        .replaceAll(
          RegExp(r'\s+'),
          '',
        )
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
  }



  static bool isToday(
    DateTime date,
  ) {

    final now = DateTime.now();

    return date.year == now.year &&
        date.month == now.month &&
        date.day == now.day;

  }


}