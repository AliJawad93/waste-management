import 'package:app/controller/main_page_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/constants/App_colors.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  const CustomBottomNavigationBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MainPageController>(builder: (controller) {
      return BottomAppBar(
        notchMargin: 10.0,
        elevation: 10,
        shape: const CircularNotchedRectangle(),
        child: SizedBox(
          height: Get.height * 0.085,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                width: Get.width * 0.45,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    IconButton(
                        onPressed: () {
                          controller.setCurrentIndex(1);
                        },
                        icon: Icon(
                          Icons.timeline,
                          color: controller.getCurrentIndex != 1
                              ? AppColors.unSelectedIcon
                              : AppColors.selectedIcon,
                        )),
                    IconButton(
                        onPressed: () {
                          controller.setCurrentIndex(2);
                        },
                        icon: Icon(
                          Icons.chat,
                          color: controller.getCurrentIndex != 2
                              ? AppColors.unSelectedIcon
                              : AppColors.selectedIcon,
                        )),
                  ],
                ),
              ),
              Spacer(),
              SizedBox(
                width: Get.width * 0.45,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    IconButton(
                        onPressed: () {
                          controller.setCurrentIndex(3);
                        },
                        icon: Icon(
                          Icons.assistant,
                          color: controller.getCurrentIndex != 3
                              ? AppColors.unSelectedIcon
                              : AppColors.selectedIcon,
                        )),
                    IconButton(
                        onPressed: () {
                          controller.setCurrentIndex(4);
                        },
                        icon: Icon(
                          Icons.account_circle,
                          color: controller.getCurrentIndex != 4
                              ? AppColors.unSelectedIcon
                              : AppColors.selectedIcon,
                        )),
                  ],
                ),
              )
            ],
          ),
        ),
      );
    });
  }
}
