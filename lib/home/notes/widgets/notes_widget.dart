import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:quran/home/controller/search_strategy_controller.dart';
import 'package:quran/home/notes/controller/notes_controller.dart';
import 'package:quran/home/notes/widgets/note_tile_widget.dart';
import 'package:quran/resources/constants.dart';

class NotesWidget extends StatefulWidget {
  const NotesWidget({super.key});

  @override
  State<NotesWidget> createState() => _NotesWidgetState();
}

class _NotesWidgetState extends State<NotesWidget> {
    late final SearchStrategyController _searchStrategyController;
    late final NotesController notesController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    notesController = Get.find<NotesController>();
    _searchStrategyController = SearchStrategyController();
    _searchStrategyController.setStrategy = Constants.notesSearchStrategy;
     SchedulerBinding.instance.addPostFrameCallback((_) {
    notesController.getNotes();
         });
  }

  @override
  Widget build(BuildContext context) {
    // final List<Map<String, dynamic>> notes = [
    //   {
    //     'title': 'Note 1',
    //     'description': 'when an unknown printer took...',
    //     'image' : 'assets/images/test_note.jpg',
    //     'date': '14/9/2022'
    //   },
    //   {
    //     'title': 'Note 2',
    //     'description': 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry`s standard dummy text ever since the 1500s',
    //     'date': '14/9/2022'
    //   },
    //   {
    //     'title': 'Note 3',
    //     'description': 'when an unknown printer took...',
    //     'image' : 'assets/images/test_note.jpg',
    //     'date': '14/9/2022'
    //   },
    //   {
    //     'title': 'Note 4',
    //     'description': 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry`s standard dummy text ever since the 1500s',
    //     'date': '14/9/2022'
    //   },
    //   {
    //     'title': 'Note 5',
    //     'description': 'when an unknown printer took...',
    //     'date': '14/9/2022'
    //   },
    //   {
    //     'title': 'Note 6',
    //     'description': 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry`s standard dummy text ever since the 1500s',
    //     'image' : 'assets/images/test_note.jpg',
    //     'date': '14/9/2022'
    //   },
    //   {
    //     'title': 'Note 7',
    //     'description': 'when an unknown printer took...',
    //     'date': '14/9/2022'
    //   },
    //   {
    //     'title': 'Note 8',
    //     'description': 'when an unknown printer took...',
    //     'image' : 'assets/images/test_note.jpg',
    //     'date': '14/9/2022'
    //   },
    //   {
    //     'title': 'Note 9',
    //     'description': 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry`s standard dummy text ever since the 1500s',
    //     'image' : 'assets/images/test_note.jpg',
    //     'date': '14/9/2022'
    //   },
    // ];
    return Obx( () => notesController.isLoading.value ? const Center(child: CircularProgressIndicator.adaptive()) : ListView.builder(
        padding: EdgeInsets.only(left: AppSize.S_26.w, right: AppSize.S_26.w),
        itemBuilder: (context, index) {
          return NoteTileWidget(note: notesController.notesList[index]);
        },
        itemCount: notesController.notesList.length,
      ),
    );
  }
}