import 'dart:core';

class NotificationsModel {

  List<Content>  content;

  NotificationsModel({
    required  this.content,
  });

  factory NotificationsModel.fromJson(Map<String,dynamic> json){
    return NotificationsModel(
      content: List<Content>.from(json['content'].map((x) => Content.fromJson(x))),
    );
  }

}

class Content{
  int id;
  DateTime createdAt;
  bool deleted;
  String uuid;
  String message;
  String title;
  dynamic sentBy;


  Content({
    required this.id,
    required this.createdAt,
    required this.deleted,
    required this.message,
    required this.title,
    required this.sentBy,
    required this.uuid
  });

  factory Content.fromJson(Map<String,dynamic> json) {
    return Content(
      id: json['id'] ??  0 ,
      createdAt: DateTime.parse(json['createdAt']) ?? DateTime(2024),
      deleted: json['deleted'] ?? false,
      uuid: json['uuid'] ?? "",
      message: json['message'] ?? "",
      title: json['tittle'] ?? "",
      sentBy: json['generatedBy'] ?? "",

    );
  }

}
