import 'package:clipboard/clipboard.dart';
import 'package:get/get.dart';
import 'package:quran/data/dbhelper.dart';
import 'package:quran/data/dbmodel.dart';
import 'package:quran/home/common.dart';
import 'package:quran/home/controller/search_controller.dart';
import 'package:quran/resources/constants.dart';

class SurahAyaahController extends GetxController {
  int? chapterId;
  String? ayaahLanguage;
  final RxList<QuranAyaat> surahAyaahListTm = <QuranAyaat>[].obs;
  final RxList<QuranAyaat> surahAyaahListEn = <QuranAyaat>[].obs;
  final RxList<QuranAyaat> surahAyaahListAr = <QuranAyaat>[].obs;
  final List<String> surahClipboardAyaah =[];
  final RxList<String> surahClipboardAyaahId = <String>[].obs;
  RxBool isLoading = false.obs;
  bool isSearch = false;

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
      surahClipboardAyaahId.removeWhere((verseId) => verseId == chapterVerse.VerseId);
      return;
    }
    surahClipboardAyaah.add(chapterVerseContent);
    surahClipboardAyaahId.add(chapterVerse.VerseId);
  }

  void onLongPressCopyToClipboardList(QuranAyaat chapterVerse){
    surahClipboardAyaah.add(getContentForClipboard(chapterVerse));
    surahClipboardAyaahId.add(chapterVerse.VerseId);
  }

  void clearClipboardList(){
    surahClipboardAyaah.clear();
    surahClipboardAyaahId.clear();
  }

  QuranAyaat getSurahForShare(index){
    if(ayaahLanguage == 'Tamil'){
    return surahAyaahListTm[index];
    }else if(ayaahLanguage == 'English'){
      return surahAyaahListEn[index];
    }
    else{
    return  surahAyaahListAr[index];
    }
  }

  Future<void> copyContentToClipboard() async{
    await FlutterClipboard.copy(surahClipboardAyaah.join("\n\n"));
  }

  Future<void> getAyaah({int? chapterNum, String? language, String? searchText}) async {
    try{if (searchText != null && searchText.trim() != '') {
      if(!isSearch){isSearch = true;}
      Common.ayahSearch.searchAyaatSubstring = searchText.trim();
    } else if ((searchText == null || searchText.trim() == '') && isSearch) {
      isSearch = false;
      Common.ayahSearch.searchAyaatSubstring = '';
    } else if (searchText?.trim() == '' && !isSearch) {
      Common.ayahSearch.searchAyaatSubstring = '';
      return;
    }
    isLoading.value = true;
    if (chapterNum != null && language != null) {
      chapterId = chapterNum;
      ayaahLanguage = language;
    }
    var dbHelper = DbHelper();
    final quranAyaatList = await dbHelper.getSearchToNavigate(
        chapterId, ayaahLanguage, searchText);
    if(ayaahLanguage == 'Tamil'){
    // surahAyaahListTm.clear();
    surahAyaahListTm.value = quranAyaatList;
    surahAyaahListTm.refresh();
    }else if(ayaahLanguage == 'English'){
      // surahAyaahListEn.clear();
      surahAyaahListEn.value = quranAyaatList;
      surahAyaahListEn.refresh();
    }
    else if(ayaahLanguage == 'Arabic'){
      surahAyaahListAr.value = quranAyaatList;
      surahAyaahListAr.refresh();
    }}catch(e){
      rethrow;
    }
    finally{
    if (isLoading.value) {
      isLoading.value = false;
    }
    }
  }


  changeAyaahLanguage(chapterNum, verseNum, index, language,currentTab)async{
    QuranAyaat? ayaat = await DbHelper().getGotoSearchAyaat(chapterNum, verseNum, language == 'Tamil' ? 'English' : language == 'English' ? 'Arabic' : 'Tamil');
    if (ayaat == null) return;
    if(currentTab == CTab.tm){
      surahAyaahListTm[index] = ayaat;
    }
    else if(currentTab == CTab.en){
      surahAyaahListEn[index] = ayaat;
    }
    else{ 
        surahAyaahListAr[index] = ayaat;
    }
  }

  refreshList(){
    surahAyaahListAr.refresh();
    surahAyaahListEn.refresh();
    surahAyaahListTm.refresh();
  }
}
