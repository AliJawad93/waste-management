import 'package:app/core/localization/changlanguage.dart';
import 'package:app/core/localization/translation.dart';
import 'package:app/core/utils/app_theme.dart';
import 'package:app/main.dart';
import 'package:app/services/keysSharePref.dart';
import 'package:app/view/ui/app/auth/login.dart';
import 'package:app/view/ui/app/choos_language.dart';
import 'package:app/view/ui/app/main_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    LocalController controller = Get.put(LocalController());

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.themeData(),
      translations: Mytranslation(),
      locale: controller.language,
      home: prefs.getBool(KeysSharePref.isLogin) == null
          ? ChosseLanguage()
          : prefs.getBool(KeysSharePref.isLogin) == false
              ? Login()
              : MainPage(),
    );
  }
}
