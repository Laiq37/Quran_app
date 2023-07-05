import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:quran/home/appendix/controller/appendix_controller.dart';
import 'package:quran/home/appendix/page/appendix_detail_page.dart';
import 'package:quran/home/common.dart';
import 'package:quran/home/controller/search_controller.dart';
import 'package:quran/home/controller/search_strategy_controller.dart';
import 'package:quran/home/goto/controller/gotoSearch_controller.dart';
import 'package:quran/home/widgets/custom_container.dart';
import 'package:quran/resources/colors_manager.dart';
import 'package:quran/resources/constants.dart';

class AppendixPage extends StatefulWidget {
  const AppendixPage({super.key});

  @override
  State<AppendixPage> createState() => _AppendixPageState();
}

class _AppendixPageState extends State<AppendixPage> {
  late final AppendixController appendixController;
  late final SearchStrategyController _searchStrategyController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    appendixController = Get.find<AppendixController>();
    appendixController.get();
    _searchStrategyController = SearchStrategyController();
    _searchStrategyController.setStrategy = Constants.appendixSearchStrategy;
    if(Get.find<GotoController>().isOnGoto.value)Future.delayed(Duration.zero,()=>Get.find<GotoController>().isOnGoto(false));
    Future.delayed(Duration.zero, ()=>Get.find<GotoController>().clearClipboardList());
    Common.homeSearch.reset();
  }

  @override
  Widget build(BuildContext context) {

    return 
    Obx(() =>
      ListView.builder(padding: EdgeInsets.zero, itemBuilder: (context, index) => 
          CustomContainer(
              mYPad: AppSize.S_8.h,
              xPad: AppSize.S_34.w,
              yPad: AppSize.S_20.h,
              child: InkWell(
                onTap: () {
                  // print("Data is here ==> ${appendixController.appendixList[index]["fileName"]}");
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AppendixDetail(
                          fileName : appendixController.appendixList[index]["fileName"]
                        )),
                  );
                },
                child: Row(
                  children: [
                    Expanded(
                        child: Text(
                      appendixController.appendixList[index]["name"]!,
                      style: Theme.of(context).textTheme.titleSmall,
                      overflow: TextOverflow.ellipsis,
                    ))
                  ],
                ),
              )),
        itemCount: appendixController.appendixList.length,
      ),
    );
  }
}
