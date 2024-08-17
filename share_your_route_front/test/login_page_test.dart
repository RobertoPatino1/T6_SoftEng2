import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:share_your_route_front/modules/auth/login/presenters/login_page.dart';

// Crear un mock de FirebaseAuth
class MockFirebaseAuth extends Mock implements FirebaseAuth {}

class MockUserCredential extends Mock implements UserCredential {}

void main() {
  late FirebaseAuth auth;

  setUp(() {
    auth = MockFirebaseAuth();
  });

  testWidgets('LoginPage shows error message on invalid credentials', (WidgetTester tester) async {
    when(auth.signInWithEmailAndPassword(
      email: 'invalid@test.com',
      password: 'wrongpassword',
    )).thenThrow(FirebaseAuthException(code: 'wrong-password'));

    await tester.pumpWidget(
      const MaterialApp(
        home: LoginPage(),
      ),
    );

    // Introducir un email incorrecto
    await tester.enterText(find.byType(TextField).at(0), 'invalid@test.com');
    // Introducir una contraseña incorrecta
    await tester.enterText(find.byType(TextField).at(1), 'wrongpassword');

    // Tocar el botón de inicio de sesión
    await tester.tap(find.text('Iniciar sesión'));

    // Re-renderizar la UI después de la interacción
    await tester.pump();

    // Verificar que el mensaje de error se muestra
    expect(find.text('Credenciales incorrectas, intente nuevamente.'), findsOneWidget);
  });

  testWidgets('Navigates to home on successful login', (WidgetTester tester) async {
    final user = MockUser(email: 'test@test.com');
    final mockAuth = MockFirebaseAuth();

    final mockUserCredential = MockUserCredential();
    when(mockUserCredential.user).thenReturn(user);
    when(mockAuth.signInWithEmailAndPassword(
      email: 'test@test.com',
      password: 'correctpassword',
    )).thenAnswer((_) async => mockUserCredential);

    await tester.pumpWidget(
      const MaterialApp(
        home: LoginPage(),
      ),
    );

    // Introducir un email correcto
    await tester.enterText(find.byType(TextField).at(0), 'test@test.com');
    // Introducir una contraseña correcta
    await tester.enterText(find.byType(TextField).at(1), 'correctpassword');

    // Tocar el botón de inicio de sesión
    await tester.tap(find.text('Iniciar sesión'));

    // Re-renderizar la UI después de la interacción
    await tester.pumpAndSettle();

    // Verificar que la navegación ocurrió a la página de inicio
    verify(Modular.to.navigate('/auth/home/')).called(1);
  });

  testWidgets('Navigates to register page on "Create an account" button press', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: LoginPage(),
      ),
    );

    // Tocar el botón de "Crea una cuenta"
    await tester.tap(find.text('Usuario nuevo? Crea una cuenta'));

    // Re-renderizar la UI después de la interacción
    await tester.pumpAndSettle();

    // Verificar que la navegación ocurrió a la página de registro
    verify(Modular.to.pushNamed('/auth/register')).called(1);
  });
}
