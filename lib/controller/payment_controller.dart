import 'dart:convert';
import 'package:app/core/constants/App_colors.dart';
import 'package:app/data/Firebase_payment.dart';
import 'package:app/data/firebase_map.dart';
import 'package:app/data/firebase_users.dart';
import 'package:app/main.dart';
import 'package:app/model/payment_model.dart';
import 'package:app/model/user_model.dart';
import 'package:app/services/keysSharePref.dart';
import 'package:app/view/ui/app/main_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import 'google_map_controller.dart';

class PaymentController extends GetxController {
  Map<String, dynamic>? paymentIntentData;
  MapController mapController = Get.put(MapController());
  Position? _position;
  Future<void> enableLoaction() async {
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        await Geolocator.requestPermission();
      }
      await Geolocator.getCurrentPosition();

      _position = await Geolocator.getLastKnownPosition();
    } catch (e) {
      print(e.toString());
    }
    print("[]" * 20 + _position!.latitude.toString());
    update();
  }

  sendInfoToBin() async {
    FirebaseMap.sendInfoBin(prefs.getString(KeysSharePref.idBin)!,
        _position?.latitude ?? 0, _position?.longitude ?? 0);
  }

  Future<String?> makePayment({
    required String amount,
    required String currency,
  }) async {
    try {
      paymentIntentData = await createPaymentIntent(amount, currency);
      if (paymentIntentData != null) {
        await Stripe.instance.initPaymentSheet(
            paymentSheetParameters: SetupPaymentSheetParameters(
          merchantDisplayName: 'Prospects',
          customerId: paymentIntentData!['customer'],
          paymentIntentClientSecret: paymentIntentData!['client_secret'],
          customerEphemeralKeySecret: paymentIntentData!['ephemeralKey'],
        ));

        displayPaymentSheet();
      }
    } catch (e, s) {
      print('exception:$e$s');
    }
    return paymentIntentData?["status"];
  }

  displayPaymentSheet() async {
    try {
      await Stripe.instance.presentPaymentSheet(); //
      await FirebaseMap.sendPaymnetDate(
          prefs.getString(KeysSharePref.idBin) ?? "no Id"); // ERROR is HERE

      String id = prefs.getString(KeysSharePref.uid)!;
      String name = prefs.getString(KeysSharePref.name)!;
      String urlImage = prefs.getString(KeysSharePref.urlImage)!;
      PaymentModel paymentModel = PaymentModel(
          mount: "2",
          date: DateFormat('yyyy-mm-dd hh:mm a')
              .format(DateTime.now())
              .toString(),
          idUser: id,
          nameUser: name,
          urlImage: urlImage);

      await FirebasePaymnet.sendDataPayment(paymentModel.toMap());
      if (prefs.getBool(KeysSharePref.isSubscribe) == false) {
        await FirebaseUsers.updateSubscribeAndIdBin(true);
      }

      await sendInfoToBin();

      Get.snackbar('Payment', 'Payment Successful',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: AppColors.primary,
          colorText: AppColors.white,
          margin: const EdgeInsets.all(10),
          duration: const Duration(seconds: 2));

      Get.offAll(() => MainPage());
    } on Exception catch (e) {
      if (e is StripeException) {
        print("Error from Stripe: ${e.error.localizedMessage}");
      } else {
        print("Unforeseen error: ${e}");
      }
    } catch (e) {
      print(
          "[[[[[[[[[[[[[[[[[]]]]]]]]]]]]]]]][[[[[[[[[[[[[[[[[[[[[[]]]]]]]]]]]]]]]]]]]]]]:$e");
    }
  }

  //  Future<Map<String, dynamic>>
  createPaymentIntent(String amount, String currency) async {
    try {
      Map<String, dynamic> body = {
        'amount': calculateAmount(amount),
        'currency': currency,
        'payment_method_types[]': 'card'
      };
      var response = await http.post(
          Uri.parse('https://api.stripe.com/v1/payment_intents'),
          body: body,
          headers: {
            'Authorization':
                'Bearer sk_test_51LluwIKcDYO97hhw4ATfrFErgIRxiXGO12DAtcP9u5y1oBr3EgYj4p0ipCx4lsLpRvmWMoC1A80tjtlzbPDmsBjI001z0l5Dup',
            'Content-Type': 'application/x-www-form-urlencoded'
          });
      print(response.body);
      return jsonDecode(response.body);
    } catch (err) {
      print('err charging user: ${err.toString()}');
    }
  }

  calculateAmount(String amount) {
    final a = (int.parse(amount)) * 100;
    return a.toString();
  }

  Position? get getPostion => _position;
  // //"id": "pi_3LmI1mKcDYO97hhw1YQnZ4mi"
  // payNow() async {
  //   Map<String, dynamic> body = {
  //     'amount': calculateAmount("2"),
  //     'currency': "USD",
  //     'payment_method_types[]': 'card'
  //   };
  //   var response = await http.post(
  //       Uri.parse(
  //           'https://api.stripe.com/v1/payment_intents/pi_3LmI1mKcDYO97hhw1YQnZ4mi'),
  //       body: body,
  //       headers: {
  //         'Authorization':
  //             'Bearer sk_test_51LluwIKcDYO97hhw4ATfrFErgIRxiXGO12DAtcP9u5y1oBr3EgYj4p0ipCx4lsLpRvmWMoC1A80tjtlzbPDmsBjI001z0l5Dup',
  //         'Content-Type': 'application/x-www-form-urlencoded'
  //       });
  //   print(response.body);
  // }
}
