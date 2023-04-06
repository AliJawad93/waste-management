import 'package:app/main.dart';
import 'package:app/model/driver_model.dart';
import 'package:app/model/user_model.dart';
import 'package:app/services/keysSharePref.dart';
import 'package:app/view/ui/app/chat_page/views/chat_page.dart';
import 'package:app/view/ui/app/profile.dart';
import 'package:app/view/ui/app/profile/profile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../view/ui/app/analysis_page.dart';
import '../view/ui/app/map_page.dart';
import '../view/ui/app/post_page.dart';

class MainPageController extends GetxController {
  int _currentIndex = 0;
  UserModel? _userModel;
  DriverModel? _driverModel;

  setCurrentIndex(int index) {
    _currentIndex = index;
    update();
  }

  setModel(model) {
    if (model.userRole == "driver") {
      setDriverModel(model);
    } else {
      setUserModel(model);
    }
  }

  setUserModel(UserModel model) {
    _userModel = model;
    update();
  }

  setDriverModel(DriverModel model) {
    _driverModel = model;
    update();
  }

  Widget getPages() {
    return Stack(
        children: [MapPage(), AnalysisPage(), ChatPage(), PostPage(), Profile()]
            .asMap()
            .map((index, screen) {
              return MapEntry(
                index,
                Offstage(
                  offstage: getCurrentIndex != index,
                  child: screen,
                ),
              );
            })
            .values
            .toList());
  }

  int get getCurrentIndex => _currentIndex;

  UserModel? get getuserModel => _userModel;
  DriverModel? get getDriverModel => _driverModel;
}
