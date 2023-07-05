import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:quran/home/quran/model/quran_surah_model.dart';
import 'package:quran/resources/colors_manager.dart';
import 'package:quran/resources/constants.dart';
import 'package:quran/resources/font_manager.dart';

class QuranSurahTileWidget extends StatelessWidget {
  final QuranSurahModel quranSurah;
  final int index;
  const QuranSurahTileWidget({required this.quranSurah, required this.index, super.key});

  @override
  Widget build(BuildContext context) {
    print("Language ==> ${Get.locale!.languageCode}");
    return Row(
      // crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Stack(
          alignment: AlignmentDirectional.center,
          children: [Image.asset(ImageAssets.POLYGON_ICON),
        Text(quranSurah.chapterNum.toString(), style: Theme.of(context).textTheme.headlineSmall!.copyWith(fontSize: FontSizeManager.s17.sp),)
        ]),
        SizedBox(width: AppSize.S_10.w,),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(Get.locale!.languageCode == "en" ? quranSurah.englishName.toString().tr : quranSurah.tamilName.toString().tr,
                  style: Theme.of(context).textTheme.headlineSmall),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    quranSurah.versesCount.toString().tr,
                    style: Theme.of(context)
                        .textTheme
                        .labelSmall!
                        .copyWith(color: ColorManager.text),
                  ),
                  // Text(quranSurah.name.toString().tr,
                  //     style: Theme.of(context).textTheme.labelLarge!.copyWith(fontFamily: FontConstant.fontFamily, fontSize: FontSizeManager.s27.sp))
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}