import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:quran/common_widget/web_view_widget.dart';
import 'package:quran/home/common.dart';

class IndexPage extends StatelessWidget {
  const IndexPage({super.key});

  @override
  Widget build(BuildContext context) {
    print("LANGUAGE ==> ${Get.locale!.languageCode}");
    return WebViewWidget(htmlAssetPath: Get.locale!.languageCode == "en" ? 'assets/english/appendix/quran/quran_index/index/qindex_abc.html': 'assets/english/appendix/quran/quran_index/index/qindex_abc.html', searchController: Common.homeSearch,);
  }
}