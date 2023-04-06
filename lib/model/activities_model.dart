import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:app/model/driver_model.dart';
import 'package:app/model/user_model.dart';

class ActivitiesDriverModel {
  String date;
  bool isUserPay;
  String typePay;
  UserModel userModel;

  ActivitiesDriverModel({
    required this.date,
    required this.isUserPay,
    required this.typePay,
    required this.userModel,
  });
}

class ActivitiesUserModel {
  String date;
  DriverModel driverModel;
  bool isUserPay;
  String typePay;
  ActivitiesUserModel({
    required this.date,
    required this.driverModel,
    required this.isUserPay,
    required this.typePay,
  });
}

class ActivitiesModel {
  String nameDriver;
  String nameUser;
  String location;
  String date;
  String urlImageDriver;
  String urlImageUser;
  ActivitiesModel({
    required this.nameDriver,
    required this.nameUser,
    required this.location,
    required this.date,
    required this.urlImageDriver,
    required this.urlImageUser,
  });

  Map<String, dynamic> toMap() {
    return {
      'name_driver': nameDriver,
      'name_user': nameUser,
      'location': location,
      'date': date,
      'url_image_driver': urlImageDriver,
      'url_image_user': urlImageUser,
    };
  }

  factory ActivitiesModel.fromMap(Map<String, dynamic> map) {
    return ActivitiesModel(
      nameDriver: map['name_driver'] ?? '',
      nameUser: map['name_user'] ?? '',
      location: map['location'] ?? '',
      date: map['date'] ?? '',
      urlImageDriver: map['url_image_driver'] ?? '',
      urlImageUser: map['url_image_user'] ?? '',
    );
  }
}
