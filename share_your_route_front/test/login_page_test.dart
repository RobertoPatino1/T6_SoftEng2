import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:share_your_route_front/modules/auth/login/presenters/login_page.dart';

void main() {
  testWidgets(
      'Validate if navigate to home screen by clicking on the "Iniciar sesion" button',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: LoginPage()));

    expect(find.text('Iniciar sesión'), findsOneWidget);
    expect(find.text('Es hora de una aventura!'), findsNothing);

    final loggingButton = find.descendant(
      of: find.byType(Login),
      matching: find.byType(OutlinedButton),
    );
    await tester.tap(loggingButton);
    await tester.pumpAndSettle();

    expect(find.text('Iniciar sesión'), findsNothing);
    expect(find.text('Es hora de una aventura!'), findsOneWidget);
  });
}
