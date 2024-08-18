import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:share_your_route_front/core/constants/colors.dart';

// ignore: avoid_classes_with_only_static_members
class GlobalThemeData {
  static final Color _lightFocusColor = Colors.black.withOpacity(0.12);
  static final Color _darkFocusColor = Colors.white.withOpacity(0.12);

  static ThemeData lightThemeData =
      themeData(lightColorScheme, _lightFocusColor);

  static ThemeData darkThemeData = themeData(darkColorScheme, _darkFocusColor);

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
            color: colorScheme.primaryFixed,
            fontWeight: FontWeight.bold,
            height: 1,
          ),
          headlineMedium: GoogleFonts.poppins(
            fontSize: 20.0,
            color: colorScheme.primaryFixed,
            fontWeight: FontWeight.bold,
            height: 1,
          ),
          headlineSmall: GoogleFonts.poppins(
            fontSize: 11.0,
            color: colorScheme.primaryFixed,
            fontWeight: FontWeight.bold,
            height: 1,
          ),
          bodyLarge: GoogleFonts.poppins(
            fontSize: 15.0,
            color: colorScheme.onSurface,
            fontWeight: FontWeight.normal,
            height: 1,
          ),
          bodyMedium: GoogleFonts.poppins(
            fontSize: 12.0,
            color: colorScheme.onSurface,
            fontWeight: FontWeight.normal,
            height: 1,
          ),
          bodySmall: GoogleFonts.poppins(
            fontSize: 8.0,
            color: colorScheme.onSurface,
            fontWeight: FontWeight.normal,
            height: 1,
          ),
          labelLarge: GoogleFonts.poppins(
            fontSize: 15.0,
            color: colorScheme.onSurface,
            fontWeight: FontWeight.bold,
            height: 1,
          ),
          labelMedium: GoogleFonts.poppins(
            fontSize: 10.0,
            color: colorScheme.onSurface,
            fontWeight: FontWeight.bold,
            height: 1,
          ),
          labelSmall: GoogleFonts.poppins(
            fontSize: 8.0,
            color: colorScheme.onSurface,
            fontWeight: FontWeight.bold,
            height: 1.5,
          ),
          displayLarge: GoogleFonts.poppins(
            fontSize: 15.0,
            color: colorScheme.secondary,
            fontWeight: FontWeight.bold,
            height: 1,
          ),
          displayMedium: GoogleFonts.poppins(
            fontSize: 12.0,
            color: colorScheme.secondary,
            fontWeight: FontWeight.bold,
            height: 1.5,
          ),
          displaySmall: GoogleFonts.poppins(
            fontSize: 8.0,
            color: colorScheme.secondary,
            fontWeight: FontWeight.bold,
            height: 1,
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        labelStyle: TextStyle(color: colorScheme.onSurface),
        hintStyle: TextStyle(color: colorScheme.onSurface),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.0),
          borderSide: BorderSide(color: colorScheme.onSurface),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.0),
          borderSide: const BorderSide(color: yellowAccentColor),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
          foregroundColor: WidgetStateProperty.all<Color>(colorScheme.primary),
          textStyle: WidgetStateProperty.all<TextStyle>(
            GoogleFonts.poppins(
              fontSize: 15.0,
              fontWeight: FontWeight.bold,
              color: colorScheme.primary,
            ),
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: ButtonStyle(
          backgroundColor:
              WidgetStateProperty.all<Color>(colorScheme.secondary),
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
                return Colors.grey;
              }
              return colorScheme.secondary;
            },
          ),
          foregroundColor: WidgetStateProperty.resolveWith<Color>(
            (Set<WidgetState> states) {
              if (states.contains(WidgetState.disabled)) {
                return Colors.white;
              }
              return Colors.white;
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
    primary: lightColorSchemePrimary,
    onPrimary: Colors.white,
    secondary: lightColorSchemeSecondary,
    onSecondary: lightColorSchemeOnSecondary,
    error: Colors.redAccent,
    onError: Colors.white,
    surface: Colors.white,
    onSurface: lightColorSchemeOnSurface,
    brightness: Brightness.light,
    primaryFixed: lightColorSchemePrimary,
  );

  static const ColorScheme darkColorScheme = ColorScheme(
    primary: darkColorSchemePrimary,
    onPrimary: Colors.white,
    secondary: darkColorSchemeOnSecondary,
    onSecondary: Colors.white,
    error: Colors.redAccent,
    onError: Colors.white,
    surface: darkColorSchemeSurface,
    onSurface: darkColorSchemeOnSurface,
    brightness: Brightness.dark,
    primaryFixed: Colors.white,
  );
}
