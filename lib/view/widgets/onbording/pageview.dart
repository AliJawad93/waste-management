import 'package:app/controller/onbordingChnagePage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/List/onbording.dart';

class Pageview extends GetView<OnbordingChange_Implement> {
  const Pageview({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //localController locaController = Get.put(localController());
    return Scaffold(
      backgroundColor: Colors.white,
      body: PageView.builder(
        controller: controller.pageController,
        onPageChanged: (val) {
          controller.onpagechange(val);
        },
        itemCount: list_bording.length,
        itemBuilder: (contex, i) {
          return Container(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                const SizedBox(
                  height: 100,
                ),
                Container(
                  height: 300,
                  width: 400,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      image: DecorationImage(
                        image: AssetImage(
                          list_bording[i].image!,
                        ),
                      )),
                ),
                Text(
                  list_bording[i].title!,
                  style: const TextStyle(
                    fontFamily: 'Cairo',
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
