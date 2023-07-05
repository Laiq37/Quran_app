import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:quran/common_widget/screen_template_widget.dart';
import 'package:quran/home/common.dart';
import 'package:quran/home/controller/search_controller.dart';
import 'package:quran/home/controller/search_strategy_controller.dart';
import 'package:quran/home/quran/model/quran_surah_model.dart';
import 'package:quran/home/widgets/page_widget.dart';
import 'package:quran/home/widgets/tab_bar_widget.dart';
import 'package:quran/quran_chapter_detail/controller/surah_ayaah_controller.dart';
import 'package:quran/quran_chapter_detail/pages/arabic_quran.dart';
import 'package:quran/quran_chapter_detail/pages/english_quran.dart';
import 'package:quran/quran_chapter_detail/pages/tamil_quran.dart';
import 'package:quran/resources/constants.dart';

class QuranSurahScreen extends StatefulWidget {
  final int chapterNum;
  final QuranSurahModel quranSurah;
  const QuranSurahScreen({required this.chapterNum,required this.quranSurah, super.key});

  @override
  State<QuranSurahScreen> createState() => _QuranSurahScreenState();
}

class _QuranSurahScreenState extends State<QuranSurahScreen> {
  late final SearchStrategyController _searchStrategyController;
  late final SurahAyaahController surahAyaahController;
  TabController? tabController;
  bool isLoading = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Common.ayahSearch = SearchController();
     AppSession.currentindex= AppSession.surahSessionList.indexWhere((surahSessionData) => surahSessionData["surah_num"] == widget.chapterNum);
    AppSession.surahTabIndex = AppSession.currentindex != -1 ? AppSession.surahSessionList[AppSession.currentindex]["surah_tab_index"] : 0;
    AppSession.currentSurahAyahIndex = AppSession.currentindex != -1 ? AppSession.surahSessionList[AppSession.currentindex]["ayah_index"] : -1;
    // AppSession.currentSurahAyahIndex = sessionData?["current_ayah_index"] ?? -1;
    surahAyaahController = Get.find<SurahAyaahController>();
    _searchStrategyController = SearchStrategyController();
    _searchStrategyController.setStrategy = Constants.surahAyaahSearchStrategy;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _searchStrategyController.setStrategy = Constants.quranSurahSearchStrategy;
    if(tabController == null)return;
    Future.delayed(const Duration(milliseconds: 1000), () => tabController?.dispose());
    Common.ayahSearch.searchAyaatSubstring = '';
    Common.ayahSearch.dispose();
    Future.delayed(Duration.zero, () => surahAyaahController.clearClipboardList());
  }

  @override
  Widget build(BuildContext context) {
    return ScreenTemplateWidget(
        scaffoldKey: GlobalKey(),
        showIosBackButton: true,
        onHomeScreen: true,
        title: Get.locale!.languageCode == "en" ? widget.quranSurah.englishName : widget.quranSurah.tamilName,
        id:widget.quranSurah.chapterNum,
        searchController: Common.ayahSearch,
        child: DefaultTabController(
          initialIndex: AppSession.currentindex != -1 ?  AppSession.surahSessionList[AppSession.currentindex]['surah_tab_index'] : Get.locale!.languageCode =="en" ? 1 : 0,
            length: Constants.QuranAyaatsDetail.length,
            child: Builder(
              builder: (context) {
                final TabController tabController = DefaultTabController.of(context)!;
                tabController.addListener((){
              if(AppSession.surahTabIndex != tabController.index){AppSession.surahTabIndex = tabController.index;
              // AppSession.surahNum = widget.chapterNum;
              AppSession.currentindex= AppSession.surahSessionList.indexWhere((surahSessionData) => surahSessionData["surah_num"] == widget.chapterNum);
              if(AppSession.currentindex != -1){
                AppSession.surahSessionList.removeAt(AppSession.currentindex);
              }
              // AppSession.surahTabIndex = tabController.index;
              AppSession.surahSessionList.add({"surah_num": widget.chapterNum, 'surah_tab_index': AppSession.surahTabIndex, 'ayah_index': AppSession.currentSurahAyahIndex});
               AppSession.prefs.setString('surah_session_list', jsonEncode(AppSession.surahSessionList));
              //  AppSession.prefs.setInt('surahNum', AppSession.surahNum!);
              }});
                return Column(
                  children: [
                    Padding(
                      padding:  EdgeInsets.symmetric(horizontal: AppSize.S_26.w),
                      child: TabBarWidget(checkIndex: widget.chapterNum),
                    ),
                    // Expanded(child: Text('hello'))
                    SizedBox(
                      height: AppSize.S_20.h,
                    ),
                     Expanded(
                        child: PageWidget(
                      checkIndex: widget.chapterNum,
                      tabsPage: [
                        TamilQuran(checkIndex: widget.chapterNum,quranSurah: widget.quranSurah, ),
                        EnglishQuran(checkIndex: widget.chapterNum,quranSurah: widget.quranSurah),
                        ArabicQuran(checkIndex: widget.chapterNum,quranSurah: widget.quranSurah),
                      ],
                    ))
                  ],
                );
              }
            )));
  }
}
