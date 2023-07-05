import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:quran/home/common.dart';
import 'package:quran/home/controller/search_strategy_controller.dart';
import 'package:quran/home/goto/controller/gotoSearch_controller.dart';
import 'package:quran/home/notes/controller/notes_controller.dart';
import 'package:quran/home/notes/screen/create_note_screen.dart';
import 'package:quran/home/notes/widgets/notes_widget.dart';
import 'package:quran/resources/colors_manager.dart';
import 'package:quran/resources/constants.dart';

class NotesPage extends StatefulWidget {
  const NotesPage({super.key});

  @override
  State<NotesPage> createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {

  late final SearchStrategyController _searchStrategyController;
  late final NotesController notesController;
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    notesController = Get.find<NotesController>();
    _searchStrategyController = SearchStrategyController();
    if(Get.find<GotoController>().isOnGoto.value)Future.delayed(Duration.zero,()=>Get.find<GotoController>().isOnGoto(false));
    Future.delayed(Duration.zero, ()=>Get.find<GotoController>().clearClipboardList());
    _searchStrategyController.setStrategy = Constants.notesSearchStrategy;
    Common.homeSearch.reset();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(alignment: AlignmentDirectional.bottomEnd, children: [
      const NotesWidget(),
      Positioned(
        bottom: AppSize.S_54.h,
        right: AppSize.S_8.w,
        child: Obx(() => InkWell(
            onTap: () => notesController.deleteList.isEmpty ? Navigator.push(context, MaterialPageRoute(builder: (context) => CreateNoteScreen(),)) : notesController.clearDeleteList(),
            child: Container(
              width: AppSize.S_70.r,
              height: AppSize.S_70.r,
              decoration: BoxDecoration(
                  boxShadow: [BoxShadow(
            color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
            spreadRadius: 4,
            blurRadius: 10,
            offset: const Offset(-6,4), // changes position of shadow
                ),],
                  color: Theme.of(context).colorScheme.primary,
                  shape: BoxShape.circle),
              child:  Icon(notesController.deleteList.isEmpty ? Icons.add : Icons.clear, color: ColorManager.white, size: AppSize.S_40.r,),
            ),
          ),
        ),
      )
    ]);
  }
}
