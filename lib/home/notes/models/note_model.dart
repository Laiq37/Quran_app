import 'dart:convert';

class Note{

  final String id;
  final String title;
  final String descriptionText;
  final List descriptionContentList;
  final String htmlDescription;
  final String createdAt;

  const Note({
    required this.id, required this.title, required this.descriptionText, required this.descriptionContentList, required this.htmlDescription, required this.createdAt 
  });

  factory Note.fromJson(Map<String, dynamic> note){
    return Note(id: note['id'], title: note['title'], descriptionText: note['descriptionText'], descriptionContentList: jsonDecode(note['descriptionContentList']), htmlDescription: note['htmlDescription'],  createdAt: note['createdAt']);
  }

}