import 'dart:convert';

class PaymentModel {
  String mount;
  String date;
  String nameUser;
  String urlImage;
  String idUser;
  PaymentModel({
    required this.mount,
    required this.date,
    required this.nameUser,
    required this.urlImage,
    required this.idUser,
  });

  Map<String, dynamic> toMap() {
    return {
      'mount': mount,
      'date': date,
      'name_user': nameUser,
      'url_image': urlImage,
      'id_user': idUser,
    };
  }

  factory PaymentModel.fromMap(Map<String, dynamic> map) {
    return PaymentModel(
      mount: map['mount'] ?? '',
      date: map['date'] ?? '',
      idUser: map['id_user'] ?? '',
      nameUser: map['name_user'] ?? '',
      urlImage: map['url_image'] ?? '',
    );
  }
}
