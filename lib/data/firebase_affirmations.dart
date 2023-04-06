import 'package:app/controller/qr_scanner_controller.dart';
import 'package:app/model/confirmation_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class FirebaseAffirmation {
  static final _affirmation = FirebaseFirestore.instance;

  static Stream<ConfirmationModel> getConfirmation() {
    final snapShot =
        _affirmation.collection("affirmations").doc("1").snapshots();

    return snapShot.map((e) {
      return ConfirmationModel(
          requestCode: e.data()!["request_code"],
          confirmCode: e.data()!["confirm_code"],
          date: e.data()!["date"]);
    });
  }

  static Future<void> sendRequestCode(String code) async {
    final snapShot = await _affirmation
        .collection("affirmations")
        .doc("1")
        .update({"request_code": code});
  }

  static Future<void> sendConfirmCode(String code, String? status) async {
    final snapShot = await _affirmation
        .collection("affirmations")
        .doc("1")
        .update({"confirm_code": code, "status": status});
  }

  static Stream<DocumentSnapshot<Map<String, dynamic>>> getConfirmCode() {
    final snapShot =
        _affirmation.collection("affirmations").doc("1").snapshots();
    return snapShot;
  }
}
