import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quran/resources/constants.dart';
import 'package:get/get.dart';
import 'package:quran/resources/font_manager.dart';

class DrawerTitleWidget extends StatelessWidget {
  const DrawerTitleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      // mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(
          ImageAssets.APP_LOGO,
          height: AppSize.S_80.h,
          width: AppSize.S_80.w,
        ),
        SizedBox(
          width: AppSize.S_20.w,
        ),
        if(Get.locale?.languageCode == 'tm' || Get.locale?.languageCode == 'en')
        Expanded(
          child: FittedBox(
            child: Text(
              'app_title'.tr,
              style: Theme.of(context)
                  .textTheme
                  .displayMedium!
                  .copyWith(fontSize: FontSizeManager.s29.sp),
            ),
          ),
        ),
        if(Get.locale?.languageCode != 'tm' && Get.locale?.languageCode != 'en')
         Text(
              'app_title'.tr,
              style: Theme.of(context)
                  .textTheme
                  .displayMedium!
                  .copyWith(fontSize: FontSizeManager.s29.sp),
            ),
      ],
    );
  }
}
