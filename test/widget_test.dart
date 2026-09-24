import 'package:flutter_test/flutter_test.dart';
import 'package:grocery_app/main.dart';

void main() {
  testWidgets('App starts smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const GroceryApp());
    expect(find.text('nectar'), findsOneWidget);
  });
}
