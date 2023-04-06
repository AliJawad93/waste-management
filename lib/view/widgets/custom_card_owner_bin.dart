import 'package:app/view/ui/admin/widgets/custom_image_person.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/constants/App_colors.dart';
import 'custom_rich_text.dart';

class CustomCardActivities extends StatelessWidget {
  CustomCardActivities(
      {required this.name,
      required this.date,
      required this.url,
      this.numberCash,
      Key? key})
      : super(key: key);
  String name;
  String date;
  String url;
  String? numberCash;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height * 0.1,
      width: Get.width,
      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      decoration: BoxDecoration(
          color: AppColors.background,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [BoxShadow(color: AppColors.shadow, blurRadius: 9)]),
      child: Row(
        children: [
          CustomImagePerson(url, 50),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: CustomRichText(
                  title: numberCash == null ? 'Owner bin: ' : 'Driver : ',
                  text: name,
                  icon: Icon(
                    Icons.person_outline,
                    color: AppColors.unSelectedIcon,
                    size: 20,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: CustomRichText(
                  title: 'Date: ',
                  text: date,
                  icon: Icon(
                    Icons.calendar_month_outlined,
                    color: AppColors.unSelectedIcon,
                    size: 20,
                  ),
                ),
              )
            ],
          ),
          Spacer(),
          Padding(
            padding: const EdgeInsets.only(right: 25.0),
            child: Text(
              numberCash ?? "",
              style: TextStyle(color: Colors.red),
            ),
          )
        ],
      ),
    );
  }
}
