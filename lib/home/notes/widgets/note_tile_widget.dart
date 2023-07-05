import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:quran/home/notes/controller/notes_controller.dart';
import 'package:quran/home/notes/models/note_model.dart';
import 'package:quran/home/notes/screen/notes_detail_screen.dart';
import 'package:quran/home/widgets/custom_container.dart';
import 'package:quran/resources/colors_manager.dart';
import 'package:quran/resources/constants.dart';

class NoteTileWidget extends StatelessWidget {
  final Note note;
  const NoteTileWidget({required this.note, super.key});

  @override
  Widget build(BuildContext context) {
  final NotesController notesController = Get.find<NotesController>();
    print("Notesss ==> $note");
    return GestureDetector(
      onLongPress: (){
            if(notesController.deleteList.isNotEmpty)return;
            notesController.addNoteInDeletionList(note.id);
          },
          onTap: (){
            if(notesController.deleteList.isEmpty){
                 Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => NotesDetails(
                    note: note,
                  )),
        );
        return;
            }
            if(notesController.deleteList.contains(note.id)){
              notesController.removeNoteFromDeletionList(note.id);
              return;
            }
            notesController.addNoteInDeletionList(note.id);
          },
      child: CustomContainer(
          xPad: AppSize.S_26.w,
          yPad: AppSize.S_16.h,
          mYPad: AppSize.S_8.h,
          child: Row(
            children: [
              Obx((() => 
                Stack(clipBehavior: Clip.none, children: [
                  Image.asset(
                    ImageAssets.NOTES_ICON,
                    height: 30.h,
                    width: 27.51.w,
                  ),
                  if(notesController.deleteList.contains(note.id)) 
                  Positioned(
                      bottom: -5.r,
                      right: -6.r,
                      child: CircleAvatar(
                          backgroundColor: ColorManager.white,
                          radius: 11.r,
                          child: CircleAvatar(
                              backgroundColor:
                                  Theme.of(context).colorScheme.error,
                              radius: 9.r,
                              child: Center(
                                  child: Icon(
                                Icons.done,
                                size: 14.r,
                              )))))
                ])
              ),),
              SizedBox(
                width: AppSize.S_20.w,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      note.title,
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    Text(note.createdAt,
                  style: Theme.of(context)
                      .textTheme
                      .labelMedium!
                      .copyWith(color: ColorManager.subtitle))
                    // Text(
                    //   note.descriptionText,
                    //   maxLines: 1,
                    //   style: Theme.of(context)
                    //       .textTheme
                    //       .labelMedium!
                    //       .copyWith(color: ColorManager.subtitle),
                    //   overflow: TextOverflow.ellipsis,
                    // ),
                  ],
                ),
              ),
              // SizedBox(
              //   width: AppSize.S_24.w,
              // ),
              // Text(note.createdAt,
              //     style: Theme.of(context)
              //         .textTheme
              //         .labelMedium!
              //         .copyWith(color: ColorManager.subtitle)),
            ],
          )),
    );
    ;
  }
}
