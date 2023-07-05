import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:quran/common_widget/custom_button_widget.dart';
import 'package:quran/common_widget/custom_snackbar.dart';
import 'package:quran/home/goto/controller/gotoSearch_controller.dart';
import 'package:quran/data/dbhelper.dart';
import 'package:quran/data/dbmodel.dart';
import 'package:quran/home/screen/home_screen.dart';
import 'package:quran/home/widgets/custom_container.dart';
import 'package:quran/resources/colors_manager.dart';
import 'package:quran/resources/constants.dart';

class SearchAyaatDialogue extends StatefulWidget {
  const SearchAyaatDialogue({super.key});

  @override
  State<SearchAyaatDialogue> createState() => _SearchAyaatDialogueState();
}

class _SearchAyaatDialogueState extends State<SearchAyaatDialogue> {
  List<QuranAyaat> chapterSearchVerses = [];

  var chapterNum = TextEditingController();

  var verseNum = TextEditingController();

  final gotoController = Get.find<GotoController>();

  final locale = Get.locale!.languageCode;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    chapterNum.dispose();
    verseNum.dispose();
  }

  // void getSearchData() async {
  //   // var dbHelper = DbHelper();
  //   // QuranAyaat _quran_ayaats = await dbHelper.getGotoSearchAyaat(chapterNum.text, verseNum.text, "English");
  //   // chapterSearchVerses.add(_quran_ayaats);
  //   Navigator.pop(context);
  //   // Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen(),));
  // }

  @override
  Widget build(BuildContext context) {
    print("locale $locale");
    return Container(
      decoration:
          BoxDecoration(borderRadius: BorderRadius.circular(AppSize.S_24.r)),
      width: AppSize.S_280.w,
      height: AppSize.S_250.h,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomContainer(
              width: AppSize.S_200.h,
              yPad: AppSize.S_4.h,
              xPad: AppSize.S_16.w,
              color: HexColor.fromHex("#EFF7F5"),
              child: TextField(
                  keyboardType: TextInputType.number,
                  controller: chapterNum,
                  autofocus: true,
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.zero,
                      hintText: 'enter_surah'.tr,
                      hintStyle: Theme.of(context)
                          .textTheme
                          .labelMedium!
                          .copyWith(color: HexColor.fromHex("#ADADAD")),
                      border: InputBorder.none))),
          SizedBox(
            height: AppSize.S_16.h,
          ),
          CustomContainer(
              width: AppSize.S_200.h,
              yPad: AppSize.S_4.h,
              xPad: AppSize.S_16.w,
              color: HexColor.fromHex("#EFF7F5"),
              child: TextField(
                  keyboardType: TextInputType.number,
                  controller: verseNum,
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.zero,
                      hintText: 'enter_ayah'.tr,
                      hintStyle: Theme.of(context)
                          .textTheme
                          .labelMedium!
                          .copyWith(color: HexColor.fromHex("#ADADAD")),
                      border: InputBorder.none))),
          SizedBox(
            height: AppSize.S_16.h,
          ),
          CustomButtonWidget(
            width: AppSize.S_200.h,
            yPadd: AppSize.S_14.h,
            onPressed: ()async {
              // Navigator.pop(context);
              try {
                if (locale == 'en') {
                  await gotoController.addAyaat(
                      chapterNum.text, verseNum.text, "English");
                } else if (locale == "tm") {
                  await gotoController.addAyaat(
                      chapterNum.text, verseNum.text, "Tamil");
                } else {
                  await gotoController.addAyaat(
                      chapterNum.text, verseNum.text, "Arabic");
                }
              } catch (e) {
                if (mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      CustomSnackBar.getSnackBar(context, e== 'EXIST' ? 'Ayaat already EXIST!' : 'Something went wrong!'));
                }
                Get.back();
              }
            },
            text: 'add'.tr,
            style: Theme.of(context)
                .textTheme
                .titleMedium!
                .copyWith(color: ColorManager.white),
            color: Theme.of(context).colorScheme.primary,
          )
        ],
      ),
    );
  }
}
