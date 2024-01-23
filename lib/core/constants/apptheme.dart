import 'package:booking/core/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

ThemeData appthemEN = ThemeData(
    appBarTheme: AppBarTheme(color: AppColors.white),
    scaffoldBackgroundColor: AppColors.scafold,
    // floatingActionButtonTheme:
    //     FloatingActionButtonThemeData(backgroundColor: AppColors.primarycolor),
    textTheme: TextTheme(
        bodyMedium: TextStyle(
            fontSize: 12,
            fontFamily: 'Kufi',
            fontWeight: FontWeight.bold,
            wordSpacing: 2,
            height: 1.5),
        displayLarge: TextStyle(
            fontSize: 25,
            fontFamily: 'Kufi',
            fontWeight: FontWeight.bold,
            color: AppColors.black)));

ThemeData appthemAR = ThemeData(
    appBarTheme: AppBarTheme(color: Colors.red),
    textTheme: const TextTheme(
        bodyMedium: TextStyle(
            fontSize: 16,
            fontFamily: 'Kufi',
            fontWeight: FontWeight.bold,
            wordSpacing: 2,
            height: 1.5),
        displayLarge: TextStyle(
            fontSize: 25,
            fontFamily: 'Kufi',
            fontWeight: FontWeight.bold,
            color: AppColors.black)));
