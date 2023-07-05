
// import 'package:flutter/material.dart';
// import 'package:quran/data/dbhelper.dart';
// import 'package:quran/data/dbmodel.dart';

// class UrduQuran extends StatefulWidget {
//   int? checkIndex;
//   UrduQuran({super.key, this.checkIndex});

//   @override
//   State<UrduQuran> createState() => _UrduQuranState();
// }

// class _UrduQuranState extends State<UrduQuran> {
//   List<QuranAyaat> quran_ayaat_list = [];
//   @override
//   void initState() {
//     super.initState();
//     getData();
//   }

//   void getData() async {
//     var dbHelper = DbHelper();
//     List<QuranAyaat> _quran_ayaats = await dbHelper.getSearchToNavigate(widget.checkIndex, "English");
//     setState(() {
//       quran_ayaat_list = _quran_ayaats;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return ListView.separated(
//         separatorBuilder: (context, index) =>
//             const Divider(height: 0.5, color: Colors.black38),
//         physics:const ClampingScrollPhysics(),
//         shrinkWrap: true,
//         itemCount: quran_ayaat_list == null ? 0 : quran_ayaat_list.length,
//         itemBuilder: (context, index) {
//           return Container(
//             padding:const EdgeInsets.all(15),
//             child: Text(
//               '${quran_ayaat_list[index].Dialogues} ${quran_ayaat_list[index].DialogueTitle}',
//             ),
//           );
//         });
//   }
// }