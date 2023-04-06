import 'dart:math';

import 'package:app/controller/google_map_controller.dart';
import 'package:app/controller/main_page_controller.dart';
import 'package:app/core/utils/app_string.dart';
import 'package:app/helper/icon_map_helper.dart';
import 'package:app/main.dart';
import 'package:app/model/user_model.dart';
import 'package:app/services/keysSharePref.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';
import 'package:flutter/services.dart';

class FirebaseMap {
  static final CollectionReference _locations =
      FirebaseFirestore.instance.collection('locations');
  static final MainPageController mainPageController = Get.find();

  static final MapController _myGoogleMapController = Get.find();
  static late List<Uint8List> icons;

// post data functions
  static sendPaymnetDate(String idDoc) {
    _locations.doc(idDoc).update({"payment_date": DateTime.now().toString()});
  }

  static sendInfoBin(String idDoc, double lat, double long) {
    _locations
        .doc(idDoc)
        .update({"latitude": lat.toString(), "longitude": long.toString()});
  }

  static addDriverLocation(String id) {
    Map<String, dynamic> dataDriver = {
      "id": id,
      "latitude": "33.314269",
      "longitude": "44.466785",
      "heading": 0.2,
      "type": AppString.car
    };
    _locations.doc(id).set(dataDriver);
  }

  static updateLocation(double latitude, double longitude, double heading) {
    Map<String, dynamic> dataDriver = {
      "latitude": latitude.toString(),
      "longitude": longitude.toString(),
      "heading": heading,
    };
    _locations.doc(prefs.getString(KeysSharePref.uid)!).update(dataDriver);

    // else {
    //   Map<String, dynamic> dataUser = {
    //     "id": prefs.getString(KeysSharePref.uid),
    //     "location": GeoPoint(latitude, longitude),
    //     "heading": 0,
    //     "level": 0,
    //     "type": AppString.trash
    //   };
    //   _locations.doc(idBin!).set(dataUser);
    // }
  }

// get data functions
  static Stream<Set<Marker>> getMarkersMap() async* {
    icons = await IconMapHelper.getIconsMarker();
    Stream<QuerySnapshot<Object?>> snapShot = _locations.snapshots();
    yield* _getMarkers(snapShot);
  }

  static Stream<Set<Marker>> _getMarkers(
      Stream<QuerySnapshot<Object?>> snapShot) {
    String userRole = prefs.getString(KeysSharePref.userRole)!;
    return snapShot.map((snapshot) {
      return snapshot.docs.where((element) {
        var data = element.data() as Map<String, dynamic>;
        print('the trash : ${data["type"] == "trash"}');
        /*
        if (data["type"] == "trash" &&
            data["id"] == prefs.getString(KeysSharePref.idBin)) {
          return checkValidPaymentDate(data["payment_date"].toString());
        }else if
        
        */
        if (data["type"] == "trash" && userRole == "user") {
          if (data["id"] == prefs.getString(KeysSharePref.idBin)) {
            return checkValidPaymentDate(data["payment_date"].toString());
          }
          return false;
        } else if (data["type"] == "trash" &&
            (userRole == "admin" || userRole == "driver")) {
          return checkValidPaymentDate(data["payment_date"].toString());
        } else if (data["type"] == AppString.car) {
          return true;
        } else {
          return false;
        }
      }).map((e) {
        var data = e.data() as Map<String, dynamic>;
        return _getInitMarker(data);
      }).toSet();
    });
  }

  static Marker _getInitMarker(Map<String, dynamic> data) {
    bool isTruck;
    int level;
    double heading;

    if (data["type"] == "car") {
      isTruck = true;
      level = -1;
      heading = data["heading"];
    } else {
      isTruck = false;
      level = data["level"];
      heading = 0;
    }

    Marker marker = Marker(
      rotation: heading,
      markerId: MarkerId("${data["id"]}"),
      position: LatLng(
          double.parse(data["latitude"]), double.parse(data["longitude"])),
      infoWindow: data["type"] == "car"
          ? InfoWindow(title: data["type"])
          : InfoWindow(title: "the level is ${data["level"]}"),
      icon: IconMapHelper.getIcon(icons, isTruck, level),
    );

    return marker;
  }

  static Future<String> getLocationBin(String id) async {
    final data = await _locations.doc(id).get();
    return "( ${data["latitude"]} , ${data["longitude"]} )";
  }

  static bool checkValidPaymentDate(String subscribDate) {
    if (subscribDate.isEmpty) return false;
    var subDate = DateTime.tryParse(subscribDate);
    var dataNow = DateTime.now();
    var exp = DateTime(subDate!.year, subDate.month + 1, subDate.day,
        subDate.hour, subDate.minute, subDate.second);
    return dataNow.isBefore(exp);
  }
}
