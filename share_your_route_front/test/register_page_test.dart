import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:share_your_route_front/modules/auth/register/presenters/register_page.dart';

void main() {
  testWidgets('Form show a error message if fields are empty',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: Register()));

    final submitButton = find.descendant(
      of: find.byType(Register),
      matching: find.byType(OutlinedButton),
    );

    await tester.tap(submitButton);
    await tester.pump();

    expect(find.text('Por favor ingrese sus nombres'), findsOneWidget);
    expect(find.text('Por favor ingrese sus apellidos'), findsOneWidget);
    expect(find.text('Por favor ingrese su email'), findsOneWidget);
    expect(find.text('Por favor ingrese su nombre de usuario'), findsOneWidget);
    expect(find.text('Por favor ingrese su contraseña'), findsOneWidget);
    expect(find.text('Por favor confirme su contraseña'), findsOneWidget);
  });

  testWidgets('Form show a error message if email is invalidate',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: Register()));

    await tester.enterText(find.byType(TextFormField).at(0), 'Stefano');
    await tester.enterText(find.byType(TextFormField).at(1), 'Suarez');
    await tester.enterText(find.byType(TextFormField).at(2), 'invalid-email');
    await tester.enterText(find.byType(TextFormField).at(3), 'stesherr');
    await tester.enterText(
        find.byType(TextFormField).at(4), 'pruebaContraseña',);
    await tester.enterText(
        find.byType(TextFormField).at(5), 'pruebaContraseña',);
    await tester.tap(find.text('Crear cuenta'));
    await tester.pump();

    expect(find.text('Ingrese un email válido'), findsOneWidget);
  });
}
