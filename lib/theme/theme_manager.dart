import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ThemeManager {
  static ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: const Color(0xFFF5F6FB),
    colorScheme: ColorScheme.fromSeed(
      seedColor: const Color(0xFF030065),
      primary: const Color(0xFF030065),
    ),
    appBarTheme: const AppBarTheme(
      elevation: 0,
      scrolledUnderElevation: 0,
      centerTitle: false,
      backgroundColor: Color(0xFFF5F6FB),
      foregroundColor: Color(0xff000000),
      titleTextStyle: TextStyle(
        fontSize: 18,
        color: Color(0xff000000),
        fontWeight: FontWeight.w500,
      ),
      iconTheme: IconThemeData(size: 22),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      elevation: 0,
      backgroundColor: Color(0xFF030065),
      foregroundColor: Color(0xFFFFFFFF),
      extendedTextStyle: TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: 14,
      ),
      iconSize: 20,
    ),
    cardTheme: const CardTheme(
      elevation: 0,
      color: Color(0xFFFFFFFF),
    ),
    textTheme: GoogleFonts.poppinsTextTheme(),
    useMaterial3: true,
  );
}

extension MyBuildContextExtension on BuildContext {
  TextStyle get titleStyle => Theme.of(this).textTheme.headlineLarge!.copyWith(
        fontWeight: FontWeight.bold,
        fontSize: 28,
        letterSpacing: 0,
      );

  TextStyle get subHeadlineStyle =>
      Theme.of(this).textTheme.headlineLarge!.copyWith(
            fontWeight: FontWeight.bold,
            fontSize: 14,
            letterSpacing: 0,
          );

  TextStyle get inputStyle => Theme.of(this).textTheme.headlineLarge!.copyWith(
        fontWeight: FontWeight.w500,
        fontSize: 18,
        letterSpacing: 0,
      );

  TextStyle get bodyBoldStyle =>
      Theme.of(this).textTheme.headlineLarge!.copyWith(
            fontWeight: FontWeight.w600,
            fontSize: 16,
            letterSpacing: 0,
          );

  TextStyle get bodyMediumStyle =>
      Theme.of(this).textTheme.headlineLarge!.copyWith(
            fontWeight: FontWeight.w500,
            fontSize: 16,
            letterSpacing: 0,
          );

  TextStyle get bodyStyle => Theme.of(this).textTheme.headlineLarge!.copyWith(
        fontWeight: FontWeight.w400,
        fontSize: 16,
        letterSpacing: 0,
      );

  TextStyle get subtitleBoldStyle =>
      Theme.of(this).textTheme.headlineLarge!.copyWith(
            fontWeight: FontWeight.w600,
            fontSize: 14,
            letterSpacing: 0,
          );

  TextStyle get subtitleMediumStyle =>
      Theme.of(this).textTheme.headlineLarge!.copyWith(
            fontWeight: FontWeight.w500,
            fontSize: 14,
            letterSpacing: 0,
          );

  TextStyle get subtitleStyle =>
      Theme.of(this).textTheme.headlineLarge!.copyWith(
            fontWeight: FontWeight.w400,
            fontSize: 14,
            letterSpacing: 0,
          );

  TextStyle get buttonLargeStyle =>
      Theme.of(this).textTheme.headlineLarge!.copyWith(
            fontWeight: FontWeight.w600,
            fontSize: 16,
            letterSpacing: 0.2,
          );

  TextStyle get buttonMediumStyle =>
      Theme.of(this).textTheme.headlineLarge!.copyWith(
            fontWeight: FontWeight.w500,
            fontSize: 14,
            letterSpacing: 0.2,
          );

  TextStyle get buttonSmallStyle =>
      Theme.of(this).textTheme.headlineLarge!.copyWith(
            fontWeight: FontWeight.w400,
            fontSize: 13,
            letterSpacing: 0.2,
          );

  TextStyle get captionBoldStyle =>
      Theme.of(this).textTheme.headlineLarge!.copyWith(
            fontWeight: FontWeight.w500,
            fontSize: 13,
            letterSpacing: 0,
          );

  TextStyle get captionStyle =>
      Theme.of(this).textTheme.headlineLarge!.copyWith(
            fontWeight: FontWeight.w400,
            fontSize: 13,
            letterSpacing: 0,
          );
}
