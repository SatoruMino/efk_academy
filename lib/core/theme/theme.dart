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

  static ThemeData light(Locale locale) => ThemeData(
        appBarTheme: AppBarTheme(
          actionsPadding: const EdgeInsets.all(4),
          titleTextStyle: TextStyle(
            color: blue,
            fontSize: 18.sp,
            fontFamily: getFont(locale),
            fontWeight: FontWeight.w600,
          ),
        ),
        brightness: Brightness.light,
        colorScheme: ColorScheme.light(primary: blue, onSurface: Colors.black),
        fontFamily: getFont(locale),
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.r),
            borderSide: BorderSide.none,
          ),
          contentPadding: EdgeInsets.symmetric(vertical: 14, horizontal: 16),
          filled: true,
          fillColor: Colors.grey[200],
          labelStyle: TextStyle(fontSize: 14.sp),
          hintStyle: TextStyle(fontSize: 12.sp),
          prefixIconColor: Colors.grey,
        ),
        listTileTheme: ListTileThemeData(
          textColor: Colors.black,
          titleTextStyle:
              TextStyle(fontSize: 14.sp, fontFamily: getFont(locale)),
        ),
        primaryColor: blue,
        tabBarTheme: TabBarTheme(
          dividerHeight: 0,
          labelStyle: TextStyle(
            fontSize: 12.sp,
            fontFamily: getFont(locale),
            height: 1.75,
          ),
          unselectedLabelStyle: const TextStyle(fontSize: 0),
        ),
      );

  static ThemeData dark(Locale locale) => ThemeData(
        appBarTheme: AppBarTheme(
          titleTextStyle: TextStyle(
            color: blue,
            fontSize: 18.sp,
            fontFamily: getFont(locale),
            fontWeight: FontWeight.w600,
          ),
        ),
        brightness: Brightness.dark,
        colorScheme: ColorScheme.dark(primary: blue, onSurface: Colors.white),
        fontFamily: getFont(locale),
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.r),
            borderSide: BorderSide.none,
          ),
          contentPadding: EdgeInsets.symmetric(vertical: 14, horizontal: 16),
          filled: true,
          fillColor: Colors.grey[200],
        ),
        listTileTheme: ListTileThemeData(
          textColor: Colors.white,
          titleTextStyle:
              TextStyle(fontSize: 14.sp, fontFamily: getFont(locale)),
        ),
        primaryColor: blue,
        tabBarTheme: TabBarTheme(
          dividerHeight: 0,
          labelStyle: TextStyle(
            fontSize: 12.sp,
            fontFamily: getFont(locale),
            height: 1.75,
          ),
          unselectedLabelStyle: const TextStyle(fontSize: 0),
        ),
      );
}
