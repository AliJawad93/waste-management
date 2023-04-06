import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

import 'package:app/core/utils/app_string.dart';
import 'package:app/main.dart';
import 'package:app/services/keysSharePref.dart';
import 'package:app/view/ui/user/ui/qr_code.dart';
import 'package:app/view/widgets/custom_elevated_button.dart';
import 'package:app/view/widgets/custom_scafold.dart';

import '../../../../controller/main_page_controller.dart';
import '../../../../controller/payment_controller.dart';
import '../../../../core/constants/App_colors.dart';

class MakeSubscribe extends StatelessWidget {
  MakeSubscribe({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: AppBar(
        title: Text(AppString.makeSubscribe.tr),
      ),
      body: GetBuilder<PaymentController>(
          init: PaymentController(),
          builder: (paymentController) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: Get.width * 0.2),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(AppString.step1Tosubscribe.tr),
                  CusotmMakeSubscribeCard(
                      massage:
                          "Latitude: ${paymentController.getPostion?.latitude ?? ""}",
                      isNull: paymentController.getPostion?.latitude == null),
                  SizedBox(
                    height: 10,
                  ),
                  CusotmMakeSubscribeCard(
                      massage:
                          "longitude: ${paymentController.getPostion?.longitude ?? ""}",
                      isNull: paymentController.getPostion?.longitude == null),
                  SizedBox(
                    height: 10,
                  ),
                  CustomElevatedButton(
                      title: "Enable Location",
                      onPressed: () async {
                        await paymentController.enableLoaction();
                        paymentController.update();
                      }),
                  Text(AppString.step2Tosubscribe.tr),
                  CusotmMakeSubscribeCard(
                      massage:
                          "${AppString.idBin.tr} : ${prefs.getString(KeysSharePref.idBin)!.isEmpty ? "NO ID" : prefs.getString(KeysSharePref.idBin)}",
                      isNull: prefs.getString(KeysSharePref.idBin)!.isEmpty),
                  SizedBox(
                    height: 20,
                  ),
                  CustomElevatedButton(
                      title: AppString.readQR.tr,
                      onPressed: () async {
                        await Get.to(() => QrScannerUser());
                        paymentController.update();
                      }),
                  SizedBox(
                    height: 20,
                  ),
                  Text(AppString.makePayment.tr),
                  SizedBox(
                    height: 20,
                  ),
                  CustomElevatedButton(
                      title: AppString.payment.tr,
                      onPressed: () {
                        if (paymentController.getPostion == null) {
                          Get.snackbar("Error", "Make sure you complate Steps");
                          return;
                        }

                        paymentController.makePayment(
                          amount: "2",
                          currency: "USD",
                        );
                      })
                ],
              ),
            );
          }),
    );
  }
}

class CusotmMakeSubscribeCard extends StatelessWidget {
  String massage;
  bool isNull;
  CusotmMakeSubscribeCard({
    Key? key,
    required this.massage,
    required this.isNull,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
        color: Color.fromARGB(255, 243, 241, 241),
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(massage),
            isNull
                ? Icon(
                    Icons.cancel_outlined,
                    color: Colors.red,
                  )
                : Icon(
                    Icons.check_circle_outline,
                    color: AppColors.primary,
                  )
          ],
        ));
  }
}
