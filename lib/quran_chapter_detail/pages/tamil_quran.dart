import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:quran/home/common.dart';
import 'package:quran/home/quran/model/quran_surah_model.dart';
import 'package:quran/quran_chapter_detail/controller/surah_ayaah_controller.dart';
import 'package:quran/quran_chapter_detail/widgets/surah_tile_widget.dart';
import 'package:quran/resources/constants.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class TamilQuran extends StatefulWidget {
  int? checkIndex;
  final QuranSurahModel quranSurah;
  TamilQuran({super.key, this.checkIndex,required this.quranSurah});

  @override
  State<TamilQuran> createState() => _TamilQuranState();
}

class _TamilQuranState extends State<TamilQuran> {
  late final SurahAyaahController surahAyaahController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    surahAyaahController = Get.find<SurahAyaahController>();
    // Future.delayed(Duration.zero,()=>
    // surahAyaahController.getAyaah(
    //     chapterNum: widget.checkIndex!, language: "Tamil");
        Common.ayahSearch.reset();
    if (surahAyaahController.surahClipboardAyaahId.isEmpty) return;
    // surahAyaahController.surahClipboardAyaah.clear();
    Common.ayahSearch.searchAyaatSubstring = '';
    Future.delayed(Duration.zero,
        () => surahAyaahController.clearClipboardList());
  }

  @override
  Widget build(BuildContext context) {
    print("surahAyaahController");
    return FutureBuilder(
      future: surahAyaahController.getAyaah(
        chapterNum: widget.checkIndex!, language: "Tamil"),
      builder: (context, snaphShot) {
        return snaphShot.connectionState == ConnectionState.waiting ? const Center(child: CircularProgressIndicator.adaptive(),) : Obx(() => ScrollablePositionedList.separated(
                initialScrollIndex: surahAyaahController.isSearch || AppSession.currentSurahAyahIndex == -1 ? 0 : AppSession.currentSurahAyahIndex,
                  padding: EdgeInsets.only(top: AppSize.S_20.h, left: AppSize.S_26.w, right: AppSize.S_26.w),
                  separatorBuilder: (context, index) => SizedBox(
                        height: AppSize.S_12.h,
                      ),
                  physics: const ClampingScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: surahAyaahController.surahAyaahListTm.isEmpty
                      ? 0
                      : surahAyaahController.surahAyaahListTm.length,
                  itemBuilder: (context, index) {
                    return SurahTileWidget(surahList: surahAyaahController.surahAyaahListTm[index], index: index, surahAyaahController: surahAyaahController, ctab: CTab.tm,);
                  }),
            );
      }
    );
  }
}
