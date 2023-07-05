import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quran/home/common.dart';
import 'package:quran/resources/constants.dart';
import 'package:substring_highlight/substring_highlight.dart';

class FootNoteWidget extends StatelessWidget {
  final String? language;
  final String footNote;
  final bool isOnGoto;
  const FootNoteWidget({required this.language,required this.footNote, this.isOnGoto = false, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: AppSize.S_16.h),
      child: SubstringHighlight(
                    term: isOnGoto ? Common.homeSearch.searchAyaatSubstring : Common.ayahSearch.searchAyaatSubstring,
                    text: footNote,
                    textStyle: Theme.of(context).textTheme.labelSmall!,
                    textAlign: TextAlign.center,
                    textStyleHighlight: const TextStyle(backgroundColor: Colors.yellow)
                  ),
      // Text(
      //             footNote,
      //             textDirection: language != Constants.QuranAyaatsDetail[2]
      //                 ? TextDirection.ltr
      //                 : TextDirection.rtl,
      //             style: Theme.of(context).textTheme.labelSmall,
      //             textAlign: TextAlign.center,
      //           ),
    );
  }
}