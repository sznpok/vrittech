import 'package:flutter/material.dart';

import '../constants/color_constant.dart';

const borderRadius = 8.0;

ThemeData lightThemeData(BuildContext context) {
  return ThemeData(
    primaryColor: primaryColor,
    iconTheme: const IconThemeData(
      color: primaryColor,
    ),
    brightness: Brightness.light,
    primaryColorLight: primaryColor,
    shadowColor: shadowColor,
    appBarTheme: AppBarTheme(
      color: primaryColor,
      titleTextStyle:
          Theme.of(context).textTheme.titleLarge!.copyWith(color: Colors.white),
      iconTheme: const IconThemeData(
        color: Colors.white,
      ),
    ),
    textTheme: TextTheme(
      bodyLarge:
          Theme.of(context).textTheme.bodyLarge!.copyWith(color: textColor),
      bodyMedium:
          Theme.of(context).textTheme.bodyMedium!.copyWith(color: textColor),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        textStyle: Theme.of(context).textTheme.bodyLarge!,
      ),
    ),
    hintColor: hintColor,
    textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
      backgroundColor: primaryColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      textStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(),
    )),
    inputDecorationTheme: const InputDecorationTheme(
      prefixIconColor: primaryColor,
      fillColor: primaryColor,
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: primaryColor,
    ),
    useMaterial3: true,
  );
}
