import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:quran/about_us/screen/about_us_screen.dart';
import 'package:quran/common_widget/custom_background_widget.dart';
import 'package:quran/common_widget/custom_button_widget.dart';
import 'package:quran/home/screen/home_screen.dart';
import 'package:quran/language_selection/widgets/language_radio_widget.dart';
import 'package:quran/resources/app_open_first_time.dart';
import 'package:quran/resources/constants.dart';

class LanguageSelectionScreen extends StatelessWidget {
  const LanguageSelectionScreen({super.key});
  
  updateLanguage(Locale locale) {
      Get.updateLocale(locale);
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return CustomBackgroundWidget(
      size: size,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'language_selection'.tr,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.displayLarge,
          ),
          SizedBox(height: AppSize.S_40.h,),
          ...Constants.languages.map((language) =>  Padding(
            padding: EdgeInsets.only(bottom: AppSize.S_12.h),
            child: CustomButtonWidget(
                width: size.width,
                yPadd: AppSize.S_12,
                onPressed: () {
                  updateLanguage(language['local']);
                  AppSession.prefs.setString("app_locale", language['language_name']);
                  Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: ((context) => AppOpen().getIsAppOpenFirstTime ? const AboutUsScreen() : HomeScreen())));
                },
                child: LanguageRadioWidget(language: language,  onChanged: (_){
                  updateLanguage(language['local']);
                  // AppSession.prefs.setString("app_locale", jsonEncode(language['local']));
                }),),
          ),),
        ],
      ),
    );
  }
}
