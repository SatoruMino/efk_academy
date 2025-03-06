import 'package:efk_academy/core/constant/constant.dart';
import 'package:efk_academy/core/style/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

final _appBarTheme = AppBarTheme(
  actionsPadding: const EdgeInsets.all(8),
  titleSpacing: 12.0,
);

final _inputDecorationTheme = InputDecorationTheme(
  border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(12.r),
    borderSide: BorderSide.none,
  ),
  contentPadding: EdgeInsets.symmetric(vertical: 14, horizontal: 16),
  filled: true,
  fillColor: Colors.grey[200],
  floatingLabelStyle: labelStyle.copyWith(
    fontSize: 14.sp,
  ),
  hintStyle: labelStyle,
  labelStyle: labelStyle,
  prefixIconColor: Colors.grey,
  suffixIconColor: Colors.grey,
);

final _listTileThemeData = ListTileThemeData(
  titleTextStyle: labelStyle.copyWith(
    color: Colors.black54.withValues(alpha: 0.75),
    fontSize: 14.sp,
  ),
);

final _tabBarThemeData = TabBarThemeData(
  labelStyle: labelStyle.copyWith(
    fontSize: 12.sp,
    fontWeight: FontWeight.w600,
  ),
  unselectedLabelStyle: labelStyle.copyWith(
    fontSize: 10.sp,
  ),
);

final light = ThemeData(
  appBarTheme: _appBarTheme,
  cardColor: Colors.grey[200],
  colorScheme: ColorScheme.light(
    primary: blue,
    secondary: red,
    surface: white,
    onSurface: Colors.black54.withValues(alpha: 0.75),
  ),
  inputDecorationTheme: _inputDecorationTheme,
  listTileTheme: _listTileThemeData,
  shadowColor: Colors.grey[200],
  tabBarTheme: _tabBarThemeData,
  useMaterial3: true,
);

final dark = ThemeData(
  appBarTheme: _appBarTheme,
  colorScheme: ColorScheme.dark(
    primary: blue,
    secondary: red,
    surface: Colors.black54.withValues(alpha: 0.75),
    onSurface: white,
  ),
  inputDecorationTheme: _inputDecorationTheme,
  listTileTheme: _listTileThemeData,
  shadowColor: Colors.grey[200],
  tabBarTheme: _tabBarThemeData,
  useMaterial3: true,
);
