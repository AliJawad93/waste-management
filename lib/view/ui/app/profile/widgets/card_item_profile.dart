import 'dart:math';

import 'package:app/core/constants/App_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CardItemProfile extends StatelessWidget {
  String title;
  IconData iconData;
  void Function() onTap;
  CardItemProfile({
    Key? key,
    required this.title,
    required this.iconData,
    required this.onTap,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(sqrt(Get.height + Get.width) * 0.8),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 8,
            )
          ],
        ),
        child: Row(
          children: [
            Icon(
              iconData,
              color: AppColors.primary,
            ),
            SizedBox(
              width: Get.width * 0.05,
            ),
            Text(
              title,
              style: TextStyle(color: AppColors.black, fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
