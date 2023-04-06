import 'package:app/controller/main_page_controller.dart';
import 'package:app/core/utils/app_string.dart';
import 'package:app/data/firebase_activities.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/constants/App_colors.dart';
import '../../../widgets/activities.dart';
import '../../../widgets/custom_scafold.dart';
import 'qr_code_scanner.dart';

class ActivitiesDriver extends StatelessWidget {
  ActivitiesDriver({Key? key}) : super(key: key);
  MainPageController controller = Get.find();
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: AppBar(
        title: Text(AppString.myActivities.tr),
        actions: [
          IconButton(
              onPressed: () async {
                try {
                  await Get.to(() => QrScanner());

                  await FirebaseActivities.sendInfoToActivites();

                  Get.snackbar(
                      AppString.successful.tr, AppString.activityIsAdded.tr,
                      colorText: AppColors.white,
                      backgroundColor: AppColors.primary,
                      snackPosition: SnackPosition.BOTTOM);
                } catch (e) {}
              },
              icon: Icon(Icons.crop_free))
        ],
      ),
      body: Activities(
        idDriver: controller.getDriverModel?.id,
      ),
    );
  }
}
