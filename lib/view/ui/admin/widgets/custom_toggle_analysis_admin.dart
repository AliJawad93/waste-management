import 'dart:math';

import 'package:app/controller/analysis_user_controller.dart';
import 'package:app/core/utils/app_string.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/constants/App_colors.dart';
import 'custom_toggle_button.dart';

class CustomToggleAnalysisAdmin extends StatelessWidget {
  CustomToggleAnalysisAdmin({super.key});
  AnalysisController controller = Get.find();
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      padding: EdgeInsets.all(2),
      decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(100),
          boxShadow: [BoxShadow(color: AppColors.shadow, blurRadius: 9)]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          CustomTaggleButton(
              onTap: () {
                controller.getPageController.jumpToPage(0);
              },
              index: 0,
              currentIndex: controller.getIndexPage,
              title: AppString.drivers.tr),
          CustomTaggleButton(
              onTap: () {
                controller.getPageController.jumpToPage(1);
              },
              index: 1,
              currentIndex: controller.getIndexPage,
              title: AppString.activitis.tr),
          CustomTaggleButton(
              onTap: () {
                controller.getPageController.jumpToPage(2);
              },
              index: 2,
              currentIndex: controller.getIndexPage,
              title: AppString.users.tr),
          CustomTaggleButton(
              onTap: () {
                controller.getPageController.jumpToPage(3);
              },
              index: 3,
              currentIndex: controller.getIndexPage,
              title: AppString.payment.tr),
        ],
      ),
    );
  }
}
