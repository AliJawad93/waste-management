import 'package:app/core/utils/app_string.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../controller/analysis_user_controller.dart';
import '../../../../core/constants/App_colors.dart';
import '../../admin/widgets/custom_toggle_button.dart';

class CustomToggleAnalysisUser extends StatelessWidget {
  CustomToggleAnalysisUser({super.key});
  AnalysisController controller = Get.find();
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(2),
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(100),
          boxShadow: [BoxShadow(color: AppColors.shadow, blurRadius: 9)]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomTaggleButton(
              onTap: () {
                controller.getPageController.jumpToPage(0);
              },
              index: 0,
              currentIndex: controller.getIndexPage,
              title: AppString.activitis.tr),
          CustomTaggleButton(
              onTap: () {
                controller.getPageController.jumpToPage(1);
              },
              index: 1,
              currentIndex: controller.getIndexPage,
              title: AppString.historyPayment.tr),
        ],
      ),
    );
  }
}
