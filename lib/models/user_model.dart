import 'dart:core';

class UserModel {

  User user;

  UserModel({
    required  this.user,
  });

  factory UserModel.fromJson(Map<String,dynamic> json){
    return UserModel(user: User.fromJson(json['data']));
  }

}

class User{
  int id;
  DateTime createdAt;
  bool deleted;
  String uuid;
  String firstName;
  String lastName;
  String username;
  String phoneNumber;
  bool active;
  String middleName;

  User({
    required this.id,
    required this.createdAt,
    required this.deleted,
    required this.firstName,
    required this.lastName,
    required this.username,
    required this.phoneNumber,
    required this.active,
    required this.middleName,
    required this.uuid
  });

  factory User.fromJson(Map<String,dynamic> json) {
    return User(
        id: json['id'] ??  0 ,
        createdAt: DateTime.parse(json['createdAt']) ?? DateTime(2024),
        deleted: json['deleted'] ?? false,
        uuid: json['uuid'] ?? "",
        firstName: json['firstName'] ?? "",
        lastName: json['lastName'] ?? "0",
        username: json['username'] ?? "",
        phoneNumber: json['phone'] ?? "",
        middleName: json['middleName'] ?? "",
        active: json['active'] ?? "",

    );
  }

}
