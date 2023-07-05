import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quran/common_widget/dailogue_title_widget.dart';
import 'package:quran/common_widget/dialogue_widget.dart';
import 'package:quran/common_widget/foot_note_widget.dart';
import 'package:quran/data/dbmodel.dart';
import 'package:quran/home/widgets/custom_container.dart';
import 'package:quran/resources/colors_manager.dart';
import 'package:quran/resources/constants.dart';

class GotoVerseTileWidget extends StatelessWidget {
  final QuranAyaat chapterVerse;
  final int index;
  final bool isOnGoto;
  const GotoVerseTileWidget(
      {required this.chapterVerse,
      required this.index,
      this.isOnGoto = true,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      borderRadius: AppSize.S_24.r,
      xPad: AppSize.S_16.w,
      yPad: AppSize.S_12.h,
      child: Column(
        children: [
                if (chapterVerse.DialogueTitle != "null")
                  DailogueTitleWidget(
                    chapterNo: int.parse(chapterVerse.ChapterId),
                    verseNo: int.parse(chapterVerse.VerseId),
                    title: chapterVerse.DialogueTitle,
                    language: chapterVerse.Language,
                    index: index,
                    isOnGoto: isOnGoto,
                  ),
                CustomContainer(
                  borderRadius: 24.r,
                  border: Border.all(color: ColorManager.border),
                  color: HexColor.fromHex('#F1FBFC'),
                  child: Padding(
                      padding: EdgeInsets.only(
                          left: AppSize.S_16.w,
                          right: AppSize.S_16.w,
                          top: AppSize.S_20.h,
                          bottom: AppSize.S_20.h),
                      child: DialogueWidget(
                        chapterNo: int.parse(chapterVerse.ChapterId),
                        dialogue: chapterVerse.Dialogues,
                        dialogueTitle: chapterVerse.DialogueTitle,
                        language: chapterVerse.Language,
                        verseNo: int.parse(chapterVerse.VerseId),
                        index: index,
                        isOnGoto: isOnGoto,
                      )),
                ),
                if (chapterVerse.FootNote != "null")
                  FootNoteWidget(
                    language: chapterVerse.Language,
                    footNote: chapterVerse.FootNote,
                    isOnGoto: isOnGoto,
                  ),
              ],
            ));
          // ),
    //     ],
    //   ),
    // )
  }
}
