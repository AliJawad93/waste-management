import 'package:app/data/firebase_driver.dart';
import 'package:app/data/firebase_map.dart';
import 'package:app/data/firebase_users.dart';
import 'package:app/model/driver_model.dart';
import 'package:app/model/user_model.dart';
import 'package:app/services/keysSharePref.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

import '../main.dart';
import '../model/activities_model.dart';

class FirebaseActivities {
  static final _activities = FirebaseFirestore.instance;

  static Future<void> sent(Map<String, dynamic> map) async {
    final snap = await _activities.collection("activities").add(map);
  }

  static Future<List<Future<ActivitiesDriverModel>>> getActivitiesDrivers(
      String idDriver) async {
    //String idDriver = "VcwG3IPD2s3yPi7Z9AFD";
    final snap = await _activities.collection("activities").get();
    final driverDocesbin =
        snap.docs.where((element) => element.data()["id_driver"] == idDriver);

    final activitiesModelsDriver = driverDocesbin.map((e) async {
      UserModel userModel =
          await FirebaseUsers.getDataUser(e.data()["id_user"]);

      return ActivitiesDriverModel(
          userModel: userModel,
          date: e.data()["date"],
          isUserPay: e.data()["is_user_pay"],
          typePay: e.data()["type_pay"]);
    }).toList();

    return activitiesModelsDriver;
  }

  static Future<List<Future<ActivitiesUserModel>>> getActivitiesUser(
      String idUser) async {
    //String idDriver = "VcwG3IPD2s3yPi7Z9AFD";
    final snap = await _activities.collection("activities").get();
    final driverDocesbin =
        snap.docs.where((element) => element.data()["id_user"] == idUser);

    final activitiesUserModel = driverDocesbin.map((e) async {
      DriverModel driverModel =
          await FirebaseDriver.getDriver(e.data()["id_driver"]);

      return ActivitiesUserModel(
          driverModel: driverModel,
          date: e.data()["date"],
          isUserPay: e.data()["is_user_pay"],
          typePay: e.data()["type_pay"]);
    }).toList();

    return activitiesUserModel;
  }

  static Stream<List<ActivitiesModel>> getActivities(
    String id,
    bool isDriver,
  ) {
    final snapSnot = _activities
        .collection("activities")
        .orderBy("date", descending: true)
        .snapshots();
    return snapSnot.map((event) {
      return event.docs
          .where((element) =>
              isDriver ? element["id_driver"] == id : element["id_user"] == id)
          .map((e) => ActivitiesModel.fromMap(e.data()))
          .toList();
    });
  }

  static Stream<List<ActivitiesModel>> getRecentlyActivities() {
    final snapSnot = _activities
        .collection("activities")
        .orderBy("date", descending: true)
        .snapshots();
    return snapSnot.map((event) {
      return event.docs.map((e) => ActivitiesModel.fromMap(e.data())).toList();
    });
  }

  static Future<void> sendInfoToActivites() async {
    String idBin = prefs.getString(KeysSharePref.idBin)!;
    String date = DateFormat("yyyy-MM-dd").format(DateTime.now());
    String location = await FirebaseMap.getLocationBin(idBin);
    final user = await FirebaseUsers.getDataUserByIdBin(idBin);

    final data = {
      "id_user": user.id,
      "id_driver": prefs.getString(KeysSharePref.uid),
      "name_driver": prefs.getString(KeysSharePref.name),
      "name_user": user.name,
      "location": location,
      "url_image_driver": prefs.getString(KeysSharePref.urlImage),
      "url_image_user": user.urlImage,
      "is_pay": false,
      "date": date
    };
    FirebaseActivities.sent(data);
  }
}
