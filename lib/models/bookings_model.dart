import 'dart:core';

import 'package:flutter/material.dart';
import 'dart:convert';

class BookingModel {

  List<Content>  content;

  BookingModel({
    required  this.content,
});

  factory BookingModel.fromJson(Map<String,dynamic> json){
    return BookingModel(
      content: List<Content>.from(json['content'].map((x) => Content.fromJson(x))),
    );
  }

}

class Content{
  int id;
  DateTime createdAt;
  bool deleted;
  String uuid;
  String serviceName;
  String servicePhoto;
  String servicePrice;
  String latitude;
  String longtude;
  String bookedBy;
  String pickupDate;
  String status;
  String wasteType;

  Content({
    required this.id,
    required this.createdAt,
    required this.deleted,
    required this.serviceName,
    required this.servicePhoto,
    required this.servicePrice,
    required this.latitude,
    required this.longtude,
    required this.bookedBy,
    required this.pickupDate,
    required this.status,
    required this.wasteType,
    required this.uuid
});

  factory Content.fromJson(Map<String,dynamic> json) {
    return Content(
      id: json['id'] ??  0 ,
      createdAt: DateTime.parse(json['createdAt']) ?? DateTime(2024),
      deleted: json['deleted'] ?? false,
      uuid: json['uuid'] ?? "",
      serviceName: json['serviceName'] ?? "",
      servicePrice: json['servicePrice'] ?? "0",
      latitude:  json['latitude'] ?? "",
      longtude:  json['longtude'] ?? "",
      servicePhoto: json['servicePhoto'] ?? "",
      status: json['status'] ?? "",
      bookedBy: json['registeredBy'] ?? "",
      pickupDate: json['pickupDate'] ?? "",
      wasteType: json['wasteType'] ?? ""
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