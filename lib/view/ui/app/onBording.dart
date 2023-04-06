import 'package:app/controller/onbordingChnagePage.dart';
import 'package:app/core/List/onbording.dart';
import 'package:app/view/widgets/onbording/DotOnbording.dart';
import 'package:app/view/widgets/onbording/buttonForward.dart';
import 'package:app/view/widgets/onbording/buttonback.dart';
import 'package:app/view/widgets/onbording/pageview.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Onbording extends StatelessWidget {
  const Onbording({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Get.put(OnbordingChange_Implement());
    return Scaffold(
      drawerEnableOpenDragGesture: true,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            const Expanded(
              flex: 6,
              child: Pageview(),
            ),
            Expanded(
              flex: 1,
              child: Container(
                margin: const EdgeInsets.only(left: 20, bottom: 5, right: 25),
                child: Column(children: [
                  const Spacer(),
                  GetBuilder<OnbordingChange_Implement>(
                      builder: ((controller) => Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ButtonONbordingBack(containt: '6'.tr),
                              const DotOnbording(),
                              controller.currwndPgae == list_bording.length - 1
                                  ? ButtonONbordingForward(containt: '7'.tr)
                                  : ButtonONbordingForward(containt: '5'.tr),
                            ],
                          ))),
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
