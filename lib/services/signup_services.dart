import 'package:app/view/ui/app/auth/verify.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class SignupServices {
  static late final credential;
  static String? myemail;
  static String? mypassword;
  static String? mymopile;
  static late User user;

  static Future<void> signUp(
    String? email,
    String? password,
  ) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email!, password: password!);
      Get.to(() => Verification());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        Get.defaultDialog(
            title: 'Error',
            content: const Text('The password provided is too weak'));
      } else if (e.code == 'email-already-in-use') {
        Get.defaultDialog(
            title: 'Error', content: const Text('this email-already-in-use'));
      }
    } catch (e) {
      (e);
    }
  }
}
