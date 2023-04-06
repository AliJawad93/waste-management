import 'package:app/view/ui/app/main_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../main.dart';
import 'keysSharePref.dart';

class LoginServices {
  static String? myemail;
  static String? mypassword;
  static Future<void> login(String email, String password) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password)
          .then((_) {
        prefs.setBool(KeysSharePref.isLogin, true);

        prefs.setString(
            KeysSharePref.uid, FirebaseAuth.instance.currentUser!.uid);
        Get.offAll(() => MainPage());
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Get.defaultDialog(
          title: 'user-not-found',
          middleText: 'try again ',
          textCancel: 'cansle',
        );
      } else if (e.code == 'wrong-password') {
        Get.defaultDialog(
          title: 'Wrong password provided for that user.',
          middleText: 'try again ',
          textCancel: 'cansle',
        );
      }
    }
  }
}
