import 'package:app/core/utils/app_string.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/constants/App_colors.dart';
import '../../model/activities_model.dart';
import '../ui/admin/widgets/custom_image_person.dart';
import 'custom_rich_text.dart';

class MyCard extends StatelessWidget {
  MyCard({required this.activitiesModel, required this.isDriver, Key? key})
      : super(key: key);
  ActivitiesModel activitiesModel;
  bool isDriver;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height * 0.3,
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: AppColors.background,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [BoxShadow(color: AppColors.shadow, blurRadius: 9)]),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CustomImagePerson(
                  isDriver
                      ? activitiesModel.urlImageDriver
                      : activitiesModel.urlImageUser,
                  50),
              !isDriver
                  ? CustomRichText(
                      title: AppString.nameDriver.tr,
                      text: activitiesModel.nameUser,
                      icon: null)
                  : CustomRichText(
                      title: AppString.ownerBin.tr,
                      text: activitiesModel.nameUser,
                      icon: null)
            ],
          ),
          !isDriver
              ? Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: CustomRichText(
                    title: AppString.ownerBin.tr,
                    text: activitiesModel.nameDriver,
                    icon: Icon(
                      Icons.person,
                      color: AppColors.unSelectedIcon,
                      size: 20,
                    ),
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: CustomRichText(
                    title: AppString.nameDriver.tr,
                    text: activitiesModel.nameDriver,
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
              title: AppString.locationBin.tr,
              text: activitiesModel.location,
              icon: Icon(
                Icons.home,
                color: AppColors.unSelectedIcon,
                size: 20,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: CustomRichText(
                title: AppString.date.tr,
                text: activitiesModel.date,
                icon: Icon(
                  Icons.calendar_month_outlined,
                  color: AppColors.unSelectedIcon,
                  size: 20,
                )),
          )
        ],
      ),
    );
  }
}
