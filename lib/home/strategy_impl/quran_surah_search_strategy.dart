import 'package:get/get.dart';
import 'package:quran/home/base_strategy/search_strategy.dart';
import 'package:quran/home/quran/controller/quran_surah_controller.dart';

class QuranSurahSearchStrategy extends SearchStrategy{

  const QuranSurahSearchStrategy();

  @override
  Future<void> search(String searchText)async {
    // TODO: implement search
    final QuranSurahController controller = Get.find<QuranSurahController>();
    try{await controller.getSurah(searchText);}catch(e){
      rethrow;
    }
  }
}