import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:quran/common_widget/bookmark_widget.dart';
import 'package:quran/common_widget/share_icon_widget.dart';
import 'package:quran/home/common.dart';
import 'package:quran/home/goto/controller/gotoSearch_controller.dart';
import 'package:quran/quran_chapter_detail/controller/surah_ayaah_controller.dart';
import 'package:quran/resources/constants.dart';
import 'package:substring_highlight/substring_highlight.dart';

class DailogueTitleWidget extends StatelessWidget {
  final String? language;
  final String title;
  final int index;
  final bool isOnGoto;
  final int? chapterNo;
  final int? verseNo;
  final CTab? cTab;

  const DailogueTitleWidget({required this.language,required this.title, required this.index, required this.isOnGoto, this.chapterNo, this.verseNo, this.cTab, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(bottom: AppSize.S_30.h),
        child: (language != Constants.QuranAyaatsDetail[2] &&
                    (Get.locale!.languageCode != 'ar' && Get.locale!.languageCode != 'ur')) ||
                (language == Constants.QuranAyaatsDetail[2] &&
                    (Get.locale!.languageCode == 'ar' || Get.locale!.languageCode == 'ur'))
            ? Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // if(!isOnGoto)
                  GestureDetector(
                      onTap: ()=> !isOnGoto ? Get.find<SurahAyaahController>().changeAyaahLanguage(chapterNo, verseNo, index, language, cTab) : Get.find<GotoController>().changeAyaahLanguage(chapterNo, verseNo, index, language),
                      child: Image.asset('assets/images/change_lang.png',height: AppSize.S_30.h, width: AppSize.S_30.w,)),
                  // if(!isOnGoto)
                  SizedBox(
                    width: AppSize.S_16.w,
                  ),
                  Expanded(
                    child: 
                    SubstringHighlight(
                    term: isOnGoto? Common.homeSearch.searchAyaatSubstring : Common.ayahSearch.searchAyaatSubstring,
                    text: title,
                    textStyle: Theme.of(context).textTheme.headlineMedium!,
                    textAlign: language != Constants.QuranAyaatsDetail[2]
                        ? TextAlign.left
                        : TextAlign.right,
                    textStyleHighlight: const TextStyle(backgroundColor: Colors.yellow)
                  ),
                    // Text(
                    //   title,
                    //   style: Theme.of(context).textTheme.headlineMedium,
                    //   textAlign: TextAlign.center,
                    //   textDirection: language != Constants.QuranAyaatsDetail[2]
                    //       ? TextDirection.ltr
                    //       : TextDirection.rtl,
                    // ),
                  ),
                  SizedBox(
                    width: AppSize.S_8.w,
                  ),
                  if(!isOnGoto && !Get.find<SurahAyaahController>().isSearch)
                    BookMarkWidget(index: index, chapterNum: chapterNo!),
                  if(!isOnGoto)
                  SizedBox(
                    width: AppSize.S_12.w,
                  ),
                   ShareIconWidget(alignment: Alignment.centerRight, index: index, isOnGoto: isOnGoto, language: language!),
                ],
              )
            : Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   ShareIconWidget(alignment: Alignment.centerLeft, index: index, isOnGoto: isOnGoto, language: language!),
                  SizedBox(
                    width: AppSize.S_12.w,
                  ),
                  if(!isOnGoto && !Get.find<SurahAyaahController>().isSearch)
                    BookMarkWidget(index: index,chapterNum: chapterNo!),
                  if(!isOnGoto)
                  SizedBox(
                    width: AppSize.S_8.w,
                  ),
                  Expanded(
                    child: 
                    SubstringHighlight(
                    term: isOnGoto? Common.homeSearch.searchAyaatSubstring : Common.ayahSearch.searchAyaatSubstring,
                    text: title,
                    textStyle: Theme.of(context).textTheme.headlineMedium!,
                    textAlign: language != Constants.QuranAyaatsDetail[2]
                        ? TextAlign.left
                        : TextAlign.right,
                    textStyleHighlight: const TextStyle(backgroundColor: Colors.yellow)
                  ),
                    // Text(
                    //  title,
                    //   style: Theme.of(context).textTheme.headlineMedium,
                    //   textAlign: TextAlign.center,
                    //   textDirection: language != Constants.QuranAyaatsDetail[0]
                    //       ? TextDirection.ltr
                    //       : TextDirection.rtl,
                    // ),
                  ),
                  // if(!isOnGoto)
                  SizedBox(
                    width: AppSize.S_8.w,
                  ),
                  // if(!isOnGoto)
                  GestureDetector(
                      onTap: ()=> !isOnGoto ? Get.find<SurahAyaahController>().changeAyaahLanguage(chapterNo, verseNo, index, language, cTab) : Get.find<GotoController>().changeAyaahLanguage(chapterNo, verseNo, index, language),
                      child: Image.asset('assets/images/change_lang.png',height: AppSize.S_30.h, width: AppSize.S_30.w,)),
                ],
              ));
  }
}
