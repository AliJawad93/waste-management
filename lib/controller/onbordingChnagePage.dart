// ignore: file_names
import 'package:app/core/List/onbording.dart';
import 'package:app/view/ui/app/auth/login.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class OnbordingChangPage extends GetxController {
  next();
  onpagechange(int index);
  back();
}

// ignore: camel_case_types
class OnbordingChange_Implement extends OnbordingChangPage {
  late PageController pageController;
  int currwndPgae = 0;
  @override
  next() {
    currwndPgae++;
    if (currwndPgae > list_bording.length - 1) {
      Get.offAll(() => Login());
    }
    pageController.animateToPage(currwndPgae,
        duration: const Duration(milliseconds: 1000), curve: Curves.easeInOut);
  }

  @override
  back() {
    currwndPgae--;
    pageController.animateToPage(currwndPgae,
        duration: const Duration(milliseconds: 1000), curve: Curves.easeInOut);
  }

  @override
  onpagechange(int index) {
    currwndPgae = index;
    update();
  }

  @override
  void onInit() {
    pageController = PageController();
    super.onInit();
  }
}
