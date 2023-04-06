import 'dart:math';

import 'package:app/core/utils/app_string.dart';
import 'package:app/model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/constants/App_colors.dart';
import '../../../widgets/custom_rich_text.dart';
import 'custom_image_person.dart';

class CusromCardUserSubScribed extends StatelessWidget {
  CusromCardUserSubScribed({required this.userModel, super.key});
  UserModel userModel;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height * 0.14,
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: AppColors.background,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [BoxShadow(color: AppColors.shadow, blurRadius: 9)]),
      child: Row(
        children: [
          CustomImagePerson(
              userModel.urlImage ?? '', sqrt(Get.height + Get.width) * 2),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: CustomRichText(
                  title: AppString.userName.tr,
                  text: userModel.name ?? '',
                  icon: Icon(
                    Icons.person,
                    color: AppColors.unSelectedIcon,
                    size: 20,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: CustomRichText(
                  title: AppString.birthDay.tr,
                  text: userModel.birthDay ?? '',
                  icon: Icon(
                    Icons.calendar_month,
                    color: AppColors.unSelectedIcon,
                    size: 20,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
    ;
  }
}
