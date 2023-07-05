import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:quran/home/controller/search_strategy_controller.dart';

class SearchController{

  final Rx<TextEditingController> textController = TextEditingController().obs;
  String searchAyaatSubstring = '';
  RxBool isCancelVisible = false.obs;

  Future<void> search()async{
    // if((textController.value.text.isEmpty || textController.value.text == '') && isCancelVisible.value){
    //   isCancelVisible.value = false;
    // }
    try{await SearchStrategyController().executeSearch(textController.value.text.trim());}catch(e){
      rethrow;
    }
    // textController.value.clear();
  }

  void reset(){
    Future.delayed(Duration.zero, (){
    if(isCancelVisible.value)isCancelVisible.value = false;
    if(textController.value.text.isNotEmpty)Future.delayed(Duration.zero,()=>textController.value.clear());
    Get.focusScope?.unfocus();
    });
  }

  // @override
  void dispose(){
    textController.value.dispose();
    // super.dispose();
  }
}