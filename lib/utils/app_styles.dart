import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

class AppStyles {
  static TextStyle headingStyleBold = GoogleFonts.openSans(
    color: AppColors.appFontColor,
    fontWeight: FontWeight.bold,
    fontSize: 26,
  );

  static TextStyle appBarStyle = GoogleFonts.openSans(
    color: AppColors.appFontColor,
    fontWeight: FontWeight.bold,
    fontSize: 26,
  );

  static TextStyle mediumTextStyleBold = GoogleFonts.openSans(
    color: AppColors.appFontColor,
    fontWeight: FontWeight.w600,
    fontSize: 20,
  );

  static TextStyle smallTextStyleBold = GoogleFonts.openSans(
    color: AppColors.appFontColor,
    fontWeight: FontWeight.bold,
    fontSize: 16,
  );

  static TextStyle buttonTextStyle = GoogleFonts.openSans(
    color: AppColors.whiteColor,
    fontWeight: FontWeight.bold,
    fontSize: 22,
  );

  static TextStyle snackbarStyle = GoogleFonts.openSans(
    color: AppColors.appFontColor,
    fontWeight: FontWeight.w500,
    fontSize: 16,
  );

  static TextStyle errorText = GoogleFonts.openSans(
    color: AppColors.primaryColor,
    fontWeight: FontWeight.bold,
    fontSize: 16,
  );

  static TextStyle textFieldText = GoogleFonts.openSans(
    color: AppColors.whiteColor,
    fontWeight: FontWeight.bold,
    fontSize: 16,
  );


}
