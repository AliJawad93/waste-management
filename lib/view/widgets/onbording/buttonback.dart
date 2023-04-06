import 'package:app/controller/onbordingChnagePage.dart';
import 'package:app/core/constants/App_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class ButtonONbordingBack extends GetView<OnbordingChange_Implement> {
  String? containt;
  ButtonONbordingBack({Key? key, this.containt}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 0, bottom: 7),
      child: InkWell(
        child: Text(
          containt!,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppColors.primary,
          ),
        ),
        onTap: () {
          controller.back();
        },
      ),
    );
  }
}
