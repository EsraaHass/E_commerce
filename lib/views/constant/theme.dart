import 'package:flutter/material.dart';

class MyTheme {
  static final ThemeData lightTheme = ThemeData(
      scaffoldBackgroundColor: const Color(0xFFF5F5F5),
      primaryColor: Colors.red,
      appBarTheme: const AppBarTheme(
          elevation: 0,
          centerTitle: true,
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.black)),
      textTheme: const TextTheme(
          titleMedium: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 25, color: Colors.black)),
      inputDecorationTheme: InputDecorationTheme(
        hintStyle: const TextStyle(
          color: Colors.grey,
          fontSize: 15,
          fontWeight: FontWeight.w500,
        ),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
              color: Colors.grey.shade300,
            )),
        errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(
              color: Colors.red,
            )),
        focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(
              color: Colors.red,
            )),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
              color: Colors.grey.shade300,
            )),
      ));
}
