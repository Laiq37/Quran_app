import 'dart:convert';
import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:html_editor_enhanced/html_editor.dart';
import 'package:image_picker/image_picker.dart';
import 'package:quran/common_widget/custom_button_widget.dart';
import 'package:quran/common_widget/custom_snackbar.dart';
import 'package:quran/home/notes/common_function.dart';
import 'package:quran/home/notes/controller/notes_controller.dart';
import 'package:quran/home/notes/models/note_model.dart';
import 'package:quran/home/widgets/custom_container.dart';
import 'package:quran/resources/colors_manager.dart';
import 'package:quran/resources/constants.dart';
import 'package:quran/resources/font_manager.dart';

class CreateNoteWidget extends StatefulWidget {
  final Note? note;
  final String? ayaatContent;
  const CreateNoteWidget({this.note, this.ayaatContent, super.key});

  @override
  State<CreateNoteWidget> createState() => _CreateNoteWidgetState();
}

class _CreateNoteWidgetState extends State<CreateNoteWidget> {
  late final TextEditingController titleContoller;
  final NotesController notesController = Get.find<NotesController>();
  FilePickerResult? result;
  PlatformFile? file;
  List<String> allPaths = [];
  File? cameraImagePath;
  late final HtmlEditorController htmlEditorController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    htmlEditorController = HtmlEditorController();
    titleContoller = TextEditingController();
    if (widget.note != null) {
      titleContoller.text = widget.note!.title;
      Future.delayed(const Duration(milliseconds: 1000),
          () => htmlEditorController.setText(widget.note!.htmlDescription));
    }
    else if(widget.ayaatContent != null){
      Future.delayed(const Duration(milliseconds: 1000),
          () => htmlEditorController.setText(widget.ayaatContent!));
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    titleContoller.dispose();
  }

  Future pickImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;
      htmlEditorController.insertHtml(notesController.setImage(image));

      Get.back();
    } 
    catch(e){
      throw 'Camera Permission Required!';
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.only(left: AppSize.S_26.w, right: AppSize.S_26.w),
      child: SingleChildScrollView(
        child: Column(
          children: [
            CustomContainer(
              xPad: 16.w,
              child: TextField(
                controller: titleContoller,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    //  border: OutlineInputBorder(),
                    hintText: 'note_title'.tr,
                    hintStyle: Theme.of(context).textTheme.headlineLarge),
              ),
            ),
            SizedBox(
              height: AppSize.S_12.h,
            ),
            HtmlEditor(
              controller: htmlEditorController, //required
              htmlEditorOptions: const HtmlEditorOptions(
                adjustHeightForKeyboard: true,

                // adjustHeightForKeyboard: false,
                // shouldEnsureVisible: true,
                characterLimit: 500,
                hint: "Description",
              ),
              htmlToolbarOptions: const HtmlToolbarOptions(
                // renderSeparatorWidget: false,
                defaultToolbarButtons: [],
              ),
              otherOptions: OtherOptions(
                  decoration: BoxDecoration(
                      border: Border.fromBorderSide(
                          BorderSide(color: ColorManager.white, width: 0)),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(AppSize.S_34.r),
                          topRight: Radius.circular(AppSize.S_34.r)),
                      color: ColorManager.white),
                  // decoration:,
                  height: 350),
            ),
            SizedBox(
              height: AppSize.S_12.h,
            ),
            DottedBorder(
              color: ColorManager.fieldBorder,
              strokeWidth: 1,
              dashPattern: [AppSize.S_8.w, AppSize.S_4.w],
              borderType: BorderType.RRect,
              radius: Radius.circular(AppSize.S_34.r),
              child: InkWell(
                onTap: () {
                  showModalBottomSheet<void>(
                    context: context,
                    builder: (BuildContext context) {
                      return Container(
                        height: 200,
                        color: Colors.white,
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              CustomButtonWidget(
                                width: size.width * 0.5,
                                yPadd: AppSize.S_8.h,
                                color: Theme.of(context).colorScheme.primary,
                                onPressed: () async {
                                  try{
                                  result = await FilePicker.platform.pickFiles(
                                      type: FileType.image, allowMultiple: true);
                                  if (result == null) return;
                                  print("result ==> ${result!.files}");
                                  for (int i = 0; i < result!.files.length; i++) {
                                    htmlEditorController.insertHtml(
                                        notesController
                                            .setImage(result!.files[i]));
                                  }
                                  }catch(e){
                                    if(mounted){
                                      ScaffoldMessenger.of(context).showSnackBar(CustomSnackBar.getSnackBar(context, "Storage Permission required!"));
                                    }
                                  }finally{
                                  Get.back();
                                  }
                                },
                                child: Text(
                                  'Pick From Gallery',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineSmall!
                                      .copyWith(
                                          color: ColorManager.white,
                                          fontSize: FontSizeManager.s20.sp),
                                ),
                              ),
                              CustomButtonWidget(
                                width: size.width * 0.5,
                                yPadd: AppSize.S_8.h,
                                color: Theme.of(context).colorScheme.primary,
                                onPressed: () {
                                  try{
                                  pickImage(ImageSource.camera);
                                  }
                                  catch(e){
                                    Get.back();
                                    if(mounted){
                                      ScaffoldMessenger.of(context).showSnackBar(CustomSnackBar.getSnackBar(context, e.toString()));
                                    }
                                  }
                                },
                                child: Text(
                                  'Pick From Camera',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineSmall!
                                      .copyWith(
                                          color: ColorManager.white,
                                          fontSize: FontSizeManager.s20.sp),
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
                child: CustomContainer(
                    borderRadius: AppSize.S_34.r,
                    xPad: AppSize.S_16.w,
                    yPad: AppSize.S_26.h,
                    child: Column(
                      children: [
                        const Image(
                            image: AssetImage(
                                "assets/images/image_placeholder.png")),
                        SizedBox(
                          height: AppSize.S_10.h,
                        ),
                        Text("add_images".tr,
                            style: Theme.of(context)
                                .textTheme
                                .labelMedium!
                                .copyWith(color: ColorManager.subtitle))
                      ],
                    )),
              ),
            ),
            SizedBox(
              height: AppSize.S_16.h,
            ),
            CustomButtonWidget(
              width: size.width * 0.5,
              yPadd: AppSize.S_8.h,
              color: Theme.of(context).colorScheme.primary,
              onPressed: () async {
                final notesStatus = widget.note == null ? 'created' : 'updated';
                try{
                 await CommonFunction.saveNote(htmlEditorController, notesController, widget.note, titleContoller.text, context);
                if(mounted){
                ScaffoldMessenger.of(context).showSnackBar(CustomSnackBar.getSnackBar(context, 'Note has been $notesStatus successfully'));
                }
                }
                catch(error){
                  print(error);
                  if(mounted){
                ScaffoldMessenger.of(context).showSnackBar(CustomSnackBar.getSnackBar(context, 'Notes has not been $notesStatus'));
                }
                }
                finally{
                  Future.delayed(Duration.zero, () => Navigator.of(context).pop());
                  if(notesStatus == 'updated'){
                    Get.back();
                  }
                }
              },
              child: Obx(
                () => notesController.isLoading.value
                    ? CircularProgressIndicator.adaptive(
                        backgroundColor: ColorManager.white,
                      )
                    : Text(
                        'save'.tr,
                        style: Theme.of(context)
                            .textTheme
                            .headlineSmall!
                            .copyWith(
                                color: ColorManager.white,
                                fontSize: FontSizeManager.s20.sp),
                      ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
