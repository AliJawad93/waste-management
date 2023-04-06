import 'package:app/controller/payment_controller.dart';
import 'package:app/data/firebase_affirmations.dart';
import 'package:get/get.dart';

class P extends GetxController {
  String? requsetCode;
  String? confirmCode;
  String? status;
  final PaymentController _paymentController = Get.put(PaymentController());

  @override
  void onInit() {
    super.onInit();
  }
}
