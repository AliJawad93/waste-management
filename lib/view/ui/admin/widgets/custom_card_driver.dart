import 'package:app/core/constants/app_image_path.dart';
import 'package:app/core/utils/app_string.dart';
import 'package:app/model/driver_model.dart';
import 'package:app/view/widgets/custom_rich_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/constants/App_colors.dart';
import 'custom_image_person.dart';

class CustomCardDriver extends StatelessWidget {
  CustomCardDriver(this.driverModel, {Key? key}) : super(key: key);
  DriverModel driverModel;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
          color: AppColors.background,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [BoxShadow(color: AppColors.shadow, blurRadius: 9)]),
      child: Row(
        children: [
          CustomImagePerson(driverModel.urlImage, 70),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomRichText(
                  title: AppString.name.tr,
                  text: driverModel.name,
                  icon: Icon(Icons.person_outline,
                      color: AppColors.unSelectedIcon)),
              CustomRichText(
                  title: AppString.numberTruck.tr,
                  text: driverModel.numberTruck.toString(),
                  icon: Icon(Icons.badge_outlined,
                      color: AppColors.unSelectedIcon)),
              CustomRichText(
                  title: AppString.workStreet.tr,
                  text: driverModel.workStreet,
                  icon: Icon(Icons.location_on_outlined,
                      color: AppColors.unSelectedIcon)),
              CustomRichText(
                  title: AppString.workDays.tr,
                  text: driverModel.workDays,
                  icon: Icon(Icons.calendar_month_outlined,
                      color: AppColors.unSelectedIcon)),
            ],
          )
        ],
      ),
    );
  }
}
