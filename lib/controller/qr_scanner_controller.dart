import 'dart:async';

import 'package:app/core/constants/App_colors.dart';
import 'package:app/main.dart';
import 'package:app/services/keysSharePref.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import 'package:app/data/firebase_driver.dart';
import 'package:app/data/firebase_map.dart';
import 'package:app/data/firebase_users.dart';

import '../data/firebase_activities.dart';
import 'google_map_controller.dart';

class QrScannerControllerDriver extends GetxController {
  Barcode? idBin;

  QRViewController? controller;
  String confirmCode = "";
  bool isFirst = true;
  QrScannerControllerDriver();

  void onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.resumeCamera();

    controller.scannedDataStream.listen((scanData) async {
      if (isFirst) {
        idBin = scanData;

        prefs.setString(KeysSharePref.idBin, idBin!.code!);

        isFirst = false;

        update();
        await Future.delayed(Duration(seconds: 1));
        Get.back();
      }
    });
  }

  Barcode? get getResult => idBin;

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}

/*

 String currentIdDriver = "VcwG3IPD2s3yPi7Z9AFD";
            FirebaseActivities.sent({
              "date": "2021-212",
              "id_driver": currentIdDriver,
              "id_user": result!.code,
              "is_user_pay": true,
              "type_pay": "Visa Card",
            });

 */
