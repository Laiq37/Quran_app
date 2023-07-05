import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quran/common_widget/web_view_widget.dart';
import 'package:quran/home/common.dart';

class IntroductionPage extends StatelessWidget {
  const IntroductionPage({super.key});
  @override
  Widget build(BuildContext context) {
    print("LANGUAGE ==> ${Get.locale!.languageCode}");
    return GestureDetector(child: WebViewWidget(htmlAssetPath: Get.locale!.languageCode == "en" ? 'assets/english/appendix/quran/appendices/introduction.html': 'assets/introduction.html', searchController: Common.homeSearch,),);       
  }
}