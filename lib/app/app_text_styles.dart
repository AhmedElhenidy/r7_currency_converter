
import 'package:flutter/material.dart';
import 'package:r7_currency_converter/app/app_colors.dart';

import 'app_font_sizes.dart';

class AppTextStyles{
  static  TextStyle get appBarTextStyle =>  TextStyle(
    fontSize: AppFontSizes.f20,
    color: AppColors.whiteColor,
    fontWeight: FontWeight.bold,
  );

  static  TextStyle get titleTextStyle =>  TextStyle(
    fontSize: AppFontSizes.f17,
    color: AppColors.whiteColor,
    fontWeight: FontWeight.bold,
  );
}