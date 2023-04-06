import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/constants/App_colors.dart';

class CustomScaffold extends StatelessWidget {
  CustomScaffold({this.appBar, this.body, this.padding, super.key});
  Widget? body;
  PreferredSizeWidget? appBar;
  EdgeInsetsGeometry? padding;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBar,
      body: Stack(
        children: [
          Positioned(
            top: 0,
            right: 0,
            child: Container(
              height: Get.height,
              width: Get.width,
              color: AppColors.primary,
            ),
          ),
          Container(
            height: Get.height,
            width: Get.width,
            padding: padding ?? EdgeInsets.only(top: sqrt(Get.height)),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(60.0),
              ),
            ),
            child: body,
          )
        ],
      ),
    );
  }
}
