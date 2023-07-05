import 'dart:convert';
import 'dart:io' show Platform;
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:quran/common_widget/custom_snackbar.dart';
import 'package:quran/home/controller/intro_appendix_detail_controller.dart';
import 'package:quran/home/controller/search_controller.dart';
import 'package:quran/home/controller/search_strategy_controller.dart';
import 'package:quran/home/goto/controller/gotoSearch_controller.dart';
import 'package:quran/home/widgets/custom_container.dart';
import 'package:quran/resources/constants.dart';
import 'package:webview_flutter_plus/webview_flutter_plus.dart';

class WebViewWidget extends StatefulWidget {
  final String htmlAssetPath;
  final SearchController searchController;
  const WebViewWidget(
      {required this.htmlAssetPath, required this.searchController, Key? key})
      : super(key: key);

  @override
  State<WebViewWidget> createState() => _WebViewWidgetState();
}

class _WebViewWidgetState extends State<WebViewWidget> {
  late final WebViewPlusController _webViewPlusController;
  late final IntroAppendixDetailSearchController _controller;
  late final SearchStrategyController _searchStrategyController;
  int counter = 1;
  double _progress = 0;

  @override
  void initState() {
    super.initState();
    _controller = Get.find<IntroAppendixDetailSearchController>();
    _searchStrategyController = SearchStrategyController();
    _searchStrategyController.setStrategy =
        Constants.introAppendixDetailSearchStrategy;
    widget.searchController.reset();
    if(Get.find<GotoController>().isOnGoto.value)Future.delayed(Duration.zero,()=>Get.find<GotoController>().isOnGoto(false));
    Future.delayed(Duration.zero, ()=>Get.find<GotoController>().clearClipboardList());
  }

  @override
  void dispose() {
    super.dispose();
    Future.delayed(Duration.zero, () => _controller.findText.value = '');
    if (_searchStrategyController.getStrategy ==
        Constants.introAppendixDetailSearchStrategy) {
      _searchStrategyController.setStrategy = Constants.appendixSearchStrategy;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Stack(
        clipBehavior: Clip.none,
        // alignment: Alignment.topLeft,
        children: [
          CustomContainer(
              xPad: AppSize.S_20.w,
              yPad: AppSize.S_10.h,
              child:
                  // print(_controller.findText.value);
                  Stack(clipBehavior: Clip.none, children: [
                Column(
                  children: [
                    SizedBox(
                      height: 20.h,
                    ),
                    Expanded(
                      child: WebViewPlus(
                          gestureRecognizers: {}..addAll({
                              Factory<VerticalDragGestureRecognizer>(
                                  () => VerticalDragGestureRecognizer()),
                              // Factory<HorizontalDragGestureRecognizer>(() => HorizontalDragGestureRecognizer()),
                              Factory<LongPressGestureRecognizer>(() =>
                                  LongPressGestureRecognizer(
                                      duration:
                                          const Duration(milliseconds: 100)))
                            }),
                          javascriptMode: JavascriptMode.unrestricted,
                          initialUrl: widget.htmlAssetPath,
                          onWebViewCreated: (webViewController) {
                            _webViewPlusController = webViewController;
                          },
                          navigationDelegate: (navigation) {
                            if (Platform.isIOS && counter == 1) {
                              counter++;
                              return NavigationDecision.navigate;
                            }
                            return NavigationDecision.prevent;
                          },
                          onProgress: (progress) {
                            setState(() {
                              _progress = progress / 100;
                            });
                          }),
                    ),
                  ],
                ),
                if (_progress < 1)
                  const Center(child: CircularProgressIndicator.adaptive()),
              ])),
          if (_controller.findText.value != '')
            Positioned(
              // top: AppSize.S_4.h,
              right: AppSize.S_10.w,
              // width: AppSize.S_140.r,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  InkWell(
                    onTap: () {
                      // print('searchText : ${_controller.findText.value}');
                      _webViewPlusController.webViewController
                          .runJavascriptReturningResult(
                              "self.find('${_controller.findText.value}',false,true)")
                          .then((isFound) {
                        // setState((){});
                        if (!jsonDecode(isFound)) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              CustomSnackBar.getSnackBar(context,
                                  'No Match found for ${_controller.findText.value}'));
                        }
                      });
                    },
                    radius: AppSize.S_140.r,
                    child: Icon(
                      Icons.keyboard_arrow_up_rounded,
                      size: AppSize.S_34.r,
                    ),
                  ),
                  // SizedBox(width: 4,),
                  InkWell(
                    onTap: () {
                      // print('searchText : ${_controller.findText.value}');
                      _webViewPlusController.webViewController
                          .runJavascriptReturningResult(
                              "self.find('${_controller.findText.value}')")
                          .then((isFound) {
                        // setState((){});
                        if (!jsonDecode(isFound)) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              CustomSnackBar.getSnackBar(context,
                                  'No Match found for ${_controller.findText.value}'));
                        }
                      });
                    },
                    radius: AppSize.S_140.r,
                    child: Icon(
                      Icons.keyboard_arrow_down_rounded,
                      size: AppSize.S_34.r,
                    ),
                  ),
                ],
              ),
            ),
        ],
      );
    });
  }
}
