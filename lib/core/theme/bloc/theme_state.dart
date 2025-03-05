import 'package:flutter/material.dart';

import '../../constants/colors.dart';
import '../../constants/constants.dart'; // Import AppConstants

class ThemeState {
  final ThemeData themeData;
  final bool isDarkMode;

  ThemeState(this.themeData, this.isDarkMode);

  static _border([Color color = AppColors.greyColor]) => OutlineInputBorder(
        borderSide: BorderSide(
          color: color,
          width: 2,
        ),
        borderRadius: BorderRadius.circular(10),
      );

  //light theme
  static ThemeState get lightTheme => ThemeState(
        ThemeData.light().copyWith(
          // Customize dark theme properties

          brightness: Brightness.light,
          primaryColor: AppConstants.tealColor, // Use teal color from constants
// BottomAppBar
          cardColor: AppColors.whiteModeColor, // Cards
          dividerColor: Colors.black12, // Dialogs
          floatingActionButtonTheme: const FloatingActionButtonThemeData(
            backgroundColor: AppColors.whiteModeColor, // FAB background
            foregroundColor: Colors.black, // FAB foreground
          ),
          navigationBarTheme: const NavigationBarThemeData(
            backgroundColor: AppColors.whiteModeColor, // Bottom navigation bar
            indicatorColor: Colors.black, // Selected item indicator
          ),
          textSelectionTheme: const TextSelectionThemeData(
            cursorColor: Colors.black, // Cursor color
            selectionColor: Colors.black26, // Text selection color
            selectionHandleColor: Colors.black, // Handle color
          ),

          bottomAppBarTheme:
              const BottomAppBarTheme(color: AppColors.whiteModeColor),
          // Define additional properties as needed...
          //application background color
          scaffoldBackgroundColor: AppColors.whiteModeColor,
          appBarTheme: const AppBarTheme(
            backgroundColor: AppConstants.tealColor, // Use teal color
            elevation: 0,
          ),
          inputDecorationTheme: InputDecorationTheme(
            contentPadding: const EdgeInsets.all(27),
            floatingLabelStyle: const TextStyle(
              color: AppColors.errorColor,
              //fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
            border: _border(),
            enabledBorder: _border(),
            focusedBorder: _border(AppConstants.tealColor), // Use teal color
            errorBorder: _border(AppColors.errorColor),
          ),
          dialogTheme:
              const DialogThemeData(backgroundColor: AppColors.whiteModeColor),
        ),
        false, // isDarkMode
      );

//dark theme
  static ThemeState get darkTheme => ThemeState(
        ThemeData.dark().copyWith(
          // Customize light theme properties
          brightness: Brightness.dark,
          primaryColor: AppConstants.tealColor, // Use teal color from constants
          scaffoldBackgroundColor: Colors.black, // Scaffold background
          appBarTheme: const AppBarTheme(
            iconTheme: IconThemeData(color: Colors.white), // AppBar icons
            backgroundColor: AppConstants.tealColor, // Use teal color
          ),
          cardColor: Colors.black, // Cards
          dividerColor: Colors.white24, // Dialogs
          floatingActionButtonTheme: const FloatingActionButtonThemeData(
            backgroundColor: Colors.black, // FAB background
            foregroundColor: Colors.white, // FAB foreground
          ),
          navigationBarTheme: const NavigationBarThemeData(
            backgroundColor: Colors.black, // Bottom navigation bar
            indicatorColor: Colors.white, // Selected item indicator
          ),
          textSelectionTheme: const TextSelectionThemeData(
            cursorColor: Colors.white, // Cursor color
            selectionColor: Colors.white38, // Text selection color
            selectionHandleColor: Colors.white, // Handle color
          ),

          bottomAppBarTheme: const BottomAppBarTheme(color: Colors.black),
          dialogTheme: const DialogThemeData(backgroundColor: Colors.black),
        ),
        true, // isDarkMode
      );

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ThemeState && other.isDarkMode == isDarkMode;
  }

  @override
  int get hashCode => isDarkMode.hashCode;
}
