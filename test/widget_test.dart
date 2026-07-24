import 'package:flutter_test/flutter_test.dart';
import 'package:climb_coach/app/app.dart';

void main() {
  testWidgets('Athlete form loads', (WidgetTester tester) async {
    await tester.pumpWidget(
      const ClimbCoachApp(),
    );

    expect(find.text('ثبت ورزشکار'), findsOneWidget);
    expect(find.text('نام'), findsOneWidget);
    expect(find.text('نام خانوادگی'), findsOneWidget);
    expect(find.text('ذخیره'), findsOneWidget);
  });
}