import 'package:flutter/material.dart';
class AppTheme {


  static const Color lightPrimaryColor = Color(0xFF2F5BB1);
  static const Color lightAccentColor = Color(0xFFF3CF24);
  static final lightTheme = ThemeData(
    primaryColor: lightPrimaryColor,
    scaffoldBackgroundColor: Colors.white,
    platform: TargetPlatform.iOS,
    colorScheme: ColorScheme.fromSwatch().copyWith(
      secondary: lightAccentColor,
      primary: lightPrimaryColor,
    ),
  );
  void delete(){}
}
// End of File
