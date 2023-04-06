import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../data/firebase_driver.dart';
import '../../../../model/driver_model.dart';
import '../widgets/custom_card_driver.dart';
import 'info_driver.dart';

class DriversAnalysisAdmin extends StatelessWidget {
  const DriversAnalysisAdmin({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<DriverModel>>(
      future: FirebaseDriver.getDataDrivers(),
      builder: (context, snapShot) {
        if (!snapShot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        return ListView.builder(
            itemCount: snapShot.data!.length,
            itemBuilder: (context, index) => InkWell(
                onTap: () {
                  Get.to(() => InfoDriver(snapShot.data![index]));
                },
                child: CustomCardDriver(snapShot.data![index])));
      },
    );
  }
}
