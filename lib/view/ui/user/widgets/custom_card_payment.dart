import 'dart:math';

import 'package:app/core/utils/app_string.dart';
import 'package:app/model/payment_model.dart';
import 'package:app/view/widgets/custom_rich_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import 'package:app/core/constants/app_image_path.dart';

import '../../../../core/constants/App_colors.dart';
import '../../admin/widgets/custom_image_person.dart';

class CustomCardPayment extends StatelessWidget {
  PaymentModel paymentModel;
  CustomCardPayment({
    Key? key,
    required this.paymentModel,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height * 0.13,
      width: Get.width,
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: AppColors.background,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [BoxShadow(color: AppColors.shadow, blurRadius: 9)]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomImagePerson(
              paymentModel.urlImage, sqrt(Get.height + Get.width) * 2),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              CustomRichText(
                  title: AppString.name.tr,
                  text: paymentModel.nameUser,
                  icon: Icon(
                    Icons.person,
                    size: 18,
                    color: AppColors.gray,
                  )),
              CustomRichText(
                  title: AppString.mount.tr,
                  text: "\$ ${paymentModel.mount}",
                  icon: Icon(
                    Icons.payments,
                    size: 18,
                    color: AppColors.gray,
                  )),
              CustomRichText(
                  title: AppString.date.tr,
                  text: paymentModel.date,
                  icon: Icon(
                    Icons.calendar_month,
                    size: 18,
                    color: AppColors.gray,
                  )),
            ],
          ),
          Spacer(),
          Container(
            height: Get.height * 0.04,
            padding: EdgeInsets.symmetric(horizontal: 5),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(30),
            ),
            child: Text(
              AppString.paid.tr,
              style: TextStyle(color: AppColors.white, fontSize: 13),
            ),
          )
        ],
      ),
    );
  }
}
