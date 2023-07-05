import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:quran/common_widget/custom_alert_dialogue.dart';
import 'package:quran/common_widget/custom_snackbar.dart';
import 'package:quran/home/goto/controller/gotoSearch_controller.dart';
import 'package:quran/home/notes/controller/notes_controller.dart';
import 'package:quran/home/notes/screen/create_note_screen.dart';
import 'package:quran/quran_chapter_detail/controller/surah_ayaah_controller.dart';
import 'package:quran/resources/colors_manager.dart';
import 'package:quran/resources/constants.dart';
import 'package:share_plus/share_plus.dart';

class AppBarWidget extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  final String title;
  final bool onHomeScreen;
  final bool showIosBackButton;
  final int? id;
  const AppBarWidget({
    required this.scaffoldKey,
    required this.title,
    this.onHomeScreen = true,
    this.showIosBackButton = false,
    this.id,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    print("Id $id");
    final NotesController notesController = Get.find<NotesController>();
    final SurahAyaahController surahAyaahController =
        Get.find<SurahAyaahController>();
    final GotoController gotoController =
        Get.find<GotoController>();
    // print("Note ==> $createNote");
    return Obx(() {
      return Row(
        // mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: Platform.isIOS && showIosBackButton
                ? () => Navigator.pop(context)
                : () {
                    if (scaffoldKey.currentState!.isDrawerOpen) {
                      scaffoldKey.currentState!.openEndDrawer();
                    } else {
                      scaffoldKey.currentState!.openDrawer();
                    }
                  },
            child: Icon(
              Platform.isIOS && showIosBackButton
                  ? Icons.arrow_back_ios_new
                  : Icons.menu_rounded,
              color: ColorManager.textTitle,
              size: AppSize.S_38.r,
            ),
            // padding: EdgeInsets.all(0),
            // alignment: Get.locale!.languageCode != 'ar' &&
            //         Get.locale!.languageCode != 'ur'
            //     ? Alignment.centerLeft
            //     : Alignment.centerRight,
          ),
          SizedBox(
            width: AppSize.S_14.w,
          ),
          // if (!onHomeScreen && Get.locale?.languageCode == 'tm')
            Container(
              // width: 225.w,
              // alignment: Alignment.topLeft,
              constraints: BoxConstraints(maxWidth: 225.w),
                child: id == null ? Text(title.tr,
                // textAlign: TextAlign.start,
                maxLines: 3,
                    style: Theme.of(context).textTheme.displayMedium) : Text("$id ${title.tr}",
                // textAlign: TextAlign.start,
                maxLines: 3,
                    style: Theme.of(context).textTheme.displayMedium)),
          // if (onHomeScreen || Get.locale?.languageCode != 'tm')
          //   Text(title.tr, style: Theme.of(context).textTheme.displayMedium),
          const Expanded(child: SizedBox()),
          if (notesController.deleteList.isNotEmpty ||
              surahAyaahController.surahClipboardAyaahId.isNotEmpty || gotoController.surahClipboardAyaahId.isNotEmpty)
            InkWell(
              onTap: () {
                if (surahAyaahController.surahClipboardAyaahId.isNotEmpty) {
                  surahAyaahController.copyContentToClipboard().then((_) {
                    surahAyaahController.clearClipboardList();
                    ScaffoldMessenger.of(context).showSnackBar(
                        CustomSnackBar.getSnackBar(context, 'Content Copied!'));
                  });
                  return;
                }

                if (gotoController.surahClipboardAyaahId.isNotEmpty) {
                  gotoController.copyContentToClipboard().then((_) {
                    gotoController.clearClipboardList();
                    ScaffoldMessenger.of(context).showSnackBar(
                        CustomSnackBar.getSnackBar(context, 'Content Copied!'));
                  });
                  return;
                }


                showDialog(
                  context: context,
                  builder: (context) {
                    return CustomAlertDialogue(
                      text:
                          'Are you sure to delete ${notesController.deleteList.length} ${notesController.deleteList.length < 2 ? 'item' : 'items'}',
                      onPressed: () {
                        notesController.deleteNotes();
                        Navigator.pop(context);
                      },
                    );
                  },
                );
              },
              // alignment: Get.locale!.languageCode != 'ar' &&
              //         Get.locale!.languageCode != 'ur'
              //     ? Alignment.centerRight
              //     : Alignment.centerLeft,
              child: Icon(
                surahAyaahController.surahClipboardAyaahId.isNotEmpty || gotoController.surahClipboardAyaahId.isNotEmpty
                    ? Icons.copy
                    : Icons.delete,
                color: ColorManager.white,
                size: AppSize.S_30.r,
              ),
            ),
          if (surahAyaahController.surahClipboardAyaahId.isNotEmpty || gotoController.surahClipboardAyaahId.isNotEmpty)
            SizedBox(
              width: AppSize.S_20.w,
            ),
          if (surahAyaahController.surahClipboardAyaahId.isNotEmpty)
            InkWell(
              // radius: AppSize.S_100.r,
              onTapDown: (postionDetail) async => await showMenu(
                context: context,
                position: RelativeRect.fromLTRB(postionDetail.globalPosition.dx,
                    postionDetail.globalPosition.dy + 10, AppSize.S_26.w, 0),
                items: [
                  PopupMenuItem(
                      onTap: () async {
                        final navigator = Navigator.of(context);
                        await Future.delayed(Duration.zero);
                        // print('shareAyaah');
                        navigator.push(MaterialPageRoute(
                            builder: (context) => CreateNoteScreen(
                                ayaatContent: surahAyaahController
                                    .surahClipboardAyaah
                                    .join('<br><br>'))));
                        Future.delayed(const Duration(milliseconds: 500),()=>surahAyaahController.clearClipboardList());
                      },
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
                    onTap: () async {
                      await Share.share(surahAyaahController.surahClipboardAyaah
                          .join('\n\n'));
                      surahAyaahController.clearClipboardList();
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Other Apps'),
                        Icon(
                          Icons.send_to_mobile,
                          color: Theme.of(context).colorScheme.primary,
                          size: AppSize.S_30.r,
                        )
                      ],
                    ),
                  ),
                ],
                elevation: 8.0,
              ),
              child: Icon(
                Icons.share,
                color: ColorManager.white,
                size: AppSize.S_30.r,
              ),
            ),
            if (gotoController.surahClipboardAyaahId.isNotEmpty)
            InkWell(
              // radius: AppSize.S_100.r,
              onTapDown: (postionDetail) async => await showMenu(
                context: context,
                position: RelativeRect.fromLTRB(postionDetail.globalPosition.dx,
                    postionDetail.globalPosition.dy + 10, AppSize.S_26.w, 0),
                items: [
                  PopupMenuItem(
                      onTap: () async {
                        final navigator = Navigator.of(context);
                        await Future.delayed(Duration.zero);
                        // print('shareAyaah');
                        navigator.push(MaterialPageRoute(
                            builder: (context) => CreateNoteScreen(
                                ayaatContent: gotoController
                                    .surahClipboardAyaah
                                    .join('<br><br>'))));
                        Future.delayed(const Duration(milliseconds: 500),()=>gotoController.clearClipboardList());
                      },
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
                    onTap: () async {
                      await Share.share(gotoController.surahClipboardAyaah
                          .join('\n\n'));
                      gotoController.clearClipboardList();
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Other Apps'),
                        Icon(
                          Icons.send_to_mobile,
                          color: Theme.of(context).colorScheme.primary,
                          size: AppSize.S_30.r,
                        )
                      ],
                    ),
                  ),
                ],
                elevation: 8.0,
              ),
              child: Icon(
                Icons.share,
                color: ColorManager.white,
                size: AppSize.S_30.r,
              ),
            )
        ],
      );
    });
  }
}
