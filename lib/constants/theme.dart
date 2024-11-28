import 'package:flutter/material.dart';

final customLightTheme = ThemeData.light(useMaterial3: false).copyWith(
  brightness: Brightness.light,
  colorScheme: ThemeData.light().colorScheme.copyWith(
        primary: Colors.white,
        onPrimary: Colors.black,
        secondary: Colors.deepOrangeAccent,
        onSecondary: Colors.white,
      ),
);

final customDarkTheme = ThemeData.dark(useMaterial3: false).copyWith(
  brightness: Brightness.dark,
  colorScheme: ThemeData.dark().colorScheme.copyWith(
        primary: Colors.blueGrey,
        onPrimary: Colors.white,
        secondary: Colors.blueGrey,
        onSecondary: Colors.white,
      ),
);
