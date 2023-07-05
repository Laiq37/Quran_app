import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:quran/common_widget/screen_template_widget.dart';
import 'package:quran/home/appendix/page/appendix_page.dart';
import 'package:quran/home/common.dart';
import 'package:quran/home/controller/search_controller.dart';
import 'package:quran/home/goto/page/goto_page.dart';
import 'package:quran/home/index/page/index_page.dart';
import 'package:quran/home/introduction/page/introduction_page.dart';
import 'package:quran/home/notes/controller/notes_controller.dart';
import 'package:quran/home/notes/page/notes_page.dart';
import 'package:quran/home/quran/page/quran_page.dart';
import 'package:quran/home/widgets/page_widget.dart';
import 'package:quran/home/widgets/tab_bar_widget.dart';
import 'package:quran/resources/constants.dart';

class HomeScreen extends StatefulWidget {
  int? checkIndex;
  bool onHomeScreen;
  bool showIosBackButton;
  HomeScreen({super.key, this.checkIndex, this.onHomeScreen = true, this.showIosBackButton = false});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TabController? tabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Common.homeSearch = SearchController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    if(tabController == null)return;
    Future.delayed(const Duration(milliseconds: 1000), () => tabController?.dispose());
    Common.homeSearch.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print("checkIndex ==> ${widget.checkIndex}");
    return ScreenTemplateWidget(
        scaffoldKey: GlobalKey(),
        onHomeScreen: widget.onHomeScreen,
        showIosBackButton: widget.showIosBackButton,
        title: 'title',
        id: null,
        searchController: Common.homeSearch,
        child: DefaultTabController(
          initialIndex: AppSession.homeTabIndex ?? 0,
          length: Constants.TABS.length,
          child: Builder(builder: (context) {
            final TabController tabController = DefaultTabController.of(context)!;
            final NotesController notesController = Get.find<NotesController>();
            tabController.addListener((){
              if(AppSession.homeTabIndex != tabController.index){
                AppSession.homeTabIndex = tabController.index;
                AppSession.prefs.setInt('homeIndex', AppSession.homeTabIndex!);
                };
              if(tabController.index != Constants.TABS.length-1 && notesController.deleteList.isNotEmpty){
                notesController.clearDeleteList();
              }
            });
            return Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: AppSize.S_26.w),
                  child: TabBarWidget(checkIndex : widget.checkIndex),
                ),
                // Expanded(child: Text('hello'))
                SizedBox(
                  height: AppSize.S_40.h,
                ),
                Expanded(child: PageWidget(checkIndex : widget.checkIndex, tabsPage:  [
                const GotoPage(),
                Padding(
                  padding: EdgeInsets.only(left: AppSize.S_26.w, right: AppSize.S_26.w),
                  child: const IntroductionPage(),
                ),
                const QuranPage(),
                Padding(
                  padding: EdgeInsets.only(left: AppSize.S_26.w, right: AppSize.S_26.w),
                  child: const AppendixPage(),
                ),
                Padding(
                  padding: EdgeInsets.only(left: AppSize.S_26.w, right: AppSize.S_26.w),
                  child: const IndexPage(),
                ),
                const NotesPage(),
              ]),)
              ],
            );}
          ),
        ));
  }
}
