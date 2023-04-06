import 'package:app/core/utils/app_string.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../controller/adding_driver_controller.dart';

class CusotmFormDriverr extends StatelessWidget {
  const CusotmFormDriverr({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddingDriverController>(builder: (controller) {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: ListView(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: controller.getNameController,
              decoration: InputDecoration(
                hintText: AppString.enterYourName.tr,
                prefixIcon: Icon(Icons.person_outline),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: controller.getBirthday,
              decoration: InputDecoration(
                hintText: AppString.enterYourBirthday.tr,
                prefixIcon: Icon(Icons.person_outline),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: controller.getNumberTruckController,
              decoration: InputDecoration(
                hintText: AppString.enterNumberTruck.tr,
                prefixIcon: Icon(Icons.badge_outlined),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: controller.getWorkDaysController,
              decoration: InputDecoration(
                hintText: AppString.enterWorkDays.tr,
                prefixIcon: Icon(Icons.calendar_month_outlined),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: controller.getWorkStreetController,
              decoration: InputDecoration(
                hintText: AppString.enterWorkStreet.tr,
                prefixIcon: Icon(Icons.location_on_outlined),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: controller.getEmailController,
              decoration: InputDecoration(
                hintText: AppString.email.tr,
                prefixIcon: Icon(Icons.email_outlined),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: controller.getPassword,
              obscureText: true,
              decoration: InputDecoration(
                hintText: AppString.password.tr,
                prefixIcon: Icon(Icons.lock_outline),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(AppString.adminSection.tr),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: controller.getEmailAdminController,
              decoration: InputDecoration(
                hintText: AppString.email.tr,
                prefixIcon: Icon(Icons.email_outlined),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: controller.getPasswordAdmin,
              obscureText: true,
              decoration: InputDecoration(
                hintText: AppString.password.tr,
                prefixIcon: Icon(Icons.lock_outline),
              ),
            ),
          ],
        ),
      );
    });
  }
}
