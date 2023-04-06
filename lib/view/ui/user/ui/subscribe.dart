import 'dart:math';

import 'package:app/core/utils/app_string.dart';
import 'package:app/main.dart';
import 'package:app/services/keysSharePref.dart';
import 'package:app/view/ui/user/ui/make_subscribe.dart';
import 'package:app/view/widgets/custom_elevated_button.dart';
import 'package:app/view/widgets/custom_scafold.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

import '../../../../controller/main_page_controller.dart';
import '../../../../controller/payment_controller.dart';

class Subscribe extends StatelessWidget {
  Subscribe({super.key});
  PaymentController _paymentController = Get.put(PaymentController());
  final MainPageController _controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: AppBar(
        title: Text(AppString.subscribe.tr),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: Get.width * 0.2),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(AppString.thereIsNoDataPleaseSubscribe.tr),
            const SizedBox(
              height: 20,
            ),
            CustomElevatedButton(
                title: AppString.subscribe.tr,
                onPressed: () {
                  Get.to(() => MakeSubscribe());
                })
          ],
        ),
      ),
    );
  }
}
