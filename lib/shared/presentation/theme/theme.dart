import 'package:flutter/material.dart';

final appTheme = ThemeData(
  expansionTileTheme:
      const ExpansionTileThemeData(iconColor: Colors.blue, shape: Border()),
  listTileTheme: const ListTileThemeData(shape: Border()),
  primaryColor: const Color(0xFF0D0452),
  primarySwatch: Colors.blue,
  progressIndicatorTheme: const ProgressIndicatorThemeData(color: Colors.blue),
  appBarTheme: const AppBarTheme(
    iconTheme: IconThemeData(color: Colors.white),
    centerTitle: true,
    backgroundColor: Color(0xFF0D0452),
    titleTextStyle: TextStyle(
      color: Colors.white,
    ),
  ),
);
