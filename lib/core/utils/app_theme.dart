import 'package:app/core/constants/App_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppTheme {
  static ThemeData themeData() {
    return ThemeData(
        scaffoldBackgroundColor: AppColors.background,
        appBarTheme: _appBarTheme(),
        inputDecorationTheme: _inputDecorationTheme(),
        elevatedButtonTheme: _elevatedButtonTheme());
  }

  static AppBarTheme _appBarTheme() {
    return AppBarTheme(
      systemOverlayStyle: SystemUiOverlayStyle.light,
      backgroundColor: AppColors.primary,
      centerTitle: true,
      elevation: 0,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(60),
        ),
      ),
      titleTextStyle:
          const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
    );
  }

  static InputDecorationTheme _inputDecorationTheme() {
    return InputDecorationTheme(
      filled: true,
      fillColor: AppColors.backgroundTextFormFeld,
      focusColor: AppColors.backgroundTextFormFeld,
      prefixIconColor: AppColors.outLineTextFormFeld,
      focusedBorder: OutlineInputBorder(
        borderSide:
            BorderSide(color: AppColors.outLineTextFormFeld, width: 2.0),
        borderRadius: BorderRadius.circular(10),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide:
            BorderSide(color: AppColors.backgroundTextFormFeld, width: 2.0),
        borderRadius: BorderRadius.circular(10),
      ),
      hintStyle: TextStyle(color: AppColors.outLineTextFormFeld),
    );
  }

  static ElevatedButtonThemeData _elevatedButtonTheme() {
    return ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
      backgroundColor: AppColors.primary,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10), // <-- Radius
      ),
    ));
  }
}
