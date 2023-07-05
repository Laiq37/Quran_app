import 'package:get/get.dart';
import 'package:quran/data/dbhelper.dart';
import 'package:quran/home/appendix/controller/appendix_controller.dart';
import 'package:quran/home/controller/intro_appendix_detail_controller.dart';
import 'package:quran/home/controller/search_controller.dart';
import 'package:quran/home/goto/controller/gotoSearch_controller.dart';
import 'package:quran/home/notes/controller/notes_controller.dart';
import 'package:quran/home/quran/controller/quran_surah_controller.dart';
import 'package:quran/quran_chapter_detail/controller/surah_ayaah_controller.dart';
import 'package:quran/resources/app_open_first_time.dart';
import 'package:quran/resources/constants.dart';

class InitResources{

  static void initResources(){
    AppOpen().setIsAppOpenFirstTime();
    AppSession.getAppSession();
    DbHelper().initDb();
    Get.lazyPut(() => IntroAppendixDetailSearchController());
    Get.lazyPut(() => AppendixController());
    Get.lazyPut(() => GotoController());
    Get.lazyPut(() => NotesController());
    Get.lazyPut(() => QuranSurahController());
    Get.lazyPut(() => SurahAyaahController());
    // Get.create(() => SearchController());
  }

  static void disposeResources()async{
    DbHelper().closeDb();
    // var prefs = await SharedPreferences.getInstance();
    Get.find<IntroAppendixDetailSearchController>().dispose;
    Get.find<AppendixController>().dispose;
    Get.find<GotoController>().dispose;
    Get.find<NotesController>().dispose;
    Get.find<QuranSurahController>().dispose;
    Get.find<SurahAyaahController>().dispose;
    Get.deleteAll();
  }

}