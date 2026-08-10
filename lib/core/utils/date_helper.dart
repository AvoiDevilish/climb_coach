class DateHelper {
  static const List<String> weekDays = [
    'دوشنبه',
    'سه‌شنبه',
    'چهارشنبه',
    'پنجشنبه',
    'جمعه',
    'شنبه',
    'یکشنبه',
  ];


  static String weekDayName(DateTime date) {
    return weekDays[date.weekday - 1];
  }


  static String persianDate(DateTime date) {

    // تبدیل ساده جلالی
    // بدون وابستگی به پکیج خارجی

    final gregorianYear = date.year;
    final gregorianMonth = date.month;
    final gregorianDay = date.day;


    final result = _toJalali(
      gregorianYear,
      gregorianMonth,
      gregorianDay,
    );


    return persianNumbers(
      '${result[2]} ${_monthName(result[1])} ${result[0]}',
    );
  }


  static List<int> _toJalali(
    int gy,
    int gm,
    int gd,
  ) {

    final gDayNo =
        365 * (gy - 1600) +
        ((gy - 1600 + 3) ~/ 4) -
        ((gy - 1600 + 99) ~/ 100) +
        ((gy - 1600 + 399) ~/ 400);


    final gMonthDays = [
      0,
      31,
      59,
      90,
      120,
      151,
      181,
      212,
      243,
      273,
      304,
      334,
    ];


    var dayNo =
        gDayNo +
        gMonthDays[gm - 1] +
        gd -
        1;


    if (gm > 2 &&
        ((gy % 4 == 0 &&
                gy % 100 != 0) ||
            gy % 400 == 0)) {
      dayNo++;
    }


    var jDayNo = dayNo - 79;


    final jNp = jDayNo ~/ 12053;

    jDayNo %= 12053;


    var jy = 979 + 33 * jNp + 4 * (jDayNo ~/ 1461);

    jDayNo %= 1461;


    if (jDayNo >= 366) {
      jy += (jDayNo - 1) ~/ 365;
      jDayNo = (jDayNo - 1) % 365;
    }


    final jm =
        jDayNo < 186
            ? 1 + jDayNo ~/ 31
            : 7 + (jDayNo - 186) ~/ 30;


    final jd =
        1 +
        (jDayNo < 186
            ? jDayNo % 31
            : (jDayNo - 186) % 30);


    return [
      jy,
      jm,
      jd,
    ];
  }


  static String _monthName(int month) {

    const months = [
      '',
      'فروردین',
      'اردیبهشت',
      'خرداد',
      'تیر',
      'مرداد',
      'شهریور',
      'مهر',
      'آبان',
      'آذر',
      'دی',
      'بهمن',
      'اسفند',
    ];


    return months[month];
  }

  static String persianNumbers(String value) {
    const english = [
      '0',
      '1',
      '2',
      '3',
      '4',
      '5',
      '6',
      '7',
      '8',
      '9',
    ];

    const persian = [
      '۰',
      '۱',
      '۲',
      '۳',
      '۴',
      '۵',
      '۶',
      '۷',
      '۸',
      '۹',
    ];

    for (int i = 0; i < english.length; i++) {
        value = value.replaceAll(
        english[i],
        persian[i],
        );
    }

    return value;
  }

}