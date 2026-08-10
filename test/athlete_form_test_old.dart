import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:climb_coach/features/athletes/presentation/pages/athlete_form_page.dart';


void main() {

  testWidgets(
    'Athlete form loads',
    (
      WidgetTester tester,
    ) async {

      await tester.pumpWidget(

        const MaterialApp(

          home: AthleteFormPage(),

        ),

      );


      expect(
        find.text('ثبت ورزشکار'),
        findsAtLeastNWidgets(1),
      );


      expect(
        find.text('نام'),
        findsOneWidget,
      );


      expect(
        find.text('نام خانوادگی'),
        findsOneWidget,
      );


      expect(
        find.text('ذخیره'),
        findsOneWidget,
      );

    },

  );

}