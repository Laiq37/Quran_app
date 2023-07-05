import 'package:get/get.dart';
import 'package:quran/home/base_strategy/search_strategy.dart';
import 'package:quran/home/controller/intro_appendix_detail_controller.dart';

class IntroAppendixDetailSearchStrategy extends SearchStrategy{
  
  const IntroAppendixDetailSearchStrategy();
  
  @override
  Future<void> search(String searchText) async{
    final IntroAppendixDetailSearchController _controller = Get.find<IntroAppendixDetailSearchController>();
    _controller.updateSearchText(searchText);
  }

}