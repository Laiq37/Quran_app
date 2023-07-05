import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:quran/home/goto/controller/gotoSearch_controller.dart';
import 'package:quran/data/dbmodel.dart';
import 'package:quran/home/notes/screen/create_note_screen.dart';
import 'package:quran/quran_chapter_detail/controller/surah_ayaah_controller.dart';
import 'package:quran/resources/colors_manager.dart';
import 'package:quran/resources/constants.dart';
import 'package:share_plus/share_plus.dart';

class ShareIconWidget extends StatelessWidget {
  final Alignment alignment;
  final int index;
  final bool isOnGoto;
  final String language;
  const ShareIconWidget(
      {required this.alignment,
      required this.index,
      required this.isOnGoto,
      required this.language,
      super.key});

  String getFullAyaahContent() {
    late final QuranAyaat ayaat;
    if (isOnGoto) {
      final GotoController gotoController = Get.find<GotoController>();
      ayaat = gotoController.quranAyaatSearchList.isEmpty
          ? gotoController.quranAyaat[index]
          : gotoController.quranAyaatSearchList[index];
    } else {
      final SurahAyaahController surahAyaahController =
          Get.find<SurahAyaahController>();
      ayaat = surahAyaahController.getSurahForShare(index);
      if(surahAyaahController.surahClipboardAyaahId.isNotEmpty){
        Future.delayed(const Duration(milliseconds: 500), () => surahAyaahController.clearClipboardList());
      }
    }
    final title =
        ayaat.DialogueTitle == 'null' ? '' : '${ayaat.DialogueTitle}\n\n';
    final footNote = ayaat.FootNote == 'null' ? '' : '\n\n${ayaat.FootNote}';
    return '(${int.parse(ayaat.ChapterId) < 10 ? "0${ayaat.ChapterId}" : ayaat.ChapterId}:${int.parse(ayaat.VerseId) < 10 ? "0${ayaat.VerseId}" : ayaat.VerseId})\n$title${ayaat.Dialogues}$footNote';
  }

  void sendAyaah(context) async {
    final navigator = Navigator.of(context);
    await Future.delayed(Duration.zero);
    navigator.push(MaterialPageRoute(
        builder: (context) =>
            CreateNoteScreen(ayaatContent: getFullAyaahContent())));
  }

  void shareAyaah() async {
    await Share.share(getFullAyaahContent());
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      radius: AppSize.S_100.r,
      onTapDown: (postionDetail) async => await showMenu(
        context: context,
        position: RelativeRect.fromLTRB(language != 'Arabic' ? postionDetail.globalPosition.dx :50,
            postionDetail.globalPosition.dy + 10, 50, 0),
        items: [
          PopupMenuItem(
              onTap: () => sendAyaah(context),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Send to Note'),
                  Icon(
                    Icons.note_add_outlined,
                    color: Theme.of(context).colorScheme.primary,
                    size: AppSize.S_30.r,
                  )
                ],
              )),
          PopupMenuItem(
            onTap: () => shareAyaah(),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Other Apps'),
                Icon(Icons.send_to_mobile, color: Theme.of(context).colorScheme.primary, size: AppSize.S_30.r,)
              ],
            ),
          ),
        ],
        elevation: 8.0,
      ),
      child: Icon(
        Icons.share,
        size: AppSize.S_24.r,
        color: ColorManager.iconColor,
      ),
    );
  }
}
