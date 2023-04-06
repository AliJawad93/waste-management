import 'package:app/core/localization/changlanguage.dart';
import 'package:app/view/ui/app/onBording.dart';
import 'package:app/view/widgets/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChosseLanguage extends StatelessWidget {
  ChosseLanguage({super.key});
  LocalController controller = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              '1'.tr,
            ),
            const SizedBox(
              height: 30,
            ),
            CustomElevatedButton(
                title: 'Arabic',
                onPressed: () {
                  controller.changelanguage('ar');
                  Get.offAll(() => Onbording());
                }),
            const SizedBox(
              height: 12,
            ),
            CustomElevatedButton(
                title: 'English',
                onPressed: () {
                  controller.changelanguage('en');
                  Get.offAll(() => Onbording());
                }),
          ],
        ),
      ),
    );
  }
}
