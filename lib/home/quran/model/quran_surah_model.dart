import 'package:flutter/foundation.dart';

class QuranSurahModel {
  final int chapterNum;
  final String name;
  final String englishName;
  final String tamilName;
  final int versesCount;

  const QuranSurahModel(
      {required this.chapterNum,
      required this.name,
      required this.englishName,
      required this.versesCount,
      required this.tamilName
});

  factory QuranSurahModel.fromJson(Map data) {
    return QuranSurahModel(
        chapterNum: data['number'],
        name: data['name'],
        englishName: data['englishName'],
        versesCount: data['numberOfAyahs'],
        tamilName: data['tamilName'],);
  }
}
