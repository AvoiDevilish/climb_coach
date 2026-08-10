class NumberHelper {


  static const _english = [
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


  static const _persian = [
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



  static String toPersian(
    dynamic value,
  ) {

    if (value == null) {
      return '';
    }


    String result =
        value.toString();


    for (int i = 0; i < _english.length; i++) {

      result =
          result.replaceAll(
            _english[i],
            _persian[i],
          );

    }


    return result;

  }




  static String toEnglish(
    String value,
  ) {

    String result = value;


    for (int i = 0; i < _persian.length; i++) {

      result =
          result.replaceAll(
            _persian[i],
            _english[i],
          );

    }


    return result;

  }




  static int parseInt(
    String value,
  ) {

    return int.tryParse(
      toEnglish(value),
    ) ?? 0;

  }



  static double parseDouble(
    String value,
  ) {

    return double.tryParse(
      toEnglish(value),
    ) ?? 0;

  }


}