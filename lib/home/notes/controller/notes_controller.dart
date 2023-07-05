import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quran/data/dbhelper.dart';
import 'package:quran/home/notes/models/note_model.dart';
import 'package:quran/resources/constants.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

class NotesController extends GetxController {
  final RxList<Note> notesList = <Note>[].obs;
  final RxList<String> deleteList = <String>[].obs;
  RxBool isLoading = false.obs;
  bool isSearch = false;

  Future<void> getNotes([String? searchText]) async {
    if (searchText != null && searchText.trim() != '' && !isSearch) {
      isSearch = true;
    } else if ((searchText == null || searchText.trim() == '') && isSearch) {
      isSearch = false;
    } else if (searchText?.trim() == '' && !isSearch) {
      return;
    }
    notesList.clear();
    Future.delayed(Duration.zero, () => deleteList.clear());
    isLoading(true);
    try {
      final notes = await DbHelper.getNote('user_notes', searchText);
      notesList.addAll(
          [for (Map<String, dynamic> note in notes) Note.fromJson(note)]);
          if(searchText != null && searchText.trim() != '' && notesList.isEmpty)throw 'Not Found';
    } catch (e) {
      throw e == 'Not Found' ? 'No match Found!' : 'Something went wrong!';
    } finally {
      isLoading(false);
    }
  }

  Future<void> createNote(String title, String descriptionText,
      List descriptionContentList, htmlContent) async {
    try {
      if (title == '' && descriptionText == '') throw '';
      // images = ['asasdad.png'];
      const Uuid uuid = Uuid();
      final DateTime now = DateTime.now();
      final Map<String, dynamic> notesMap = {
        'id': uuid.v1(),
        'title': title,
        'descriptionText': descriptionText,
        'descriptionContentList': jsonEncode(descriptionContentList),
        'htmlDescription': htmlContent,
        'createdAt': DateFormat.yMd().format(now)
      };
      await DbHelper.insertNote('user_notes', notesMap);
      notesList.add(Note.fromJson(notesMap));
      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      print(e);
      rethrow;
    }
  }

  Future<void> updateNote(Note oldNote, String title, String descriptionText,
      List descriptionContentList, htmlContent) async {
    try {
      if (oldNote.title == title &&
          oldNote.descriptionText == descriptionText &&
          jsonEncode(oldNote.descriptionContentList) ==
              jsonEncode(descriptionContentList)) return;
      await DbHelper.updateNote('user_notes', oldNote.id, title,
          descriptionText, jsonEncode(descriptionContentList), htmlContent);
      final int currentIndex = notesList.indexOf(oldNote);
      notesList[currentIndex] = Note(
          id: oldNote.id,
          title: title,
          descriptionText: descriptionText,
          descriptionContentList: descriptionContentList,
          htmlDescription: htmlContent,
          createdAt: oldNote.createdAt);
      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      rethrow;
    }
  }

  Future<void> deleteNote(String id) async {
    try {
      await DbHelper.deleteNote('user_notes', id);
      notesList.removeWhere((note) => note.id == id);
    } catch (e) {
      print(e);
    }
  }

  void deleteNotes() async {
    try {
      await DbHelper.deleteNotes('user_notes', deleteList);
      notesList.removeWhere((note) => deleteList.contains(note.id));
      deleteList.clear();
    } catch (e) {
      print(e);
    }
  }

  addNoteInDeletionList(String id) {
    deleteList.add(id);
  }

  removeNoteFromDeletionList(String id) {
    deleteList.removeWhere((noteId) => noteId == id);
  }

  clearDeleteList() {
    deleteList.clear();
  }

  String getDescriptionText(String str) {
    final descriptiontext =
        str.split(RegExp(r"<\/*(br|p|img[^>]*)>|&nbsp;| *\/ *div *>"));
    descriptiontext.removeWhere((element) =>
        element.trim() == '' ||
        (element.contains('src=') && element.contains('class=')));
    return descriptiontext.join(" ");
  }

  List getDescriptionContentList(String str) {
    str = str.replaceAll('<br>', '\n');
    final List description = str
        .split(RegExp(r'<\/*(br|p|img)>*|alt *= *"img">|&nbsp;| *\/ *div *>'));
    description.removeWhere((element) => element.trim() == '');
    final List<Map<String, String>> desciptionContentList = [];
    for (String str in description) {
      str = str.trim();
      if (str.startsWith('src=') && str.contains('class=')) {
        desciptionContentList.add({
          'content': str.split('=').last.replaceAll('"', ''),
          'type': 'img'
        });
        continue;
      }
      if (desciptionContentList.isNotEmpty &&
          desciptionContentList.last['type'] == 'text') {
        desciptionContentList[desciptionContentList.length - 1]['content'] =
            '${desciptionContentList.last['content']} ${str.replaceAll(RegExp(r'<\w*>*'), '')}';
        continue;
      }
      desciptionContentList.add(
          {'content': str.replaceAll(RegExp(r'<\w*>*'), ''), 'type': 'text'});
    }
    return desciptionContentList;
  }

  String setImage(file) {
    return """<br><img src=${file.path} style="margin-left: auto;display: block;border-radius: 10%; margin-right: auto;" width="${AppSize.S_200}" height="${AppSize.S_200}" data-filename=${file.name} class=${file.path} alt="img"><br>""";
  }
}
