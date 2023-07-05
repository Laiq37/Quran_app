import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quran/about_us/screen/about_us_screen.dart';
import 'package:quran/home/notes/screen/create_note_screen.dart';
import 'package:quran/home/screen/home_screen.dart';
import 'package:quran/home/widgets/drawer_title_widget.dart';
import 'package:quran/language_selection/screen/language_selection_screen.dart';
import 'package:quran/resources/colors_manager.dart';
import 'package:quran/resources/constants.dart';
import 'package:get/get.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({ super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.only(top: AppSize.S_20.h, bottom: AppSize.S_20.h, left: AppSize.S_20.w, right: AppSize.S_20.w),
            height: AppSize.S_140.h,
            color: Theme.of(context).colorScheme.primary,
            child: const DrawerTitleWidget(),
          ),
          Padding(padding: EdgeInsets.only(top: AppSize.S_34.h, left: AppSize.S_20.w),
          child: Column(
            children: [
              ...Constants.DRAWER_ITEMS.map((item)=> Padding(
                padding:  EdgeInsets.only(bottom: AppSize.S_20.h),
                child: InkWell(
                  onTap: (() => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
                    if(item['item_name'].toString().tr == 'change_language'.tr) {
                      return const LanguageSelectionScreen();
                    } else if(item['item_name'].toString().tr  == 'about_us_title'.tr){
                      return const AboutUsScreen();
                    }
                    return HomeScreen();
                  }))),
                  child: Row(children: [
                    Icon(item['icon'],),
                    SizedBox(width: AppSize.S_20.w,),
                    Text(item['item_name'].toString().tr, style: Theme.of(context).textTheme.titleMedium!.copyWith(color: HexColor.fromHex('#7F8EA1')),)
                  ],),
                ),
              ))
            ],
          ),
          )
        ],
      ),
    );
  }
}