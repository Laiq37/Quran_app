import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:quran/home/goto/controller/gotoSearch_controller.dart';
import 'package:quran/home/widgets/custom_container.dart';
import 'package:quran/resources/colors_manager.dart';
import 'package:quran/resources/constants.dart';

class ChangeAyaatLanguageWidget extends StatelessWidget {
  final String language;
  final int index;
  ChangeAyaatLanguageWidget({required this.language,required this.index, super.key});
  final gotController = Get.find<GotoController>();
  @override
  Widget build(BuildContext context) {
  print("gotController $gotController");
    return Padding(
      padding: EdgeInsets.only(bottom: AppSize.S_20.h),
      child: CustomContainer(
          border: Border.all(
            color: HexColor.fromHex("#2196EF"),
          ),
          child: Row(
            children: [
              Expanded(
                  child: Container(
                decoration: BoxDecoration(
                  borderRadius: Get.locale!.languageCode == "ar" ||
                          Get.locale!.languageCode == "ur"
                      ? BorderRadius.only(
                          topRight: Radius.circular(AppSize.S_40.r),
                          bottomRight: Radius.circular(AppSize.S_40.r),
                        )
                      : BorderRadius.only(
                          topLeft: Radius.circular(AppSize.S_40.r),
                          bottomLeft: Radius.circular(AppSize.S_40.r),
                        ),
                  color: language == "English"
                      ? HexColor.fromHex("#2196EF")
                      : ColorManager.white,
                ),
                child: TextButton(
                    onPressed: () {
                      if(gotController.quranAyaatSearchList.isNotEmpty){
                        gotController.replaceSearchAyaah(gotController.quranAyaatSearchList[index].ChapterId, gotController.quranAyaatSearchList[index].VerseId, "English");
                        return;
                      }
                      gotController.addAyaat(gotController.quranAyaat[index].ChapterId, gotController.quranAyaat[index].VerseId, "English");
                    },
                    child: Text(
                      'English',
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          color: language != "English"
                              ? HexColor.fromHex("#2196EF")
                              : ColorManager.white),
                    )),
              )),
              Expanded(
                  child: Container(
                decoration: BoxDecoration(
                    color: language == "Tamil"
                        ? HexColor.fromHex("#2196EF")
                        : ColorManager.white,
                    border: 
                    Get.locale!.languageCode == "ar" ||
                          Get.locale!.languageCode == "ur" ?
                    Border(
                        left: language == "Arabic"
                            ? BorderSide.none
                            : BorderSide(color: HexColor.fromHex('#2196EF')),
                        right: language == "English"
                            ? BorderSide.none
                            : BorderSide(
                                color: HexColor.fromHex("#2196EF"),
                              ))
                    :Border(
                        left: language == "English"
                            ? BorderSide.none
                            : BorderSide(color: HexColor.fromHex('#2196EF')),
                        right: language == "Arabic"
                            ? BorderSide.none
                            : BorderSide(
                                color: HexColor.fromHex("#2196EF"),
                              ))),
                child: TextButton(
                    onPressed: () {
                      if(gotController.quranAyaatSearchList.isNotEmpty){
                        gotController.replaceSearchAyaah(gotController.quranAyaatSearchList[index].ChapterId, gotController.quranAyaatSearchList[index].VerseId, "Tamil");
                        return;
                      }
                      gotController.addAyaat(gotController.quranAyaat[index].ChapterId, gotController.quranAyaat[index].VerseId, "Tamil");
                    },
                    child: Text(
                      'Tamil',
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          color: language != "Tamil"
                              ? HexColor.fromHex("#2196EF")
                              : ColorManager.white),
                    )),
              )),
              Expanded(
                  child: Container(
                decoration: BoxDecoration(
                  borderRadius: Get.locale!.languageCode == "ar" ||
                          Get.locale!.languageCode == "ur"
                      ? BorderRadius.only(
                          topLeft: Radius.circular(AppSize.S_40.r),
                          bottomLeft: Radius.circular(AppSize.S_40.r),
                        )
                      : BorderRadius.only(
                          topRight: Radius.circular(AppSize.S_40.r),
                          bottomRight: Radius.circular(AppSize.S_40.r),
                        ),
                  color: language == "Arabic"
                      ? HexColor.fromHex("#2196EF")
                      : ColorManager.white,
                ),
                child: TextButton(
                    onPressed: () {
                      if(gotController.quranAyaatSearchList.isNotEmpty){
                        gotController.replaceSearchAyaah(gotController.quranAyaatSearchList[index].ChapterId, gotController.quranAyaatSearchList[index].VerseId, "Arabic");
                        return;
                      }
                      gotController.addAyaat(gotController.quranAyaat[index].ChapterId, gotController.quranAyaat[index].VerseId, "Arabic");
                    },
                    child: Text(
                      'Arabic',
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          color: language != "Arabic"
                              ? HexColor.fromHex("#2196EF")
                              : ColorManager.white),
                    )),
              )),
            ],
          )),
    );
  }
}
