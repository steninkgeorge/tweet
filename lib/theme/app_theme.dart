import 'package:flutter/material.dart';
import 'package:tweet/theme/palette.dart';

class AppTheme {
  static ThemeData theme = ThemeData.dark().copyWith(
      scaffoldBackgroundColor: Pallete.backgroundColor,
      appBarTheme: const AppBarTheme(
        backgroundColor: Pallete.backgroundColor,
        elevation: 0,
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: Pallete.blueColor,
      ),
      iconTheme: const IconThemeData(color: Pallete.greyColor));
}
