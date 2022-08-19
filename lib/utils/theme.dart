import 'package:flutter/material.dart';

final projectTheme = ThemeData(
  primaryColor: const Color.fromARGB(255, 244, 111, 35),
  backgroundColor: const Color.fromARGB(255, 233, 233, 233),
  buttonTheme: const ButtonThemeData(
    buttonColor: Color.fromARGB(255, 244, 111, 35),
    textTheme: ButtonTextTheme.primary,
  ),
  colorScheme: ColorScheme.fromSwatch().copyWith(
    secondary: const Color.fromARGB(255, 233, 150, 101),
  ),
);
