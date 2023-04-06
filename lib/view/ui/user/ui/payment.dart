import 'package:app/data/Firebase_payment.dart';
import 'package:app/main.dart';

import 'package:app/model/payment_model.dart';
import 'package:app/services/keysSharePref.dart';

import 'package:flutter/material.dart';

import '../widgets/custom_card_payment.dart';

class HistoryPaymentUser extends StatelessWidget {
  HistoryPaymentUser({required this.idUser, super.key});
  String? idUser;
  Widget build(BuildContext context) {
    return StreamBuilder<List<PaymentModel>>(
      stream:
          FirebasePaymnet.getDataPayment(prefs.getString(KeysSharePref.uid)!),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) => CustomCardPayment(
                  paymentModel: snapshot.data![index],
                ));
      },
    );
  }
}
