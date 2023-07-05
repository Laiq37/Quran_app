import 'package:quran/resources/colors_manager.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quran/resources/constants.dart';
import 'package:quran/resources/font_manager.dart';
import 'package:quran/resources/style_manager.dart';

ThemeData getAppTheme() => ThemeData(
    primaryColor: ColorManager.primary,
    colorScheme: ColorScheme.fromSwatch().copyWith(
      primary: ColorManager.primary,
      secondary: ColorManager.accent,
    ),
    iconTheme: IconThemeData(color: ColorManager.textTitle, size: AppSize.S_34.r),
    disabledColor: ColorManager.disableText,
    splashColor: ColorManager.accent, //rippleColor
    fontFamily: 'Poppins',
    textTheme: TextTheme(
      displayLarge: getBoldStyle(
          color: ColorManager.white, fontSize: FontSizeManager.s40.sp),
      displayMedium: getBoldStyle(
          color: ColorManager.white, fontSize: FontSizeManager.s30.sp),
      displaySmall: getBoldStyle(
          color: ColorManager.textTitle, fontSize: FontSizeManager.s22.sp),
      headlineLarge: getSemiBoldStyle(
          color: ColorManager.textTitle, fontSize: FontSizeManager.s24.sp),
      headlineMedium: getSemiBoldStyle(
          color: ColorManager.textTitle, fontSize: FontSizeManager.s20.sp),
      headlineSmall: getSemiBoldStyle(
          color: ColorManager.textTitle, fontSize: FontSizeManager.s16.sp),
      titleMedium: getMediumStyle(
          color: ColorManager.textTitle, fontSize: FontSizeManager.s18.sp),
      titleSmall: getMediumStyle(
          color: ColorManager.textTitle, fontSize: FontSizeManager.s16.sp),
      labelMedium: getRegularStyle(
          color: ColorManager.textTitle, fontSize: FontSizeManager.s14.sp),
      labelSmall: getRegularItalicStyle(
          color: ColorManager.textTitle, fontSize: FontSizeManager.s14.sp),
      bodyMedium: getMediumItalicStyle(
          color: ColorManager.textTitle, fontSize: FontSizeManager.s14.sp),
      labelLarge: getRegularStyle(
              color: ColorManager.textTitle, fontSize: FontSizeManager.s29.sp)
          .copyWith(fontFamily: 'Arial'),
      bodyLarge: getSemiBoldStyle(
          color: ColorManager.textTitle, fontSize: FontSizeManager.s16.sp),
    ));
