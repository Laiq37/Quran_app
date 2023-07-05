import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quran/common_widget/screen_template_widget.dart';
import 'package:get/get.dart';
import 'package:quran/common_widget/web_view_widget.dart';
import 'package:quran/home/common.dart';
import 'package:quran/home/controller/search_controller.dart';
import 'package:quran/resources/constants.dart';

class AppendixDetail extends StatefulWidget {
  final String? fileName;
  const AppendixDetail({super.key, required this.fileName});

  @override
  State<AppendixDetail> createState() => _AppendixDetailState();
}

class _AppendixDetailState extends State<AppendixDetail> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Common.appendixDetailSearch = SearchController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    Common.appendixDetailSearch.dispose();
  }


  // WebViewController? _controller;
  @override
  Widget build(BuildContext context) {
  final String htmlAssetPath = Get.locale!.languageCode == "en" ? "assets/english/appendix/quran/appendices/${widget.fileName}.html": "assets/${widget.fileName}.html";
  // final Size size = MediaQuery.of(context).size;
    return ScreenTemplateWidget(
        scaffoldKey: GlobalKey(),
        onHomeScreen: true,
        showIosBackButton: true,
        id: null,
        title: "appendix_detail".tr,
        searchController: Common.appendixDetailSearch,
            child: Padding(
              padding: EdgeInsets.only(top: AppSize.S_20.h, left: AppSize.S_26.w, right: AppSize.S_26.w),
              child: WebViewWidget(htmlAssetPath: htmlAssetPath, searchController: Common.appendixDetailSearch,),
            ) 
        );
  }
}
