import 'dart:math';

import 'package:app/model/driver_model.dart';
import 'package:app/view/ui/admin/widgets/custom_card_driver.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../widgets/activities.dart';
import '../../../widgets/custom_scafold.dart';

class InfoDriver extends StatelessWidget {
  InfoDriver(this.driverModel, {Key? key}) : super(key: key);
  DriverModel driverModel;
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: AppBar(
        title: Text("Activities"),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomCardDriver(driverModel),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              child: Text(
                "Activities ",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ),
            Activities(
              idDriver: driverModel.id,
            ),
          ],
        ),
      ),
    );
  }
}
