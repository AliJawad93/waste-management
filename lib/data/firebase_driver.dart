import 'package:app/data/firebase_post.dart';
import 'package:app/model/driver_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseDriver {
  static final _dirvers = FirebaseFirestore.instance;

  static Future<void> addDriver(DriverModel driverModel) async {
    await _dirvers
        .collection("user")
        .doc(driverModel.id)
        .set(driverModel.toMap());
  }

  static Future<List<DriverModel>> getDataDrivers() async {
    var snapShot = await _dirvers.collection('user').get();
    return snapShot.docs
        .where((element) => element["user_role"] == "driver")
        .map((e) {
      return DriverModel.fromMap(e.data());
    }).toList();
  }

  static Future<String?> uploadWithGetURL(pickerImage) async {
    return await FirebasePost.uploadWithGetURL(pickerImage);
  }

  static Future<DriverModel> getDriver(String id) async {
    final snapShot = await _dirvers.collection('user').doc(id).get();
    return DriverModel.fromMap(snapShot.data()!);
  }
}
