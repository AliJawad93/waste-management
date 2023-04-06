import 'package:app/controller/onbordingChnagePage.dart';
import 'package:app/core/List/onbording.dart';
import 'package:app/core/constants/App_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DotOnbording extends StatelessWidget {
  const DotOnbording({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OnbordingChange_Implement>(builder: (controller) {
      return Expanded(
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          ...List.generate(
              list_bording.length,
              (index) => AnimatedContainer(
                    duration: const Duration(microseconds: 500),
                    margin: const EdgeInsets.only(left: 5),
                    width: controller.currwndPgae == index ? 25 : 7,
                    height: 10,
                    decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(10)),
                  )),
        ]),
      );
    });
  }
}
