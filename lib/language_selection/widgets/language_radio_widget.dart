import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:quran/resources/colors_manager.dart';
import 'package:quran/resources/constants.dart';
import 'package:quran/resources/font_manager.dart';

class LanguageRadioWidget extends StatelessWidget {
  final Map language;
  final Function(dynamic) onChanged;
  const LanguageRadioWidget(
      {required this.language,
      required this.onChanged,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: AppSize.S_34.w, right: AppSize.S_10.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          RichText(
              text: TextSpan(
            children: <TextSpan>[
              TextSpan(
                  text: language['language_name'],
                  style: Theme.of(context).textTheme.displaySmall),
              if (language['language_name_translation'] != null)
                TextSpan(
                  text: "(${language['language_name_translation']})",
                  style: Theme.of(context)
                      .textTheme
                      .labelMedium!
                      .copyWith(fontSize: FontSizeManager.s22),
                ),
            ],
          )),
          Radio(
            value: language['language_name'],
            groupValue: Get.locale!.languageCode == 'en'
                ? 'English'
                : Get.locale!.languageCode == 'ar'
                    ? 'Arabic'
                    : Get.locale!.languageCode == 'tm'
                        ? 'Tamil'
                        : 'Urdu',
            onChanged: onChanged,
            activeColor: ColorManager.primary,
          ),
        ],
      ),
    );
  }
}
