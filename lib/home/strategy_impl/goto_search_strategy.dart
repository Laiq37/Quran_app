import 'package:get/get.dart';
import 'package:quran/home/base_strategy/search_strategy.dart';
import 'package:quran/home/goto/controller/gotoSearch_controller.dart';

class GotoSearchStrategy extends SearchStrategy{
  
  const GotoSearchStrategy();
  
  @override
  Future<void> search(String searchText)async {
    // TODO: implement search
    final GotoController controller = Get.find<GotoController>();
    try{
      await controller.getSearchAyaah(searchText);}catch(e){
      rethrow;
    }
  }
  
}