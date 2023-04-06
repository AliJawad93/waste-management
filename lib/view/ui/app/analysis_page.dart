import 'package:app/controller/main_page_controller.dart';
import 'package:app/main.dart';
import 'package:app/services/keysSharePref.dart';
import 'package:app/view/ui/user/ui/subscribe.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../admin/ui/analysis_admin.dart';
import '../driver/ui/activities_driver.dart';
import '../user/ui/analysis_user.dart';

class AnalysisPage extends StatelessWidget {
  AnalysisPage({Key? key}) : super(key: key);
  final MainPageController _controller = Get.find();
  @override
  Widget build(BuildContext context) {
    if (prefs.getString(KeysSharePref.userRole) == "admin") {
      return AnalysisAdmin();
    } else if (prefs.getString(KeysSharePref.userRole) == "driver") {
      return ActivitiesDriver();
    } else {
      return _controller.getuserModel!.isSubscribe!
          ? AnalysisUser()
          : Subscribe();
    }
  }
}
