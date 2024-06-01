import 'dart:core';

class FeedbacksModel {

  List<Content>  content;

  FeedbacksModel({
    required  this.content,
  });

  factory FeedbacksModel.fromJson(Map<String,dynamic> json){
    return FeedbacksModel(
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
  double ratings;
  dynamic sentBy;


  Content({
    required this.id,
    required this.createdAt,
    required this.deleted,
    required this.message,
    required this.ratings,
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
        ratings: json['ratings'] ?? 0.0,
        sentBy: json['userID'] ?? "",

    );
  }

}

// class BookedBy {
//   int id;
//   String firstName;
//   String lastName,
//   String username;
//   String phoneNumber;
//   String userRole;
//   String uuid;
//
//   BookedBy({
//     required this.id,
//     required this.uuid,
//     required this.firstName,
//     required this.lastName,
//     required this.username,
//     required this.phoneNumber,
//     required this.userRole
// });
//
// }