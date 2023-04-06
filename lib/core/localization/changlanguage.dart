import 'package:app/services/services.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class LocalController extends GetxController {
  Locale? language;
  Myservices myservices = Get.find();

  changelanguage(String languageCode) {
    Locale locale = Locale(languageCode);
    myservices.sharedPreferences.setString('lang', languageCode);
    Get.updateLocale(locale);
  }

  @override
  void onInit() {
    String? sharedPreferLanguage =
        myservices.sharedPreferences.getString('lang');
    if (sharedPreferLanguage == 'ar') {
      language = const Locale('ar');
    } else if (sharedPreferLanguage == 'en') {
      language = const Locale('en');
    } else {
      language = Locale(Get.deviceLocale!.languageCode);
    }
    super.onInit();
  }
}
