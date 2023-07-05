import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:quran/common_widget/custom_snackbar.dart';
import 'package:quran/quran_chapter_detail/controller/surah_ayaah_controller.dart';
import 'package:quran/resources/constants.dart';

class BookMarkWidget extends StatelessWidget {
  final int index;
  final int chapterNum;
  const BookMarkWidget(
      {required this.index, required this.chapterNum, super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          AppSession.currentSurahAyahIndex = index;
          String msg = "Bookmark has been saved successfully!";
          AppSession.currentindex = AppSession.surahSessionList.indexWhere(
              (surahSessionData) =>
                  surahSessionData["surah_num"] == chapterNum);
          if (AppSession.currentindex != -1) {
            bool isMarkedAgain = false;
            if(AppSession.surahSessionList[AppSession.currentindex]["ayah_index"] == AppSession.currentSurahAyahIndex)isMarkedAgain = true;
            AppSession.surahSessionList.removeAt(AppSession.currentindex);
            if(isMarkedAgain){
              AppSession.currentSurahAyahIndex = -1;
              msg = "Bookmark has been removed";
            }
          }
          Get.find<SurahAyaahController>().refreshList();
          ScaffoldMessenger.of(context).showSnackBar(CustomSnackBar.getSnackBar(
              context, msg));

          AppSession.surahSessionList.add({
            "surah_num": chapterNum,
            'surah_tab_index': AppSession.surahTabIndex,
            'ayah_index': AppSession.currentSurahAyahIndex
          });
          AppSession.prefs.setString(
              'surah_session_list', jsonEncode(AppSession.surahSessionList));
        },
        child: Image.asset(
          index != AppSession.currentSurahAyahIndex
              ? "assets/images/session_disable.jpeg"
              : "assets/images/session_save.jpeg",
          height: AppSize.S_20.h,
          width: AppSize.S_20.w,
          fit: BoxFit.contain,
        ));
  }
}
