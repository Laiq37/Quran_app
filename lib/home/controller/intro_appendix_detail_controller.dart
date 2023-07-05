import 'package:get/get.dart';

class IntroAppendixDetailSearchController extends GetxController{

 final RxString findText = ''.obs;

  void updateSearchText(String searchText){
    findText.value = searchText;
  }

}