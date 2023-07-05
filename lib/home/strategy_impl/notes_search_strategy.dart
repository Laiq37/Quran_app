import 'package:get/get.dart';
import 'package:quran/home/base_strategy/search_strategy.dart';
import 'package:quran/home/notes/controller/notes_controller.dart';

class NotesSearchStrategy extends SearchStrategy{

  const NotesSearchStrategy();

  @override
  Future<void> search(String searchText) async{
    // TODO: implement search
    final NotesController controller = Get.find<NotesController>();
    try{await controller.getNotes(searchText);}catch(e){
      rethrow;
    }
  }



}