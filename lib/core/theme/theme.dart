import 'package:efk_academy/core/constant/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppTheme {
  static String getFont(Locale locale) {
    switch (locale.countryCode) {
      case 'US':
        return 'Ubuntu';
      case 'KH':
        return 'Kantumruy';
      default:
        return '';
    }
  }

  static AppBarTheme _appBarTheme(Locale locale) => AppBarTheme(
        actionsPadding: const EdgeInsets.all(8),
        titleTextStyle: TextStyle(
          color: blue,
          fontSize: 18.sp,
          fontFamily: getFont(locale),
          fontWeight: FontWeight.w600,
        ),
      );

  static final InputDecorationTheme _inputDecorationTheme =
      InputDecorationTheme(
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12.r),
      borderSide: BorderSide.none,
    ),
    contentPadding: EdgeInsets.symmetric(vertical: 14, horizontal: 16),
    filled: true,
    labelStyle: TextStyle(fontSize: 14.sp),
    hintStyle: TextStyle(fontSize: 12.sp),
    prefixIconColor: Colors.grey,
  );

  static final SnackBarThemeData _snackBarTheme = SnackBarThemeData(
    behavior: SnackBarBehavior.floating,
  );

  static TabBarTheme _tabBarTheme(Locale locale) => TabBarTheme(
        dividerHeight: 0,
        labelPadding: const EdgeInsets.all(8),
        labelStyle: TextStyle(
          fontSize: 12.sp,
          fontFamily: getFont(locale),
        ),
        unselectedLabelStyle: TextStyle(
          fontSize: 10.sp,
          fontFamily: getFont(locale),
        ),
      );

  static TextTheme _textTheme(Locale locale) => TextTheme(
        displayLarge: TextStyle(
          color: blue,
          fontSize: 20.sp,
          fontFamily: getFont(locale),
          fontWeight: FontWeight.w600,
        ),
        displayMedium: TextStyle(
          fontSize: 16.sp,
          fontFamily: getFont(locale),
        ),
        labelLarge: TextStyle(
          fontSize: 16.sp,
          fontFamily: getFont(locale),
          fontWeight: FontWeight.w600,
        ),
        labelMedium: TextStyle(
          fontSize: 14.sp,
          fontFamily: getFont(locale),
          height: 1.5,
          letterSpacing: 0.75,
        ),
        labelSmall: TextStyle(
          fontSize: 12.sp,
          fontFamily: getFont(locale),
          height: 1.5,
          letterSpacing: 0.75,
        ),
      );

  static ThemeData light(Locale locale) => ThemeData(
        appBarTheme: _appBarTheme(locale),
        brightness: Brightness.light,
        colorScheme: ColorScheme.light(primary: blue, onSurface: Colors.black),
        fontFamily: getFont(locale),
        inputDecorationTheme: _inputDecorationTheme.copyWith(
          fillColor: Colors.grey[200],
        ),
        listTileTheme: ListTileThemeData(
          minTileHeight: 0,
          minVerticalPadding: 12,
          textColor: Colors.black,
          titleTextStyle:
              TextStyle(fontSize: 14.sp, fontFamily: getFont(locale)),
        ),
        primaryColor: blue,
        primaryColorDark: Colors.black54,
        snackBarTheme: _snackBarTheme,
        tabBarTheme: _tabBarTheme(locale),
        textTheme: _textTheme(locale),
        useMaterial3: true,
      );

  static ThemeData dark(Locale locale) => ThemeData(
        appBarTheme: _appBarTheme(locale),
        brightness: Brightness.dark,
        colorScheme: ColorScheme.dark(primary: blue, onSurface: Colors.white),
        fontFamily: getFont(locale),
        inputDecorationTheme: _inputDecorationTheme.copyWith(
          fillColor: Colors.black,
        ),
        listTileTheme: ListTileThemeData(
          textColor: Colors.white,
          titleTextStyle:
              TextStyle(fontSize: 14.sp, fontFamily: getFont(locale)),
        ),
        primaryColor: blue,
        primaryColorDark: Colors.white54,
        snackBarTheme: _snackBarTheme,
        tabBarTheme: _tabBarTheme(locale),
        textTheme: _textTheme(locale),
        useMaterial3: true,
      );
}
