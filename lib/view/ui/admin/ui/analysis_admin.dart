import 'dart:math';

import 'package:app/controller/analysis_user_controller.dart';
import 'package:app/core/constants/App_colors.dart';
import 'package:app/core/utils/app_string.dart';
import 'package:app/view/ui/admin/ui/add_driver.dart';
import 'package:app/view/ui/admin/ui/recenly_payment.dart';
import 'package:app/view/ui/admin/ui/users_analysis.dart';
import 'package:app/view/ui/admin/widgets/custom_toggle_analysis_admin.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../widgets/custom_scafold.dart';

class AnalysisAdmin extends StatefulWidget {
  const AnalysisAdmin({super.key});

  @override
  State<AnalysisAdmin> createState() => _AnalysisAdminState();
}

class _AnalysisAdminState extends State<AnalysisAdmin> {
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: AppBar(
        title: Text(AppString.analysis.tr),
        actions: [
          IconButton(
              onPressed: () async {
                await Get.to(() => AddDriver());
                setState(() {});
              },
              icon: const Icon(Icons.person_add))
        ],
      ),
      body: GetBuilder(
        init: AnalysisController(isAdmin: true),
        builder: (controller) {
          return Column(
            children: [
              CustomToggleAnalysisAdmin(),
              SizedBox(
                height: 10,
              ),
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
        },
      ),
    );
  }
}
