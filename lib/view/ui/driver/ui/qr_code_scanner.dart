import 'dart:io';

import 'package:app/controller/qr_scanner_controller.dart';
import 'package:app/core/constants/App_colors.dart';
import 'package:app/data/firebase_activities.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QrScanner extends StatelessWidget {
  QrScanner({Key? key}) : super(key: key);

  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<QrScannerControllerDriver>(
        init: QrScannerControllerDriver(),
        builder: (controller) {
          return Stack(
            children: <Widget>[
              QRView(
                key: qrKey,
                onQRViewCreated: controller.onQRViewCreated,
                overlay: QrScannerOverlayShape(
                    borderRadius: 10,
                    borderLength: 20,
                    borderWidth: 10,
                    borderColor: AppColors.background,
                    cutOutSize: Get.width * 0.8),
              ),
              Center(
                child: (controller.getResult != null)
                    ? Container(
                        height: 100,
                        width: 100,
                        color: AppColors.white,
                        alignment: Alignment.center,
                        child: Text('Data: ${controller.getResult!.code}'))
                    : const SizedBox(),
              )
            ],
          );
        },
      ),
    );
  }
}
