import 'package:get/get.dart';
import 'package:quran/home/base_strategy/search_strategy.dart';
import 'package:quran/quran_chapter_detail/controller/surah_ayaah_controller.dart';

class SurahAyaahSearchStrategy extends SearchStrategy{

  const SurahAyaahSearchStrategy();

  @override
  Future<void> search(String searchText)async {
    // TODO: implement search
    final SurahAyaahController _surahAyaahController = Get.find<SurahAyaahController>();
    try{await _surahAyaahController.getAyaah(searchText: searchText);}catch(e){
      rethrow;
    }
  }

  

}