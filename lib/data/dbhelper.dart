import 'dart:async';
import 'dart:io' as io;
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:path/path.dart';
import 'package:quran/data/dbmodel.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class DbHelper {
  static final DbHelper _singleton = DbHelper._internal();

  factory DbHelper() {
    return _singleton;
  }

  DbHelper._internal();

  late final Database _ayahDb;
  static late final Database _noteDb;

  void initDb() async {
    _ayahDb = await initayahDb();
    _noteDb = await DbHelper.dataBase();
  }

  void closeDb() async {
    if(_ayahDb.isOpen){
    _ayahDb.close();
    }
    if(_noteDb.isOpen){
    _noteDb.close();
    }
  }

  initayahDb() async {
    io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "quran.db");
    bool dbExists = await io.File(path).exists();

    if (!dbExists) {
      // Copy from asset
      ByteData data = await rootBundle.load(join("assets", "quran.db"));
      List<int> bytes =
          data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

      // Write and flush the bytes written
      await io.File(path).writeAsBytes(bytes, flush: true);
    }

    var theDb = await openDatabase(path,
        onCreate: (db, version) => db.execute(
            'CREATE TABLE Goto_Verses(chapterId INT, verseId INT , CONSTRAINT PK_GOTO_Verses PRIMARY KEY (chapterId,verseId))'),
        version: 1);
    return theDb;
  }

  Future<QuranAyaat?> insertGotoAyaah(chapterId, verseId) async {
    try {
      final QuranAyaat? quranAyaat =
          await getGotoSearchAyaat(chapterId, verseId, 'English');
      if (quranAyaat == null) {
        throw 'Invalid Chapter or Verse number!';
      }
      try {
        await _ayahDb.insert(
            'Goto_Verses', {'chapterId': chapterId, 'verseId': verseId},
            conflictAlgorithm: ConflictAlgorithm.replace);
        return quranAyaat;
      } catch (e) {
        throw 'Something went wrong!';
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> clearGotoAyaah() async {
    try {
      _ayahDb.delete('Goto_Verses');
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<List<QuranAyaat>> getGotoAyaah() async {
    try {
      final gotoAyaats = await _ayahDb.rawQuery(
          'Select * From Goto_Verses INNER JOIN Tbl_Dialogues WHERE Goto_Verses.chapterid= Tbl_Dialogues.chapterid And Goto_Verses.verseid= Tbl_Dialogues.verseid And language = "English"');
      return gotoAyaats
          .map((ayaah) => QuranAyaat(
              ayaah["DialogueId"].toString(),
              ayaah["ChapterId"].toString(),
              ayaah["VerseId"].toString(),
              ayaah["DialogueTitle"].toString(),
              ayaah["Dialogues"].toString(),
              ayaah["FootNote"].toString(),
              ayaah["Language"].toString(),
              ayaah["IsActive"].toString()))
          .toList().reversed.toList();
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<List<QuranAyaat>> getSearchAyaah(searchText) async {
    try {
      List<Map> ayaahList = await _ayahDb.rawQuery(
          "SELECT * FROM Tbl_Dialogues where (LOWER(DialogueTitle) LIKE LOWER('%$searchText%') OR LOWER(Dialogues) LIKE LOWER('%$searchText%') OR LOWER(FootNote) LIKE LOWER('%$searchText%'))");
      return ayaahList
          .map((ayaah) => QuranAyaat(
              ayaah["DialogueId"].toString(),
              ayaah["ChapterId"].toString(),
              ayaah["VerseId"].toString(),
              ayaah["DialogueTitle"].toString(),
              ayaah["Dialogues"].toString(),
              ayaah["FootNote"].toString(),
              ayaah["Language"].toString(),
              ayaah["IsActive"].toString()))
          .toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<List<QuranAyaat>> getSearchToNavigate(
      id, language, String? searchText) async {
   try{ List<Map> list = await _ayahDb.rawQuery(searchText == null
        ? "SELECT * FROM Tbl_Dialogues where ChapterId = '$id' AND Language = '$language'"
        : "SELECT * FROM Tbl_Dialogues where ChapterId = '$id' AND Language = '$language' AND (LOWER(DialogueTitle) LIKE LOWER('%$searchText%') OR LOWER(Dialogues) LIKE LOWER('%$searchText%') OR LOWER(FootNote) LIKE LOWER('%$searchText%'))");

    if(list.isEmpty)throw 'Not Found';

    print(list.length);
    List<QuranAyaat> quranAyahs = [];
    for (int i = 0; i < list.length; i++) {
      quranAyahs.add(QuranAyaat(
          list[i]["DialogueId"].toString(),
          list[i]["ChapterId"].toString(),
          list[i]["VerseId"].toString(),
          list[i]["DialogueTitle"].toString(),
          list[i]["Dialogues"].toString(),
          list[i]["FootNote"].toString(),
          list[i]["Language"].toString(),
          list[i]["IsActive"].toString()));
    }
    return quranAyahs;}catch(e){
      throw e == 'Not Found' ? 'No match found!' : 'Something went wrong!';
    }
  }

  Future<QuranAyaat?> getGotoSearchAyaat(
      surah_number, ayaat_number, language) async {
    List<Map> list = await _ayahDb.rawQuery(
        "SELECT * FROM Tbl_Dialogues where ChapterId = '$surah_number' AND VerseId = '$ayaat_number' AND Language = '$language'");
    // SELECT * FROM quran_tranlation where ChapterId = '1' AND Language = 'English'
    // SELECT * FROM quran_tranlation where ChapterId = '22' AND VerseId = '24' AND Language = 'English'
    if (list.isEmpty) {
      return null;
    }
    return QuranAyaat(
        list[0]["DialogueId"].toString(),
        list[0]["ChapterId"].toString(),
        list[0]["VerseId"].toString(),
        list[0]["DialogueTitle"].toString(),
        list[0]["Dialogues"].toString(),
        list[0]["FootNote"].toString(),
        list[0]["Language"].toString(),
        list[0]["IsActive"].toString());
  }

  static Future<Database> dataBase() async {
    try {
      final dbPath = await getDatabasesPath();
      return openDatabase(join(dbPath, 'notes.db'), onCreate: (db, version) {
        return db.execute(
            'CREATE TABLE user_notes(id TEXT PRIMARY KEY, title TEXT, descriptionText TEXT, descriptionContentList TEXT, htmlDescription TEXT, createdAt TEXT)'); //real(same as double) is a datatype in sql
      }, version: 1);
    } catch (error) {
      print(error);
      rethrow;
    }
  }

  static Future<void> insertNote(
      String tableName, Map<String, dynamic> data) async {
    try {
      await _noteDb.insert(tableName, data,
          conflictAlgorithm: ConflictAlgorithm.replace);
    } catch (error) {
      print(error);
      rethrow;
    }
  }

  static Future<List<Map<String, dynamic>>> getNote(
      String tableName, String? searchText) async {
    try {
      return searchText != null && searchText != ''
          ? _noteDb.rawQuery(
              "SELECT * FROM $tableName WHERE LOWER(title) LIKE '%$searchText%' OR LOWER(descriptionText) LIKE '%$searchText%' ")
          : _noteDb.query(tableName);
    } catch (error) {
      print(error);
      rethrow;
    }
  }

  static Future<void> updateNote(
      String tableName,
      String id,
      String title,
      String descriptionText,
      String descriptionContentList,
      String htmlDescription) async {
    try {
      await _noteDb.rawUpdate(
          'UPDATE $tableName SET title = ?, descriptionText = ? , descriptionContentList = ? , htmlDescription = ? WHERE id = ?',
          [
            title,
            descriptionText,
            descriptionContentList,
            htmlDescription,
            id
          ]);
    } catch (error) {
      print(error);
      rethrow;
    }
  }

  static Future<void> deleteNote(String tableName, String id) async {
    try {
      await _noteDb.rawDelete('DELETE FROM $tableName WHERE id = ?', [id]);
    } catch (error) {
      print(error);
      rethrow;
    }
  }

  static Future<void> deleteNotes(String tableName, RxList notesIdList) async {
    try {
      for (var noteId in notesIdList) {
        await _noteDb
            .rawDelete('DELETE FROM $tableName WHERE id = ?', [noteId]);
      }
    } catch (error) {
      print(error);
      rethrow;
    }
  }
}
