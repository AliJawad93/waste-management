import 'package:app/controller/analysis_user_controller.dart';
import 'package:app/controller/payment_controller.dart';
import 'package:app/core/constants/app_image_path.dart';
import 'package:app/core/utils/app_string.dart';
import 'package:app/view/ui/user/ui/payment.dart';
import 'package:app/view/ui/user/widgets/custom_toggle_analysis_user.dart';
import 'package:app/view/widgets/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/percent_indicator.dart';

import '../../../../controller/qr_scanner_controller.dart';
import '../../../../core/constants/App_colors.dart';
import '../../../widgets/activities_user.dart';
import '../../../widgets/custom_scafold.dart';

class AnalysisUser extends StatelessWidget {
  AnalysisUser({Key? key}) : super(key: key);
  // QrScannerControllerDriver qrScannerController =
  //     Get.put(QrScannerControllerDriver());
  // AnalysisUserController analysisUserController =
  //     Get.put(AnalysisUserController());
  PaymentController _paymentController = Get.put(PaymentController());
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      padding: EdgeInsets.zero,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          AppString.analysis.tr,
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
              onPressed: () {
                _paymentController.makePayment(
                  amount: "2",
                  currency: "USD",
                );
              },
              icon: Icon(
                Icons.payments,
                color: AppColors.background,
              )),
        ],
      ),
      body: GetBuilder<AnalysisController>(
          init: AnalysisController(isAdmin: false),
          builder: (controller) {
            return Column(
              children: [
                CustomToggleAnalysisUser(),
                Expanded(
                  child: PageView.builder(
                      controller: controller.getPageController,
                      itemCount: controller.getPages.length,
                      onPageChanged: (index) {
                        controller.changeIndexPage(index);
                      },
                      itemBuilder: (context, index) {
                        return controller.getPages[index];
                      }),
                ),
              ],
            );
          }),
    );
  }
}
