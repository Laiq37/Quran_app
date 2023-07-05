

import 'package:html_editor_enhanced/html_editor.dart';
import 'package:quran/home/notes/controller/notes_controller.dart';

class CommonFunction{

  static Future<void> saveNote(HtmlEditorController htmlEditorController,NotesController notesController, note,String title,  context)async{
    try {
      final String htmlContent = await htmlEditorController.getText();
      // if(title.trim() == '' && htmlContent.trim() == '')return;
              notesController.isLoading.value = true;
              final String descriptionText =
                  notesController.getDescriptionText(htmlContent);
              final List descriptionContentList =
                  notesController.getDescriptionContentList(htmlContent);
              if (note == null) {
                await notesController.createNote(title,
                    descriptionText, descriptionContentList, htmlContent);
              } else {
                await notesController.updateNote(
                    note!,
                    title,
                    descriptionText,
                    descriptionContentList,
                    htmlContent);
              }}catch(e){
                if(notesController.isLoading.value){
                  notesController.isLoading.value = false;
                }
                rethrow;
              }
  }


}