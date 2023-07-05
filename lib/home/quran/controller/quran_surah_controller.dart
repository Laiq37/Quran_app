import 'package:get/get.dart';
import 'package:quran/home/quran/model/quran_surah_model.dart';
import 'package:quran/resources/constants.dart';

class QuranSurahController extends GetxController {
  final RxList quranSurahList = <QuranSurahModel>[].obs;
  bool isSearch = false;

  Future<void> getSurah([String? searchText]) async{
   try{ if (searchText != null && searchText.trim() != '' && !isSearch) {
      isSearch = true;
    } else if ((searchText == null || searchText.trim() == '') && isSearch) {
      isSearch = false;
    } else if (searchText?.trim() == '' && !isSearch) {
      return;
    }
    quranSurahList.clear();
    List<QuranSurahModel> surahList = [
      ...QuranData.quranSurahList
          .map((surah) => QuranSurahModel.fromJson(surah))
    ];
    if (searchText != null) {
      surahList = [
        ...surahList.where((surah) =>
            surah.name.toLowerCase().contains(searchText.toLowerCase()) ||
            surah.englishName.toLowerCase().contains(searchText.toLowerCase()))
      ];
      if(surahList.isEmpty)throw 'Not Found';
    }
    quranSurahList.addAll(surahList);}catch(e){
      throw e == 'Not Found' ? 'No match found!' : 'Something went wrong!';
    }
  }
}
