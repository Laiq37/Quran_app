import 'package:flutter/material.dart';
import 'package:quran/home/notes/models/note_model.dart';
import 'package:quran/home/notes/widgets/create_note_widget.dart';
import 'package:quran/common_widget/screen_template_widget.dart';

class CreateNoteScreen extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  final Note? note;
  final String? ayaatContent;
   CreateNoteScreen({this.note, this.ayaatContent, super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenTemplateWidget(scaffoldKey: scaffoldKey, isResizeBottomInsert: true, onHomeScreen: false, title: note == null ? 'create_note_title' : 'edit_note_title', showIosBackButton: true,id: null, child: CreateNoteWidget(note: note, ayaatContent: ayaatContent
    ));
  }
}
