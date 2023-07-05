import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:quran/common_widget/bookmark_widget.dart';
import 'package:quran/common_widget/share_icon_widget.dart';
import 'package:quran/home/common.dart';
import 'package:quran/home/goto/controller/gotoSearch_controller.dart';
import 'package:quran/quran_chapter_detail/controller/surah_ayaah_controller.dart';
import 'package:quran/resources/constants.dart';
import 'package:quran/resources/font_manager.dart';
import 'package:substring_highlight/substring_highlight.dart';

class DialogueWidget extends StatelessWidget {
  final String? dialogueTitle;
  final String dialogue;
  final String? language;
  final int verseNo;
  final int index;
  final bool isOnGoto;
  final int? chapterNo;
  final CTab? cTab;
  const DialogueWidget(
      {required this.dialogue,
      required this.dialogueTitle,
      required this.language,
      required this.verseNo,
      required this.index,
      required this.isOnGoto,
      this.chapterNo,
      this.cTab,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (dialogueTitle == "null")
        (language != Constants.QuranAyaatsDetail[2] &&
                    (Get.locale!.languageCode != 'ar' &&
                        Get.locale!.languageCode != 'ur')) ||
                (language == Constants.QuranAyaatsDetail[2] &&
                    (Get.locale!.languageCode == 'ar' ||
                        Get.locale!.languageCode == 'ur'))
            ? Row(
                  children:  [
                    // if(!isOnGoto)
                    GestureDetector(
                      onTap: ()=> !isOnGoto ? Get.find<SurahAyaahController>().changeAyaahLanguage(chapterNo, verseNo, index, language, cTab) : Get.find<GotoController>().changeAyaahLanguage(chapterNo, verseNo, index, language),
                      child: Image.asset('assets/images/change_lang.png',height: AppSize.S_30.h, width: AppSize.S_30.w,)),
                    const Expanded(child: SizedBox()),
                    if(!isOnGoto && !Get.find<SurahAyaahController>().isSearch)
                    ...[BookMarkWidget(index: index, chapterNum: chapterNo!),
                    SizedBox(width:AppSize.S_12.w)
                    ],
                    ShareIconWidget(alignment: Alignment.centerRight, index: index, isOnGoto: isOnGoto, language: language!,)
                ],
              )
            : Row(
                  children:  [
                    ShareIconWidget(alignment: Alignment.centerLeft, index: index, isOnGoto: isOnGoto,language: language!),
                    if(!isOnGoto && !Get.find<SurahAyaahController>().isSearch)
                    ...[BookMarkWidget(index: index, chapterNum: chapterNo!),
                    SizedBox(width:AppSize.S_12.w)
                    ].reversed,
                    const Expanded(child: SizedBox()),
                    GestureDetector(
                      onTap: ()=> !isOnGoto ? Get.find<SurahAyaahController>().changeAyaahLanguage(chapterNo, verseNo, index, language, cTab) : Get.find<GotoController>().changeAyaahLanguage(chapterNo, verseNo, index, language),
                      child: Image.asset('assets/images/change_lang.png', height: AppSize.S_30.h, width: AppSize.S_30.w,)),
                ],
              ),
        (language != Constants.QuranAyaatsDetail[2] &&
                    (Get.locale!.languageCode != 'ar' &&
                        Get.locale!.languageCode != 'ur')) ||
                (language == Constants.QuranAyaatsDetail[2] &&
                    (Get.locale!.languageCode == 'ar' ||
                        Get.locale!.languageCode == 'ur'))
            ? Row(crossAxisAlignment: isOnGoto ? CrossAxisAlignment.center :  CrossAxisAlignment.start, children: [
                Stack(alignment: Alignment.center, children: [
                  Text(isOnGoto ? '${chapterNo! < 10 ? '0$chapterNo' : chapterNo}:${verseNo < 10 ? '0$verseNo' : verseNo}' : '$verseNo',
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall!
                          .copyWith(fontSize: FontSizeManager.s14.sp)),
                  Image.asset(
                    ImageAssets.POLYGON_ICON_YELLOW,
                    height: isOnGoto ? 85.r : AppSize.S_46.r,
                    // width: AppSize.S_70.r,
                    fit: BoxFit.contain
                  )
                ]),
                SizedBox(
                  width: AppSize.S_4.w,
                ),
                Expanded(
                  child: SubstringHighlight(
                    term: isOnGoto? Common.homeSearch.searchAyaatSubstring : Common.ayahSearch.searchAyaatSubstring,
                    text: dialogue,
                    textStyle: Theme.of(context).textTheme.titleMedium!.copyWith(fontSize: isOnGoto && language == "Arabic" ? FontSizeManager.s24.sp : null),
                    textAlign: language != Constants.QuranAyaatsDetail[2] ? TextAlign.left : TextAlign.right,
                    textStyleHighlight: const TextStyle(backgroundColor: Colors.yellow)
                  ),
                  // Text(
                  //   dialogue,
                  //   style: Theme.of(context).textTheme.titleMedium!.copyWith(fontSize: isOnGoto && language == "Arabic" ? FontSizeManager.s24.sp : null),
                  //   textDirection: language != Constants.QuranAyaatsDetail[2]
                  //       ? TextDirection.ltr
                  //       : TextDirection.rtl,
                  // ),
                ),
                SizedBox(
                  width: AppSize.S_24.r,
                )
              ])
            : Row(crossAxisAlignment: isOnGoto ? CrossAxisAlignment.center :  CrossAxisAlignment.start, children: [
                SizedBox(
                  width: AppSize.S_24.r,
                ),
                Expanded(
                  child:SubstringHighlight(
                    term: isOnGoto? Common.homeSearch.searchAyaatSubstring : Common.ayahSearch.searchAyaatSubstring,
                    text: dialogue,
                    textStyle: Theme.of(context).textTheme.titleMedium!.copyWith(fontSize: isOnGoto && language == "Arabic" ? FontSizeManager.s24.sp : null),
                    textAlign: language != Constants.QuranAyaatsDetail[2] ? TextAlign.left : TextAlign.right,
                    textStyleHighlight: const TextStyle(backgroundColor: Colors.yellow)
                  ), 
                  // Text(
                  //   dialogue,
                  //   style: Theme.of(context).textTheme.titleMedium!.copyWith(fontSize: isOnGoto  && language == "Arabic" ? FontSizeManager.s24.sp : null),
                  //   textDirection: language != Constants.QuranAyaatsDetail[2]
                  //       ? TextDirection.ltr
                  //       : TextDirection.rtl,
                  // ),
                ),
                SizedBox(
                  width: AppSize.S_4.w,
                ),
                Stack(alignment: Alignment.center, children: [
                  Text(isOnGoto ? '${chapterNo! < 10 ? '0$chapterNo' : chapterNo}:${verseNo < 10 ? '0$verseNo' : verseNo}' : '$verseNo',
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall!
                          .copyWith(fontSize: FontSizeManager.s14.sp)),
                  Image.asset(
                    ImageAssets.POLYGON_ICON_YELLOW,
                    height: isOnGoto ? 85.r : AppSize.S_46.r,
                    // width: AppSize.S_46.r,
                    fit: BoxFit.contain,
                  )
                ]),
              ]),
      ],
    );
  }
}
