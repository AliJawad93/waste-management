import 'package:cloud_firestore/cloud_firestore.dart';

class PostModel {
  String type;
  String text;
  String date;
  String urlImage;

  PostModel({
    required this.type,
    required this.text,
    required this.date,
    required this.urlImage,
  });

  factory PostModel.fromMap(Map<String, dynamic> map) {
    return PostModel(
        type: map["type"],
        text: map["text"],
        urlImage: map["url_image"],
        date: map["date"]);
  }

  Map<String, dynamic> toMap() {
    return {
      "type": type,
      "text": text,
      "date": date,
      "url_image": urlImage,
    };
  }
}
