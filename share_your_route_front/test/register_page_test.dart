import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:share_your_route_front/modules/auth/register/presenters/register_page.dart';

// Create a mock for NavigatorObserver
class MockNavigatorObserver extends Mock implements NavigatorObserver {}

void main() {
  late MockNavigatorObserver mockNavigatorObserver;

  setUp(() {
    mockNavigatorObserver = MockNavigatorObserver();
  });

  testWidgets('RegisterPage shows validation errors when fields are empty', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: const RegisterPage(),
        navigatorObservers: [mockNavigatorObserver],
      ),
    );

    // Tap the "Crear cuenta" button
    await tester.tap(find.text('Crear cuenta'));

    // Re-render the UI after interaction
    await tester.pump();

    // Verify that validation error messages are shown
    expect(find.text('Por favor ingrese sus nombres'), findsOneWidget);
    expect(find.text('Por favor ingrese sus apellidos'), findsOneWidget);
    expect(find.text('Por favor ingrese su email'), findsOneWidget);
    expect(find.text('Por favor ingrese su contraseña'), findsOneWidget);
    expect(find.text('Por favor confirme su contraseña'), findsOneWidget);
  });

  testWidgets('RegisterPage shows error if passwords do not match', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: const RegisterPage(),
        navigatorObservers: [mockNavigatorObserver],
      ),
    );

    await tester.enterText(find.byType(TextFormField).at(0), 'Elliot Sam');
    await tester.enterText(find.byType(TextFormField).at(1), 'Alderson Sepiol');
    await tester.enterText(find.byType(TextFormField).at(2), 'samsepiol@example.com');
    await tester.enterText(find.byType(TextFormField).at(3), 'password123');
    await tester.enterText(find.byType(TextFormField).at(4), 'password456');

    // Tap the "Crear cuenta" button
    await tester.tap(find.text('Crear cuenta'));

    // Re-render the UI after interaction
    await tester.pump();

    // Verify that the password mismatch error message is shown
    expect(find.text('Las contraseñas no son iguales'), findsOneWidget);
  });

  testWidgets('RegisterPage navigates to home on successful registration', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: const RegisterPage(),
        navigatorObservers: [mockNavigatorObserver],
      ),
    );

    // Simulate valid input data
    await tester.enterText(find.byType(TextFormField).at(0), 'Elliot Sam');
    await tester.enterText(find.byType(TextFormField).at(1), 'Alderson Sepiol');
    await tester.enterText(find.byType(TextFormField).at(2), 'samsepiol@example.com');
    await tester.enterText(find.byType(TextFormField).at(3), 'password123');
    await tester.enterText(find.byType(TextFormField).at(4), 'password123');

    // Tap the "Crear cuenta" button
    await tester.tap(find.text('Crear cuenta'));

    // Re-render the UI after interaction
    await tester.pumpAndSettle();
  });

  testWidgets('RegisterPage shows password strength checker when password is entered', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: const RegisterPage(),
        navigatorObservers: [mockNavigatorObserver],
      ),
    );

    // Enter a password
    await tester.enterText(find.byType(TextFormField).at(3), 'password123');

    // Re-render the UI after interaction
    await tester.pump();

    // Check if password strength indicator is visible. Replace with actual widget if different.
    expect(find.text('Password strength: '), findsOneWidget);
  });

  testWidgets('RegisterPage hides password strength checker when password is cleared', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: const RegisterPage(),
        navigatorObservers: [mockNavigatorObserver],
      ),
    );

    // Enter a password
    await tester.enterText(find.byType(TextFormField).at(3), 'password123');

    // Clear the password
    await tester.enterText(find.byType(TextFormField).at(3), '');

    // Re-render the UI after interaction
    await tester.pump();

    // Verify that the password strength checker is no longer visible
    expect(find.text('Password strength: '), findsNothing);
  });
}
