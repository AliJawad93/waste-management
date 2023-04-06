import 'package:app/model/info_card_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseInfoCard {
  static final _infoCardCollection =
      FirebaseFirestore.instance.collection("card_information");

  static Future<void> sendInfoCard(InfoCardModel infoCard) async {
    String idUser = "1";
    await _infoCardCollection.doc(idUser).set(infoCard.toMap());
  }

  static Future<InfoCardModel> getInfoCard(String idUser) async {
    String idUser = "1";
    final data = await _infoCardCollection.doc(idUser).get();
    return InfoCardModel.fromMap(data.data() as Map<String, dynamic>);
  }
}
