import 'package:flutter/material.dart';

import '../../../../data/Firebase_payment.dart';
import '../../../../model/payment_model.dart';
import '../../../widgets/card.dart';
import '../../user/widgets/custom_card_payment.dart';

class RecentlyPayment extends StatelessWidget {
  const RecentlyPayment({super.key});

  Widget build(BuildContext context) {
    return StreamBuilder<List<PaymentModel>>(
      stream: FirebasePaymnet.getRecentlyPayment(),
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
