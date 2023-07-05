import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:quran/common_widget/verse_tile_widget.dart';
import 'package:quran/data/dbmodel.dart';
import 'package:quran/quran_chapter_detail/controller/surah_ayaah_controller.dart';
import 'package:quran/resources/colors_manager.dart';
import 'package:quran/resources/constants.dart';

class SurahTileWidget extends StatelessWidget {
  final QuranAyaat surahList;
  final int index;
  final SurahAyaahController surahAyaahController;
  final CTab ctab;
  const SurahTileWidget({required this.surahList, required this.index, required this.surahAyaahController, required this.ctab, super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
            onLongPress: () =>
                surahAyaahController.onLongPressCopyToClipboardList(
                    surahList),
            onTap: () => surahAyaahController.onTapCopyToClipboardList(
                surahList),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
              VerseTileWidget(
                chapterVerse: surahList,
                language: surahList.Language,
                index: index,
                cTab: ctab,
              ),
              Obx(() => surahAyaahController.surahClipboardAyaahId.contains(
                      surahList.VerseId)
                  ? Positioned(
                    left: -5,
                    top: -10,
                    child: CircleAvatar(
                      radius: AppSize.S_14.r,
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        child: Icon(
                          Icons.done_outlined,
                          color: ColorManager.white,
                          size: AppSize.S_20.r,
                        )),
                  )
                  : const SizedBox()),
            ]),
          );
  }
}