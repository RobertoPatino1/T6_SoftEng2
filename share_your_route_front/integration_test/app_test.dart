import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:share_your_route_front/main/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Register Page - Valid input', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();

    // Find the input fields
    final nameField = find.byKey(const Key('nameField'));
    final lastNameField = find.byKey(const Key('lastNameField'));
    final emailField = find.byKey(const Key('emailField'));
    final passwordField = find.byKey(const Key('passwordField'));
    final confirmPasswordField = find.byKey(const Key('confirmPasswordField'));
    final registerButton = find.byKey(const Key('registerButton'));

    // Enter valid data
    await tester.enterText(nameField, 'Elliot');
    await tester.enterText(lastNameField, 'Alderson');
    await tester.enterText(emailField, 'elliot@example.com');
    await tester.enterText(passwordField, 'StrongP@ssword123');
    await tester.enterText(confirmPasswordField, 'StrongP@ssword123');

    // Tap the register button
    await tester.tap(registerButton);
    await tester.pumpAndSettle();

    // Verify navigation to the home screen or display a success message
    expect(find.text('Welcome, Elliot!'), findsOneWidget);
  });

  testWidgets('Register Page - Invalid email', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();

    // Find the input fields
    final emailField = find.byKey(const Key('emailField'));
    final registerButton = find.byKey(const Key('registerButton'));

    // Enter invalid email
    await tester.enterText(emailField, 'invalid-email');

    // Tap the register button
    await tester.tap(registerButton);
    await tester.pumpAndSettle();

    // Verify that the error message is shown
    expect(find.text('Por favor ingrese un email válido'), findsOneWidget);
  });

  testWidgets('Register Page - Password mismatch', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();

    // Find the input fields
    final passwordField = find.byKey(const Key('passwordField'));
    final confirmPasswordField = find.byKey(const Key('confirmPasswordField'));
    final registerButton = find.byKey(const Key('registerButton'));

    // Enter passwords that don't match
    await tester.enterText(passwordField, 'StrongP@ssword123');
    await tester.enterText(confirmPasswordField, 'DifferentPassword');

    // Tap the register button
    await tester.tap(registerButton);
    await tester.pumpAndSettle();

    // Verify that the password mismatch error is shown
    expect(find.text('Las contraseñas no son iguales'), findsOneWidget);
  });
}
