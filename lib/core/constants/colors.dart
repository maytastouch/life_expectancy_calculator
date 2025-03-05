import 'package:flutter/material.dart';

class AppColors {
//lighter shades
  static Color get lighterPrimaryColor => _getLighterShade(primaryColor);
  static Color get lighterGreenColor => _getLighterShade(greenColor);
  static Color get lighterBlueColor => _getLighterShade(blueColor);

  static const lightBlue = Color.fromARGB(255, 175, 230, 255);
  static const lightGreen = Color.fromARGB(255, 175, 255, 175);

  static Color _getLighterShade(Color color) {
    return Color.lerp(color, Colors.white, 0.91)!;
  }

  //sign in page color
  static const popUpPageColor = Color(0xFFDBDCFE);
  static const popUpWhiteColor = Color.fromARGB(189, 255, 255, 255);

  static const whiteColor = Colors.white;

  //green color
  static const greenColor = Colors.green;
  //blue color
  static const blueColor = Colors.blue;
  //red color
  static const redColor = Color.fromARGB(255, 255, 0, 0);

  //orange color
  static const orangeColor = Color.fromARGB(255, 255, 165, 0);

  static const Color sideBarDarkModeColor = Color.fromARGB(255, 23, 21, 21);

  static const backgroundColor = Colors.white;
  static const textColor = Color.fromARGB(255, 0, 0, 0);
  static const primaryColor = Color.fromARGB(255, 88, 47, 173);
  //light shade of primary color

  //create an accent color
  static const accentColor = Color.fromARGB(255, 255, 255, 255);

  static const sideBarColor = Color.fromARGB(255, 235, 229, 246);
  static const searchBarColor = Color.fromRGBO(50, 55, 57, 1);
  static const borderColor = Colors.grey;
//darkmode
  static const Color darkModeColor = Color.fromARGB(255, 13, 3, 31);
  static const Color navBarDarkMode = Color.fromARGB(255, 13, 12, 12);
  static const Color blackColor = Color.fromARGB(255, 0, 0, 0);
  static const Color greyColor = Colors.grey;
  static const Color whiteModeColor = Color.fromARGB(255, 248, 245, 245);
  static const Color darkModeHoverColor = Color.fromARGB(33, 220, 200, 198);
  //error color
  static const Color errorColor = Color.fromARGB(255, 255, 0, 0);
}
