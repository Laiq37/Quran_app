import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quran/common_widget/verse_tile_widget.dart';
import 'package:quran/data/dbhelper.dart';
import 'package:quran/data/dbmodel.dart';
import 'package:quran/home/common.dart';
import 'package:quran/home/controller/search_controller.dart';
import 'package:quran/home/controller/search_strategy_controller.dart';
import 'package:quran/home/quran/model/quran_surah_model.dart';
import 'package:quran/quran_chapter_detail/controller/surah_ayaah_controller.dart';
import 'package:quran/quran_chapter_detail/widgets/surah_tile_widget.dart';
import 'package:quran/resources/colors_manager.dart';
import 'package:quran/resources/constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quran/resources/font_manager.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class EnglishQuran extends StatefulWidget {
  int? checkIndex;
  final QuranSurahModel quranSurah;
  EnglishQuran({super.key, this.checkIndex, required this.quranSurah });

  @override
  State<EnglishQuran> createState() => _EnglishQuranState();
}

class _EnglishQuranState extends State<EnglishQuran> {
  late final SearchStrategyController _searchStrategyController;
  late final SurahAyaahController surahAyaahController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    surahAyaahController = Get.find<SurahAyaahController>();
    // Future.delayed(Duration.zero, () => 
    // surahAyaahController.getAyaah(chapterNum: widget.checkIndex!,language:"English");
    Common.ayahSearch.reset();
    if(surahAyaahController.surahClipboardAyaahId.isEmpty)return;
        // surahAyaahController.surahClipboardAyaah.clear();
        Common.ayahSearch.searchAyaatSubstring = '';
    Future.delayed(Duration.zero, () => 
    surahAyaahController.clearClipboardList());
  }
  
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: surahAyaahController.getAyaah(
        chapterNum: widget.checkIndex!, language: "English"),
      builder: (context, snaphShot) {
        return snaphShot.connectionState == ConnectionState.waiting ? const Center(child: CircularProgressIndicator.adaptive(),) : Obx(() =>  ScrollablePositionedList.separated(
                initialScrollIndex: surahAyaahController.isSearch || AppSession.currentSurahAyahIndex == -1 ? 0 : AppSession.currentSurahAyahIndex,
                  padding: EdgeInsets.only(top: AppSize.S_20.h, left: AppSize.S_26.w, right: AppSize.S_26.w),
                  separatorBuilder: (context, index) =>
                      SizedBox(height: AppSize.S_12.h,),
                  physics: const ClampingScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: surahAyaahController.surahAyaahListEn.isEmpty ? 0 : surahAyaahController.surahAyaahListEn.length,
                  itemBuilder: (context, index) {
                    return SurahTileWidget(surahList: surahAyaahController.surahAyaahListEn[index], index: index, surahAyaahController: surahAyaahController, ctab: CTab.en,);
                    
                    // GestureDetector(
                    //   onLongPress: () => surahAyaahController.onLongPressCopyToClipboardList(surahAyaahController.surahAyaahListEn[index]),
                    //   onTap: () => surahAyaahController.onTapCopyToClipboardList(surahAyaahController.surahAyaahListEn[index]),
                    //   child: Stack(children: [
                    //     VerseTileWidget(
                    //       chapterVerse: surahAyaahController.surahAyaahListEn[index],
                    //       language: surahAyaahController.surahAyaahListEn[index].Language,
                    //       index: index,
                    //     ),
                    //     if(surahAyaahController.surahClipboardAyaahId.contains(surahAyaahController.surahAyaahListEn[index].ChapterId))
                    //     CircleAvatar(backgroundColor: Theme.of(context).colorScheme.primary, child: Icon(Icons.done_outlined, color: ColorManager.white,))
                    //   ]),
                    // );
                  }));
      }
    );
  }
}
