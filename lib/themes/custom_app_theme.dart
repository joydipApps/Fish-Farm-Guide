// custom_app_theme.dart - checked
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomAppTheme {
  static final ThemeData themeData = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue.shade400),

    primaryColor: Colors.blueAccent.shade200,
    hintColor: Colors.lightBlue,
    scaffoldBackgroundColor: Colors.grey.shade400,
    textTheme: GoogleFonts.montserratTextTheme(ThemeData().textTheme),
    dividerColor: Colors.transparent,

    buttonTheme: ButtonThemeData(
      buttonColor: Colors.blueAccent.shade200,
      textTheme: ButtonTextTheme.primary,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
    ),
    cardTheme: CardTheme(
        // color: Colors.lightBlue.shade100,
        color: Colors.white60,
        shadowColor: Colors.lightBlue.shade100,
        surfaceTintColor: Colors.white60,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        elevation: 5,
        margin: const EdgeInsets.all(8)),

    appBarTheme: AppBarTheme(
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.lightBlue.shade900, // added
        elevation: 0,
        centerTitle: true,
        toolbarTextStyle: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 16,
        )),

    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      // You can customize other properties here like labelStyle, hintStyle, etc.
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: Colors.blue,
      elevation: 4,
    ),

    dialogTheme: DialogTheme(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
    ),

    snackBarTheme: SnackBarThemeData(
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      elevation: 4,
      backgroundColor: Colors.grey[900],
      contentTextStyle: const TextStyle(
        color: Colors.white,
        fontSize: 16,
      ),
    ),

    // Add more default styles for other widgets as needed
  );
}
