import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:quran/common_widget/custom_alert_dialogue.dart';
import 'package:quran/common_widget/custom_button_widget.dart';
import 'package:quran/common_widget/verse_tile_content_widget.dart';
import 'package:quran/home/common.dart';
import 'package:quran/home/controller/search_strategy_controller.dart';
import 'package:quran/home/goto/controller/gotoSearch_controller.dart';
import 'package:quran/home/goto/widget/search_ayaat_dialogue.dart';
import 'package:quran/resources/colors_manager.dart';
import 'package:quran/resources/constants.dart';

class GotoPage extends StatefulWidget {
  const GotoPage({super.key});

  @override
  State<GotoPage> createState() => _GotoPageState();
}

class _GotoPageState extends State<GotoPage> {
  late final SearchStrategyController _searchStrategyController;
  final gotController = Get.find<GotoController>();
  final ScrollController controller = ScrollController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _searchStrategyController = SearchStrategyController();
    _searchStrategyController.setStrategy = Constants.gotoSearchStrategy;
    Common.homeSearch.reset();
    if(gotController.quranAyaatSearchList.isNotEmpty){
    gotController.quranAyaatSearchList.clear();
    }
    Future.delayed(Duration.zero,()=>gotController.isOnGoto(true));
    Common.homeSearch.searchAyaatSubstring = '';
    if(gotController.quranAyaat.isEmpty){
    Future.delayed(Duration.zero,()=>gotController.getAyaah());
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    Future.delayed(Duration.zero,()=>gotController.quranAyaatSearchList.clear());
    Future.delayed(Duration.zero,()=>Get.find<GotoController>().clearClipboardList());
    controller.dispose();
    Common.homeSearch.searchAyaatSubstring = '';
    if(gotController.isOnGoto.value)Future.delayed(Duration.zero,()=>gotController.isOnGoto(false));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
            child: Padding(
              padding : EdgeInsets.only(bottom:AppSize.S_12.h),
              child: Obx (() => ListView.separated(
                padding: EdgeInsets.only(top:AppSize.S_10.h, left: AppSize.S_26.w, right: AppSize.S_26.w),
                separatorBuilder: (context, index) => SizedBox(
                        height: AppSize.S_12.h,
                      ),
                controller: controller,
                        // padding: EdgeInsets.zero,
                        itemCount: gotController.quranAyaatSearchList.isNotEmpty ? gotController.quranAyaatSearchList.length :  gotController.quranAyaat.length,
                        itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: gotController.quranAyaatSearchList.isEmpty ? null :() => gotController.onTapCopyToClipboardList(
                    gotController.quranAyaatSearchList[index]),
                  onLongPress: gotController.quranAyaatSearchList.isEmpty ? null : ()=>gotController.onLongPressCopyToClipboardList(
                    gotController.quranAyaatSearchList[index]),
                  child: Padding(
                    padding: EdgeInsets.only(bottom:AppSize.S_8.h),
                   child: Stack(
                    clipBehavior: Clip.none,
                     children: [GotoVerseTileWidget(
                        chapterVerse: gotController.quranAyaatSearchList.isNotEmpty ? gotController.quranAyaatSearchList[index] : gotController.quranAyaat[index], 
                        index: index,
                        isOnGoto: true,
                      ),
                       Obx(() => gotController.quranAyaatSearchList.isNotEmpty && gotController.surahClipboardAyaahId.contains(
                      '${gotController.quranAyaatSearchList[index].ChapterId}${gotController.quranAyaatSearchList[index].VerseId}')
                  ? Positioned(
                    left: -5,
                    top: -10,
                    child: CircleAvatar(
                      radius: AppSize.S_14.r,
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        child: Icon(
                          Icons.done_outlined,
                          color: ColorManager.white,
                          size: AppSize.S_20.r,
                        )),
                  )
                  : const SizedBox()),
                      ]
                   ),
                  ),
                );
                // );
                        },
                      ),
              ),
            )),
        Obx(
           () {
            return gotController.quranAyaatSearchList.isEmpty ? Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CustomButtonWidget(
                  width: MediaQuery.of(context).size.width * 0.40,
                  height: AppSize.S_54.h,
                  yPadd: AppSize.S_16.h,
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return Dialog(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                  Radius.circular(AppSize.S_24.r))),
                          child: const SearchAyaatDialogue(),
                        );
                      },
                    );
                  },
                  text: Constants.TABS[0].tr,
                  color: Theme.of(context).colorScheme.primary,
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(color: ColorManager.white),
                ),
                CustomButtonWidget(
                  width: MediaQuery.of(context).size.width * 0.40,
                  height: AppSize.S_54.h,
                  yPadd: AppSize.S_16.h,
                  xPad: AppSize.S_12,
                  onPressed: () {
                    if(gotController.quranAyaat.isEmpty)return;
                    showDialog(
                          context: context,
                          builder: (context) {
                   return CustomAlertDialogue(
                              text:
                                  'Are you sure to Clear All',
                              onPressed: () {
                    gotController.clearGotoAyah();
                    Navigator.pop(context);
                              },
                            );
                          },
                        );
                  },
                  text: 'clear'.tr,
                  color: HexColor.fromHex('#D6F7EF'),
                  style: Theme.of(context).textTheme.titleMedium,
                )
              ],
            ) : const SizedBox();
          }
        ),
        Obx(
          () {
            return SizedBox(
              height: gotController.quranAyaatSearchList.isNotEmpty ? null : AppSize.S_54.h,
            );
          }
        )
      ],
    );
  }
}
