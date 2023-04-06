import 'package:app/core/utils/app_string.dart';
import 'package:app/data/firebase_users.dart';
import 'package:app/model/user_model.dart';
import 'package:app/view/ui/admin/widgets/custom_card_user_subscribed.dart';
import 'package:app/view/ui/user/ui/payment.dart';
import 'package:app/view/widgets/custom_scafold.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UsersPaymnetAnalysisAdmin extends StatelessWidget {
  const UsersPaymnetAnalysisAdmin({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<UserModel>>(
        future: FirebaseUsers.getDataUserSubscribed(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    Get.to(() => CustomScaffold(
                          appBar: AppBar(
                            title: Text(AppString.historyPayment.tr),
                          ),
                          body: HistoryPaymentUser(
                            idUser: snapshot.data![index].id.toString(),
                          ),
                        ));
                  },
                  child: CusromCardUserSubScribed(
                      userModel: snapshot.data![index]),
                );
              });
        });
  }
}
