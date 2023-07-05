import 'package:get/get.dart';
import 'package:quran/home/appendix/controller/appendix_controller.dart';
import 'package:quran/home/base_strategy/search_strategy.dart';

class AppendixSearchStrategy extends SearchStrategy{

  const AppendixSearchStrategy();

  @override
  Future<void> search(String searchText)async {
    final AppendixController controller = Get.find<AppendixController>();
    try{await controller.get(searchText);}catch(e){
      rethrow;
    }
  }



}