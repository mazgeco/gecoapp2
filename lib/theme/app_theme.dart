import 'package:flutter/material.dart';

class AppTheme {
  static const Color primary = Colors.deepPurpleAccent;

  static final ThemeData lightTheme = ThemeData.light().copyWith(
    // AppBar
    appBarTheme: const AppBarTheme(
      color: primary,
      elevation: 0,      
    ),

    // TextButton Theme
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(primary: primary)
    ),

    // FloatingActionButtons
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: primary,
      elevation: 0
    ),

    // ElevatedButton 
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        primary: primary,
        shape: const StadiumBorder(),
        elevation: 0
      )
    ),

    // inputs
    inputDecorationTheme: const InputDecorationTheme(

      floatingLabelStyle: TextStyle(color: primary),
      
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: primary),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(10), 
          topRight: Radius.circular(10)
          )
      ),

      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: primary),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(10), 
          topRight: Radius.circular(10)
          ),
      ),

       border: OutlineInputBorder(        
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(10), 
          topRight: Radius.circular(10)
          ),
      )


    )

  );
}
