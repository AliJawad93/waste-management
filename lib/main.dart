import 'package:app/core/constants/App_colors.dart';
import 'package:app/services/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'view/ui/app/my_app.dart';
import 'package:shared_preferences/shared_preferences.dart';

late SharedPreferences prefs;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey =
      "pk_test_51LluwIKcDYO97hhw26AsyUrupiGoF3MVqjKZiIlFIWUQvn0WbY0jCMhXfM0GNWMVsMCaiWHXz1hjgmwK1ox7m2tV00mHTKexl7";
  await Firebase.initializeApp();

  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: AppColors.primary,
  ));

  prefs = await SharedPreferences.getInstance();
  await initServices();
  runApp(const MyApp());
}
