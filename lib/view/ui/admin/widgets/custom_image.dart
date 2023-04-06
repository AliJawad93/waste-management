import 'dart:io';

import 'package:app/controller/adding_post_controller.dart';
import 'package:app/core/utils/app_string.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/constants/App_colors.dart';

class CustomImagePost extends StatelessWidget {
  CustomImagePost({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddingPostController>(builder: (controller) {
      return Container(
        margin: EdgeInsets.symmetric(vertical: 20),
        decoration: BoxDecoration(
            color: AppColors.background,
            boxShadow: [BoxShadow(color: AppColors.shadow, blurRadius: 9)],
            borderRadius: BorderRadius.circular(20)),
        child: Column(
          children: [
            if (controller.getPlatformFile != null)
              Container(
                height: Get.height * 0.5,
                width: Get.width,
                margin: EdgeInsets.symmetric(vertical: 20),
                child: Center(
                  child: Image.file(
                    File(controller.getPlatformFile!.path!),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            Container(
              height: Get.height * 0.1,
              width: Get.width,
              child: ElevatedButton.icon(
                onPressed: () {
                  controller.selectImage();
                },
                icon: Icon(
                  Icons.image_outlined,
                  color: AppColors.primary,
                ),
                label: Text(
                  AppString.addImage.tr,
                  style: TextStyle(color: Colors.black),
                ),
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20), // <-- Radius
                    ),
                    elevation: 0),
              ),
            ),
          ],
        ),
      );
    });
  }
}
