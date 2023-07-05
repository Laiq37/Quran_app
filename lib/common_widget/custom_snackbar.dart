import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quran/resources/colors_manager.dart';
import 'package:quran/resources/font_manager.dart';

class CustomSnackBar{
  static SnackBar getSnackBar(BuildContext context, String message){
    return SnackBar(
                  content: Text(
                    message,
                    textAlign: TextAlign.center,
                    style: Theme.of(context)
                        .textTheme
                        .headlineSmall!
                        .copyWith(fontSize: FontSizeManager.s13.sp, color: ColorManager.white),
                  ),
                  duration: const Duration(milliseconds: 1000),
                  behavior: SnackBarBehavior.floating,
                  elevation: 0,
                  backgroundColor: ColorManager.textTitle,
                  width: MediaQuery.of(context).size.width * 0.60,
                  shape: const StadiumBorder(),
                );
  }
}