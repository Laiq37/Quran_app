import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:quran/home/common.dart';
import 'package:quran/home/controller/search_controller.dart';
import 'package:quran/home/controller/search_strategy_controller.dart';
import 'package:quran/home/goto/controller/gotoSearch_controller.dart';
import 'package:quran/home/quran/controller/quran_surah_controller.dart';
import 'package:quran/home/quran/model/quran_surah_model.dart';
import 'package:quran/home/quran/widget/quran_surah_tile_widget.dart';
import 'package:quran/home/screen/home_screen.dart';
import 'package:quran/quran_chapter_detail/screen/quran_surah_screen.dart';
import 'package:quran/resources/colors_manager.dart';
import 'package:quran/resources/constants.dart';

class QuranPage extends StatefulWidget {
  
  const QuranPage({super.key});

  @override
  State<QuranPage> createState() => _QuranPageState();
}

class _QuranPageState extends State<QuranPage> {
  late final SearchStrategyController _searchStrategyController;
  late final QuranSurahController quranSurahController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    quranSurahController = Get.find<QuranSurahController>();
    _searchStrategyController = SearchStrategyController();
    _searchStrategyController.setStrategy = Constants.quranSurahSearchStrategy;
    if(Get.find<GotoController>().isOnGoto.value)Future.delayed(Duration.zero,()=>Get.find<GotoController>().isOnGoto(false));
    Future.delayed(Duration.zero, ()=>Get.find<GotoController>().clearClipboardList());
     SchedulerBinding.instance.addPostFrameCallback((_) {
    quranSurahController.getSurah();
    Common.homeSearch.reset();
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    print('quran_page dispose Method');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() =>  ListView.separated(
          padding: EdgeInsets.only(left: AppSize.S_26.w, right: AppSize.S_26.w),
          itemBuilder: (_, index) {
            final QuranSurahModel quranSurahModel = quranSurahController.quranSurahList[index];
            return InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => QuranSurahScreen(
                  // showIosBackButton: true,
                  chapterNum : quranSurahModel.chapterNum,
                  quranSurah: quranSurahModel,
                ),));
                print("Quran Ayaat Index ==> $index");
              },
              child: QuranSurahTileWidget(
                quranSurah: quranSurahModel,
                index: index,
              ),
            );
          },
          separatorBuilder: (_, __) {
            return Padding(
              padding:
                  EdgeInsets.only(top: AppSize.S_10.h, bottom: AppSize.S_4.h),
              child: Divider(
                color: HexColor.fromHex('#D7EEE8'),
                thickness: 1,
                // height: 10,
              ),
            );
          },
          itemCount: quranSurahController.quranSurahList.length),
    );
  }
}
