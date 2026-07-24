import 'package:flutter_test/flutter_test.dart';
import 'package:climb_coach/app/app.dart';

void main() {
  testWidgets('Climb Coach app loads',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const ClimbCoachApp(),
    );

    expect(find.text('Climb Coach'), findsOneWidget);
  });
}
