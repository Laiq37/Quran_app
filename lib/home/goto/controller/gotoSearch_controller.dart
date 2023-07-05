import 'package:clipboard/clipboard.dart';
import 'package:get/get.dart';
import 'package:quran/data/dbhelper.dart';
import 'package:quran/data/dbmodel.dart';
import 'package:quran/home/common.dart';

class GotoController extends GetxController {
  RxList<QuranAyaat> quranAyaat = <QuranAyaat>[].obs;
  RxList<QuranAyaat> quranAyaatSearchList = <QuranAyaat>[].obs;
  final List<String> surahClipboardAyaah =[];
  final RxList<String> surahClipboardAyaahId = <String>[].obs;
  RxBool isOnGoto = false.obs;

  void getAyaah() async {
    quranAyaat.addAll(await DbHelper().getGotoAyaah());
  }

  bool isNumeric(String s) {
    return double.tryParse(s) != null;
  }

  Future<void> addAyaat(
    surah_number,
    ayaat_number,
    language,
  ) async {
    // if (surah_number == '' || ayaat_number == '') {
    //   Get.back();
    //   return;
    // }
    try {
      if (!isNumeric(surah_number) || !isNumeric(ayaat_number)){
        throw 'Invalid Chapter or Verse number!';
      }
      final QuranAyaat? ayahExistInList = quranAyaat.firstWhereOrNull((ayah) =>
          ayah.ChapterId == surah_number && ayah.VerseId == ayaat_number);
      if (ayahExistInList != null && ayahExistInList.Language == language) {
        throw 'EXIST';
      }
      var dbHelper = DbHelper();
      QuranAyaat? _quran_ayaats = ayahExistInList == null
          ? await dbHelper.insertGotoAyaah(surah_number, ayaat_number)
          : await dbHelper.getGotoSearchAyaat(
              surah_number, ayaat_number, language);
      if (_quran_ayaats == null) {
        Get.back();
        return;
      }
      if (ayahExistInList != null) {
        final int ayahIndex = quranAyaat.indexOf(ayahExistInList);
        quranAyaat[ayahIndex] = _quran_ayaats;
        Get.back();
        return;
      }
      quranAyaat.insert(0,_quran_ayaats);
      Get.back();
    } catch (e) {
      rethrow;
    }
  }

  Future getSearchAyaah(searchText) async {
    try {
      clearClipboardList();
      if (searchText.trim() == '') {
        Common.homeSearch.searchAyaatSubstring ='';
        quranAyaatSearchList.clear();
        return;
      }
      quranAyaatSearchList.value = [
        ...await DbHelper().getSearchAyaah(searchText)
      ];
      Common.homeSearch.searchAyaatSubstring = searchText;
      if(quranAyaatSearchList.isEmpty)throw 'Not Found';
    } catch (e) {
      throw e.toString() == 'Not Found'? 'No match found!' : 'Something went wrong!';
      // print(e);
    }
  }

  replaceSearchAyaah(chapterNum, verseNum, language) async {
    QuranAyaat? ayaat = quranAyaatSearchList.firstWhereOrNull((quranAyaat) =>
        quranAyaat.ChapterId == chapterNum && quranAyaat.VerseId == verseNum);
    if (ayaat == null || ayaat.Language == language) return;
    final int ayaahIndex = quranAyaatSearchList.indexOf(ayaat);
    ayaat = await DbHelper().getGotoSearchAyaat(chapterNum, verseNum, language);
    if (ayaat == null) return;
    quranAyaatSearchList[ayaahIndex] = ayaat;
  }

  void clearGotoAyah() {
    try {
      DbHelper().clearGotoAyaah();
      quranAyaat.clear();
    } catch (e) {
      print(e);
    }
  }

  changeAyaahLanguage(chapterNum, verseNum, index, language)async{
    QuranAyaat? ayaat = await DbHelper().getGotoSearchAyaat(chapterNum, verseNum, language == 'Tamil' ? 'English' : language == 'English' ? 'Arabic' : 'Tamil');
    if (ayaat == null) return;
    if(quranAyaatSearchList.isNotEmpty){
      quranAyaatSearchList[index] = ayaat;
      return;
  }
  quranAyaat[index] = ayaat;
  }

  Future<void> copyContentToClipboard() async{
    await FlutterClipboard.copy(surahClipboardAyaah.join("\n\n"));
  }

  String getContentForClipboard(QuranAyaat chapterVerse){
    final String title = chapterVerse.DialogueTitle == 'null' ? '' : '${chapterVerse.DialogueTitle}\n\n';
        final String footNote = chapterVerse.FootNote == 'null' ? '' : '${chapterVerse.FootNote}\n\n';
        return '(${int.parse(chapterVerse.ChapterId) < 10 ? "0${chapterVerse.ChapterId}" : chapterVerse.ChapterId}:${int.parse(chapterVerse.VerseId) < 10 ? "0${chapterVerse.VerseId}" : chapterVerse.VerseId})\n\n$title${chapterVerse.Dialogues}$footNote';
  }

  void onTapCopyToClipboardList(QuranAyaat chapterVerse){
    if(surahClipboardAyaah.isEmpty)return;
        final String chapterVerseContent = getContentForClipboard(chapterVerse);
    if(surahClipboardAyaah.contains(chapterVerseContent)){
      surahClipboardAyaah.removeWhere((content) => content == chapterVerseContent);
      surahClipboardAyaahId.removeWhere((verseId) => verseId == "${chapterVerse.ChapterId}${chapterVerse.VerseId}");
      return;
    }
    surahClipboardAyaah.add(chapterVerseContent);
    surahClipboardAyaahId.add('${chapterVerse.ChapterId.toString()}${chapterVerse.VerseId.toString()}');
  }

  void onLongPressCopyToClipboardList(QuranAyaat chapterVerse){
    surahClipboardAyaah.add(getContentForClipboard(chapterVerse));
    surahClipboardAyaahId.add('${chapterVerse.ChapterId.toString()}${chapterVerse.VerseId.toString()}');
  }

  void clearClipboardList(){
    if(surahClipboardAyaah.isEmpty)return;
    surahClipboardAyaah.clear();
    surahClipboardAyaahId.clear();
  }
}
