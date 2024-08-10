import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: avoid_classes_with_only_static_members
class GlobalThemeData {
  static final Color _lightFocusColor = Colors.black.withOpacity(0.12);

  static ThemeData lightThemeData =
      themeData(lightColorScheme, _lightFocusColor);

  static ThemeData themeData(ColorScheme colorScheme, Color focusColor) {
    return ThemeData(
      colorScheme: colorScheme,
      canvasColor: colorScheme.surface,
      scaffoldBackgroundColor: colorScheme.surface,
      highlightColor: Colors.transparent,
      focusColor: focusColor,
      textTheme: GoogleFonts.poppinsTextTheme(
        TextTheme(
          headlineLarge: GoogleFonts.poppins(
            fontSize: 25.0,
            color: lightColorScheme.primary,
            fontWeight: FontWeight.bold,
            height: 1,
          ),
          headlineMedium: GoogleFonts.poppins(
            fontSize: 20.0,
            color: lightColorScheme.primary,
            fontWeight: FontWeight.bold,
            height: 1,
          ),
          headlineSmall: GoogleFonts.poppins(
            fontSize: 15.0,
            color: lightColorScheme.primary,
            fontWeight: FontWeight.bold,
            height: 1,
          ),
          bodyLarge: GoogleFonts.poppins(
            fontSize: 15.0,
            color: Colors.black,
            fontWeight: FontWeight.normal,
            height: 1,
          ),
          bodyMedium: GoogleFonts.poppins(
            fontSize: 12.0,
            color: Colors.black,
            fontWeight: FontWeight.normal,
            height: 1,
          ),
          bodySmall: GoogleFonts.poppins(
            fontSize: 8.0,
            color: Colors.black,
            fontWeight: FontWeight.normal,
            height: 1,
          ),
          labelLarge: GoogleFonts.poppins(
            fontSize: 15.0,
            color: Colors.black,
            fontWeight: FontWeight.bold,
            height: 1,
          ),
          labelMedium: GoogleFonts.poppins(
            fontSize: 10.0,
            color: Colors.black,
            fontWeight: FontWeight.bold,
            height: 1,
          ),
          labelSmall: GoogleFonts.poppins(
            fontSize: 8.0,
            color: Colors.black,
            fontWeight: FontWeight.bold,
            height: 1.5,
          ),
          displayLarge: GoogleFonts.poppins(
            fontSize: 15.0,
            color: lightColorScheme.secondary,
            fontWeight: FontWeight.bold,
            height: 1,
          ),
          displayMedium: GoogleFonts.poppins(
            fontSize: 12.0,
            color: lightColorScheme.secondary,
            fontWeight: FontWeight.bold,
            height: 1.5,
          ),
          displaySmall: GoogleFonts.poppins(
            fontSize: 8.0,
            color: lightColorScheme.secondary,
            fontWeight: FontWeight.bold,
            height: 1,
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
          foregroundColor:
              // ignore: deprecated_member_use
              MaterialStateProperty.all<Color>(lightColorScheme.primary),
          textStyle: WidgetStateProperty.all<TextStyle>(
            GoogleFonts.poppins(
              fontSize: 15.0,
              fontWeight: FontWeight.bold,
              color: lightColorScheme.primary,
            ),
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: ButtonStyle(
          backgroundColor:
              WidgetStateProperty.all<Color>(lightColorScheme.secondary),
          foregroundColor: WidgetStateProperty.all<Color>(Colors.white),
          textStyle: WidgetStateProperty.all<TextStyle>(
            GoogleFonts.poppins(
              fontSize: 15.0,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          minimumSize: WidgetStateProperty.all<Size>(
            const Size(150, 50),
          ),
          padding: WidgetStateProperty.all<EdgeInsets>(
            const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          ),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.resolveWith<Color>(
            (Set<WidgetState> states) {
              if (states.contains(WidgetState.disabled)) {
                return Colors.grey; // Color cuando está desactivado
              }
              return lightColorScheme.secondary; // Color cuando está habilitado
            },
          ),
          foregroundColor: WidgetStateProperty.resolveWith<Color>(
            (Set<WidgetState> states) {
              if (states.contains(WidgetState.disabled)) {
                return Colors.white; // Color del texto cuando está desactivado
              }
              return Colors.white; // Color del texto cuando está habilitado
            },
          ),
          textStyle: WidgetStateProperty.all<TextStyle>(
            GoogleFonts.poppins(
              fontSize: 12.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

   static const ColorScheme lightColorScheme = ColorScheme(
    primary: Color.fromRGBO(37, 60, 89, 1),
    onPrimary: Colors.white,
    secondary: Color.fromRGBO(45, 75, 115, 1),
    onSecondary: Color(0xFF322942),
    error: Colors.redAccent,
    onError: Color(0xFFFFFFFF),
    surface: Colors.white,
    onSurface: Color(0xFF241E30),
    brightness: Brightness.light,
  );
  static final Color _darkFocusColor = Colors.white.withOpacity(0.12);

  static ThemeData darkThemeData = themeData(darkColorScheme, _darkFocusColor);

  static const ColorScheme darkColorScheme = ColorScheme(
    primary:  Color.fromARGB(255, 37, 60, 89),
    onPrimary: Colors.black,
    secondary: Color.fromARGB(255, 45, 75, 115),
    onSecondary: Color.fromARGB(255, 255, 255, 255),
    error: Colors.redAccent,
    onError: Color(0xFFFFFFFF),
    surface: Color.fromARGB(255, 0, 0, 0), // Cambiado a un tono azul oscuro
    onSurface: Color.fromARGB(255, 29, 34, 104),
    brightness: Brightness.dark,
  );
}
