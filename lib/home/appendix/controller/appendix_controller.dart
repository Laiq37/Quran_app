import 'package:get/get.dart';
import 'package:quran/resources/constants.dart';

class AppendixController extends GetxController {
  final RxList<Map<String, String>> appendixList = <Map<String, String>>[].obs;

  Future<void> get([String? searchText]) async{
    appendixList.clear();
    final List<Map<String, String>> languageAppendixList =
        Get.locale!.languageCode == 'en'
            ? Constants.englishAppendixList
            : Constants.appendixList;
    try{if(searchText == null || searchText.trim() == ''){
    appendixList.addAll( languageAppendixList);
    }else{
      appendixList.addAll( 
         languageAppendixList.where((appendix) => appendix['name']!
            .toLowerCase()
            .contains(searchText.toLowerCase())));
      if(appendixList.isEmpty)throw 'Not Found';
    }
  }catch(e){
    throw e == 'Not Found' ? 'No match Found' : 'Something went wrong!';
  }
  }
}
