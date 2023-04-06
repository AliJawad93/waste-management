import 'package:app/model/driver_model.dart';
import 'package:app/model/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../main.dart';
import '../services/keysSharePref.dart';

class FirebaseUsers {
  static final _users = FirebaseFirestore.instance;

  static Future<dynamic> getDataUser([String? id]) async {
    var snapShot = await _users.collection('user').doc(id).get();
    Map<String, dynamic> data = snapShot.data() as Map<String, dynamic>;

    prefs.setString(KeysSharePref.name, data["name"]);
    prefs.setString(KeysSharePref.email, data["email"]);
    prefs.setString(KeysSharePref.urlImage, data["photoUrl"]);
    prefs.setString(KeysSharePref.birthDay, data["birthday"]);

    if (data["user_role"] == "driver") {
      prefs.setString(KeysSharePref.userRole, "driver");
      return DriverModel.fromMap(data);
    } else {
      if (data["user_role"] == "admin") {
        prefs.setString(KeysSharePref.userRole, "admin");
      } else {
        prefs.setString(KeysSharePref.idBin, data["id_bin"]);
        prefs.setBool(KeysSharePref.isSubscribe, data["is_subscribe"]);
        prefs.setString(KeysSharePref.userRole, "user");
      }
      return UserModel.fromMap(data);
    }
  }

  static Future<UserModel> getDataUserByIdBin(String? id) async {
    var snapShot = await _users.collection('user').get();
    final data =
        snapShot.docs.where((element) => element.data()["id_bin"] == id).first;
    return UserModel.fromMap(data.data());
  }

  static Future<void> updateSubscribeAndIdBin(bool isSubscribe) async {
    String pathUse = prefs.getString(KeysSharePref.uid)!;
    String idbin = prefs.getString(KeysSharePref.idBin)!;
    await _users
        .collection('user')
        .doc(pathUse)
        .update({"id_bin": idbin, "is_subscribe": isSubscribe});

    print("[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[$pathUse");
  }

  static Future<List<UserModel>> getDataUserSubscribed() async {
    var snapShot = await _users.collection('user').get();
    final usersModel = snapShot.docs
        .where((element) => element.data()["is_subscribe"] == true)
        .map((e) {
      return UserModel.fromMap(e.data());
    }).toList();
    return usersModel;
  }
}
