import 'package:flutter/material.dart';
import 'package:ipacking_app/src/shared/constants/app_constants.dart';

import 'colors_constans.dart';


class AppTextStyle {
  static final heading1 =
  customTextStyle(FontWeight.w400, 24, AppColors.inputColor);
  static final heading1Bold =
  customTextStyle(FontWeight.w700, 24, AppColors.inputColor);
  static final heading2Bold =
  customTextStyle(FontWeight.w700, 20, AppColors.inputColor);
  static final heading3Bold =
  customTextStyle(FontWeight.w700, 18, AppColors.inputColor);
  static final heading2 =
  customTextStyle(FontWeight.w500, 20, AppColors.inputColor);
  static final body1 =
  customTextStyle(FontWeight.w400, 16, AppColors.textColorPrimary);
  static final body1Medium =
  customTextStyle(FontWeight.w500, 16, AppColors.textColorPrimary);
  static final body1Bold = customTextStyle(
      FontWeight.w700, 16, AppColors.textColorPrimary,
      lineHeight: 1.48);
  static final caption1 =
  customTextStyle(FontWeight.w400, 14, AppColors.textColorPrimary);
  static final caption1Underline = customTextStyle(
      FontWeight.w400, 14, AppColors.textColorPrimary,
      hasUnderLine: true);
  static final caption1LineHeight130 = customTextStyle(
      FontWeight.w400, 14, AppColors.textColorPrimary,
      lineHeight: 1.3);
  static final caption1Medium = customTextStyle(
    FontWeight.w500,
    14,
    AppColors.textColorPrimary,
  );
  static final caption1Bold = customTextStyle(
    FontWeight.w700,
    14,
    AppColors.textColorPrimary,
  );
  static final caption2 = customTextStyle(
    FontWeight.w400,
    12,
    AppColors.textColorPrimary,
  );
  static final caption2UnderLine = customTextStyle(
      FontWeight.w400, 12, AppColors.textColorPrimary,
      hasUnderLine: true);
  static final caption2LineHeight164 = customTextStyle(
      FontWeight.w400, 12, AppColors.textColorPrimary,
      lineHeight: 1.64);
  static final caption2Bold = customTextStyle(
    FontWeight.w700,
    12,
    AppColors.textColorPrimary,
  );
  static final placeHolder = customTextStyle(
    FontWeight.w400,
    15,
    AppColors.textColorPrimary,
  );
  static final tabText = customTextStyle(
    FontWeight.w400,
    10,
    AppColors.textColorPrimary,
  );
  static final tabTextMedium = customTextStyle(
    FontWeight.w500,
    10,
    AppColors.textColorPrimary,
  );
  static final buttonText = customTextStyle(
    FontWeight.w700,
    16,
    AppColors.textColorPrimary,
  );
}

TextStyle customTextStyle(FontWeight fontWeight, double size, Color color,
    {double? lineHeight, bool hasUnderLine = false}) {
  TextStyle customTextStyle = TextStyle(
      fontFamily: AppTextFamily.roboto,
      fontSize: size,
      fontWeight: fontWeight,
      height: lineHeight ?? 1.4,
      decoration: hasUnderLine ? TextDecoration.underline : null,
      color: color);
  return customTextStyle;
}
