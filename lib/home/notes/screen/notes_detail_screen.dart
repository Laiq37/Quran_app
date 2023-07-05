import 'dart:io';

import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';
import 'package:quran/common_widget/custom_alert_dialogue.dart';
import 'package:quran/common_widget/screen_template_widget.dart';
import 'package:get/get.dart';
import 'package:quran/home/notes/controller/notes_controller.dart';
import 'package:quran/home/notes/models/note_model.dart';
import 'package:quran/home/notes/screen/create_note_screen.dart';
import 'package:quran/home/notes/widgets/icon_button_widget.dart';
import 'package:quran/home/widgets/custom_container.dart';
import 'package:quran/resources/constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quran/resources/font_manager.dart';

class NotesDetails extends StatelessWidget {
  final Note note;
  const NotesDetails({super.key, required this.note});

  @override
  Widget build(BuildContext context) {
    final NotesController notesController = Get.find<NotesController>();
    print("notesController $notesController");
    final Size size = MediaQuery.of(context).size;
    return ScreenTemplateWidget(
        scaffoldKey: GlobalKey(),
        onHomeScreen: false,
        title: 'notes_detail_title'.tr,
        id: null,
        child: Padding(
          padding: EdgeInsets.only(top: AppSize.S_20.h, left: AppSize.S_26.w, right: AppSize.S_26.w),
          child: Column(
            children: [
              Flexible(
                flex: 3,
                child: CustomContainer(
                  xPad: AppSize.S_26.w,
                  yPad: AppSize.S_20.h,
                  child: ListView(
                    padding: EdgeInsets.zero,
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    // mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                              child: Text(
                            note.title,
                            style: Theme.of(context).textTheme.headlineLarge,
                          )),
                          Padding(
                            padding:
                                EdgeInsets.symmetric(horizontal: AppSize.S_8.w),
                            child: IconButtonWidget(
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return CustomAlertDialogue(
                                          text:
                                              'Do you want to delete this note?',
                                          onPressed: () {
                                            notesController.deleteNote(note.id);
                                            Navigator.pop(context);
                                            Navigator.pop(context);
                                          });
                                    },
                                  );
                                },
                                icon: Icons.delete),
                          ),
                          IconButtonWidget(
                              onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          CreateNoteScreen(note: note))),
                              icon: Icons.edit)
                        ],
                      ),
                      SizedBox(
                        height: AppSize.S_16.h,
                      ),
                      // Text(note.description, style: Theme.of(context).textTheme.labelMedium,),
                      ...note.descriptionContentList.map((content) {
                        return Padding(
                            padding:
                                EdgeInsets.symmetric(vertical: AppSize.S_4.r),
                            child: content['type'] == 'text'
                                ? Text(
                                    content['content'],
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelMedium!
                                        .copyWith(
                                            fontSize: FontSizeManager.s18.sp),
                                  )
                                : InkWell(
                                    onTap: () {
                                      OpenFile.open(content['content']);
                                    },
                                    child: Center(
                                      child: ClipRRect(
                                          borderRadius: BorderRadius.circular(
                                              AppSize.S_24.r),
                                          child: Image.file(
                                            File(
                                              content['content'],
                                            ),
                                            fit: BoxFit.cover,
                                            width: size.width,
                                            height: AppSize.S_200.h,
                                          )),
                                    ),
                                  ));
                      }),
                      SizedBox(
                        height: AppSize.S_30.h,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: AppSize.S_30.h,
              ),
              // Flexible(
              //   // flex: 1,
              //   child: CustomButtonWidget(
              //     width: size.width * 0.5,
              //     yPadd: AppSize.S_8.h,
              //     color: Theme.of(context).colorScheme.primary,
              //     onPressed: () {},
              //     child: Text(
              //       'save'.tr,
              //       style: Theme.of(context).textTheme.headlineSmall!.copyWith(
              //           color: ColorManager.white,
              //           fontSize: FontSizeManager.s20.sp),
              //     ),
              //   ),
              // ),
            ],
          ),
        ));
  }
}
