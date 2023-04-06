import 'package:app/model/payment_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebasePaymnet {
  static final _payment = FirebaseFirestore.instance.collection("payment");
  static Future<void> sendDataPayment(data) async {
    await _payment.add(data);
  }

  static Stream<List<PaymentModel>> getDataPayment(String id) {
    final snapShot = _payment.snapshots();
    return snapShot.map((event) {
      return event.docs
          .where((element) => element.data()["id_user"] == id)
          .map((e) => PaymentModel.fromMap(e.data()))
          .toList();
    });
  }

  static Stream<List<PaymentModel>> getRecentlyPayment() {
    final snapSnot = _payment.orderBy("date", descending: true).snapshots();
    return snapSnot.map((event) {
      return event.docs.map((e) => PaymentModel.fromMap(e.data())).toList();
    });
  }
}
