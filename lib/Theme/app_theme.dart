import 'package:flutter/material.dart';
import 'package:instacopy2/Theme/app_colors.dart';

class AppTheme {
  AppTheme(this.context);

  BuildContext context;

  ThemeData get defaultTheme => ThemeData(
      backgroundColor: AppColors.primaryBackgroundColor,
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          primary: AppColors.primaryButtonColor,
          textStyle: const TextStyle(
            color: AppColors.primaryButtonFontColor,
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          primary: AppColors.secundaryButtonFontColor,
          backgroundColor: AppColors.secundaryButtonColor,
          side: const BorderSide(color: AppColors.secundaryButtonBorderColor),
        ),
      ),
      visualDensity: VisualDensity.adaptivePlatformDensity,
      cardColor: AppColors.cardBackgroundColor);
}
