import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../controller/adding_driver_controller.dart';
import '../../../../core/constants/App_colors.dart';

class CustomAddingImagePerson extends StatelessWidget {
  const CustomAddingImagePerson({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddingDriverController>(builder: (controller) {
      return Container(
        height: 70,
        width: 70,
        margin: EdgeInsets.only(top: Get.height * 0.025),
        decoration: BoxDecoration(
            color: AppColors.background,
            shape: BoxShape.circle,
            boxShadow: [BoxShadow(color: AppColors.shadow, blurRadius: 9)]),
        child: Stack(
          alignment: Alignment.center,
          children: [
            controller.getPlatformFile == null
                ? Icon(
                    Icons.person_outline,
                    size: 30,
                  )
                : ClipOval(
                    child: Image.file(File(controller.getPlatformFile!.path!))),
            Positioned(
              bottom: 0,
              right: 0,
              child: InkWell(
                onTap: () async {
                  await controller.selectImage();
                },
                child: CircleAvatar(
                  radius: 11,
                  backgroundColor: AppColors.primary,
                  child: Icon(
                    Icons.add,
                    size: 20,
                    color: AppColors.background,
                  ),
                ),
              ),
            )
          ],
        ),
      );
    });
  }
}
