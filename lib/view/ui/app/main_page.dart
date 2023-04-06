import 'package:app/controller/main_page_controller.dart';
import 'package:app/core/constants/App_colors.dart';
import 'package:app/data/firebase_driver.dart';
import 'package:app/main.dart';
import 'package:app/model/driver_model.dart';
import 'package:app/model/user_model.dart';
import 'package:app/services/keysSharePref.dart';
import 'package:app/view/widgets/bottom_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../data/firebase_users.dart';

class MainPage extends StatelessWidget {
  MainPage({Key? key}) : super(key: key);
  final MainPageController controller = Get.put(MainPageController());
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<dynamic>(
      future: FirebaseUsers.getDataUser(FirebaseAuth.instance.currentUser!.uid),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Container(
              color: Colors.white,
              alignment: Alignment.center,
              child: const CircularProgressIndicator(
                color: Colors.pink,
              ));
        }
        controller.setModel(snapshot.data!);
        return GetBuilder<MainPageController>(
          builder: (controller) {
            return Scaffold(
              resizeToAvoidBottomInset: true,
              floatingActionButton: Visibility(
                visible: !(MediaQuery.of(context).viewInsets.bottom != 0),
                child: FloatingActionButton(
                  backgroundColor: AppColors.primary,
                  onPressed: () {
                    controller.setCurrentIndex(0);
                  },
                  child: const Icon(Icons.map),
                ),
              ),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerDocked,
              bottomNavigationBar: const CustomBottomNavigationBar(),
              body: controller.getPages(),
            );
          },
        );
      },
    );
  }
}
