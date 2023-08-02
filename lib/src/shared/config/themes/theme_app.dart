import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../constants/app_constants.dart';
import '../../constants/colors_constans.dart';
import '../../constants/dimens_constants.dart';

ThemeData getAppTheme() {
  TextTheme _basicTextTheme(TextTheme base){
    base.apply(
      fontFamily: AppTextFamily.roboto,
      bodyColor: AppColors.textColorPrimary,
      displayColor: AppColors.textColorPrimary,
    );
    return base;
  }
  final ThemeData base = ThemeData(
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.backgroundColorPure,
      systemOverlayStyle: SystemUiOverlayStyle.dark,
    ),
    scaffoldBackgroundColor: AppColors.backgroundColorBase,
    primaryColor: AppColors.mainColorPrimary,
    fontFamily: AppTextFamily.roboto,
  );
  return base.copyWith(
    textTheme:  _basicTextTheme(base.textTheme),
    primaryColor: AppColors.mainColorPrimary,
    iconTheme: IconThemeData(
      color: AppColors.mainColorPrimaryDarker,
      size: AppDimens.buttonSize,
    ),
  );
}