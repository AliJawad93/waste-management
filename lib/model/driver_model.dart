import 'dart:convert';

import 'package:app/model/user_model.dart';

class DriverModel {
  String id;
  String name;
  String workDays;
  String workStreet;
  String urlImage;
  int numberTruck;
  String email;
  String birthday;
  String status;
  String userRole;
  String creationTime;
  String lastSignInTime;
  String updatedTime;
  List<ChatUser>? chats;
  DriverModel({
    required this.id,
    required this.name,
    required this.workDays,
    required this.workStreet,
    required this.urlImage,
    required this.numberTruck,
    required this.email,
    required this.birthday,
    required this.status,
    required this.userRole,
    required this.creationTime,
    required this.lastSignInTime,
    required this.updatedTime,
    this.chats,
  });

  Map<String, dynamic> toMap() {
    return {
      'uid': id,
      'name': name,
      'work_days': workDays,
      'work_street': workStreet,
      'photoUrl': urlImage,
      'number_truck': numberTruck,
      'email': email,
      'birthday': birthday,
      'status': status,
      'user_role': userRole,
      'creationTime': creationTime,
      'lastSignInTime': lastSignInTime,
      'updatedTime': updatedTime,
    };
  }

  factory DriverModel.fromMap(Map<String, dynamic> map) {
    return DriverModel(
      id: map['uid'] ?? '',
      name: map['name'] ?? '',
      workDays: map['work_days'] ?? '',
      workStreet: map['work_street'] ?? '',
      urlImage: map['photoUrl'] ?? '',
      numberTruck: map['number_truck']?.toInt() ?? 0,
      email: map['email'] ?? '',
      birthday: map['birthday'] ?? '',
      status: map['status'] ?? '',
      userRole: map['user_role'] ?? '',
      creationTime: map['creationTime'] ?? '',
      lastSignInTime: map['lastSignInTime'] ?? '',
      updatedTime: map['updatedTime'] ?? '',
    );
  }
}
