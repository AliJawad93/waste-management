import 'package:app/controller/onbordingChnagePage.dart';
import 'package:app/core/List/onbording.dart';
import 'package:app/core/constants/App_colors.dart';
import 'package:app/view/ui/app/auth/login.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: camel_case_types, must_be_immutable
class ButtonONbordingForward extends GetView<OnbordingChange_Implement> {
  String? containt;
  ButtonONbordingForward({Key? key, this.containt}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
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
          controller.currwndPgae > list_bording.length - 1
              ? Get.offAll(() => Login())
              : controller.next();
        },
      ),
    );
  }
}
