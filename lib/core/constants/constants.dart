import 'package:flutter/material.dart';
import 'package:time_left/core/constants/colors.dart';

class AppConstants {
  //grades
  // adminActivityPage bullet colors
  static const List<Color> bulletColor = [
    AppColors.redColor,
    AppColors.blueColor,
    AppColors.greenColor,
    AppColors.orangeColor,
  ];

  static const List<Color> bulletColor2 = [
    AppColors.primaryColor,
    AppColors.blueColor,
    AppColors.greenColor,
  ];

  static List<Color> bulletColor2Shade = [
    AppColors.lighterPrimaryColor,
    AppColors.lighterBlueColor,
    AppColors.lighterGreenColor,
  ];

  //window sizes
  static const maxWidth = 1920.0;
  static const maxHeight = 1080.0;
  static const minWidth = 700.0;
  static const minHeight = 600.0;

  static const int responsiveWidth = 1160;
  //side * side break point
  static const int breakPoint = 930;

  //gridview breakpoint
  static const int gridViewBreakPoint = 700;

  static const desktopResponsiveHeight = 600;

  // dashboard response constant width
  static const int dashboardWidth = 1000;

  //list of images to be displayed in the carousel
  static List<String> imageList = [
    'assets/images/girl-graduation-student-svgrepo-com.svg',
    'assets/images/male.svg',
    'assets/images/list5.svg',
  ];

  //font sizes
  static const double mainFont1 = 60.0;
  static const double mainFont2 = 50.0;
  static const double mainFont3 = 40.0;
  static const double mainFont4 = 16.0;
  static const double mainFont5 = 15.0;
  static const double mainFont6 = 14.5;
  static const double mainFont7 = 14.0;
  static const double mainFont8 = 13.5;
  static const double mainFont9 = 13.0;
  static const double mainFont10 = 12.0;

  static const double betterFont1 = 30.0;
}
