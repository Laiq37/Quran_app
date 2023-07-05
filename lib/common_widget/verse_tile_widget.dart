import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quran/common_widget/dailogue_title_widget.dart';
import 'package:quran/common_widget/dialogue_widget.dart';
import 'package:quran/common_widget/foot_note_widget.dart';
import 'package:quran/data/dbmodel.dart';
import 'package:quran/home/widgets/custom_container.dart';
import 'package:quran/resources/colors_manager.dart';
import 'package:quran/resources/constants.dart';

class VerseTileWidget extends StatefulWidget {
  final QuranAyaat chapterVerse;
  final String? language;
  final int index;
  final bool isOnGoto;
  final CTab? cTab;
  const VerseTileWidget(
      {required this.chapterVerse,
      this.language,
      this.isOnGoto = false,
      required this.index,
      this.cTab,
      super.key});

  @override
  State<VerseTileWidget> createState() => _VerseTileWidgetState();
}

class _VerseTileWidgetState extends State<VerseTileWidget> {
  @override
  Widget build(BuildContext context) {
    // print(widget.language);
    return CustomContainer(
        borderRadius: AppSize.S_24.r,
        xPad: AppSize.S_16.w,
        yPad: AppSize.S_12.h,
        child: Column(
          children: [
            if (widget.chapterVerse.DialogueTitle != "null")
              DailogueTitleWidget(
                title: widget.chapterVerse.DialogueTitle,
                language: widget.language,
                index: widget.index,
                isOnGoto: widget.isOnGoto,
                chapterNo: int.parse( widget.chapterVerse.ChapterId),
                verseNo: int.parse( widget.chapterVerse.VerseId),
                cTab: widget.cTab,
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
                    chapterNo: int.parse( widget.chapterVerse.ChapterId),
                    dialogue: widget.chapterVerse.Dialogues,
                    dialogueTitle: widget.chapterVerse.DialogueTitle,
                    language: widget.language,
                    verseNo: int.parse( widget.chapterVerse.VerseId),
                    index: widget.index,
                    cTab: widget.cTab,
                    isOnGoto: widget.isOnGoto,
                  )),
            ),
            if (widget.chapterVerse.FootNote != "null")
              FootNoteWidget(
                language: widget.language,
                footNote: widget.chapterVerse.FootNote,
              ),
            // if (widget.isOnGoto)
            //   ChangeAyaatLanguageWidget(language: widget.language!, index: widget.index)
          ],
        ));
  }
}
