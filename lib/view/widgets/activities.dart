import 'package:app/view/widgets/card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/constants/App_colors.dart';
import '../../data/firebase_activities.dart';
import '../../model/activities_model.dart';
import 'custom_card_owner_bin.dart';

class Activities extends StatelessWidget {
  Activities({required this.idDriver, Key? key}) : super(key: key);
  String? idDriver;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<ActivitiesModel>>(
      stream: FirebaseActivities.getActivities(idDriver!, true),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        return ListView.builder(
            itemCount: snapshot.data!.length,
            //  shrinkWrap:
            //    true, // show all items in same screen with out scroll but need  NeverScrollableScrollPhysics()
            //    physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: MyCard(
                    activitiesModel: snapshot.data![index],
                    isDriver: true,
                  ));
            });
      },
    );
  }
}
//  FutureBuilder(
//                     future: snapshot.data![index],
//                     builder: (context, snapshot) {
//                       if (!snapshot.hasData) {
//                         return Container(
//                           height: Get.height * 0.1,
//                           width: Get.width,
//                           margin: const EdgeInsets.symmetric(
//                               vertical: 5, horizontal: 10),
//                           decoration: BoxDecoration(
//                               color: AppColors.background,
//                               borderRadius: BorderRadius.circular(10),
//                               boxShadow: [
//                                 BoxShadow(
//                                     color: AppColors.shadow, blurRadius: 9)
//                               ]),
//                           child: Center(
//                             child: CircularProgressIndicator(
//                               color: AppColors.primary,
//                             ),
//                           ),
//                         );
//                       }

//                       return CustomCardActivities(
//                           name: snapshot.data!.userModel.name,
//                           date: snapshot.data!.date,
//                           url: snapshot.data!.userModel.urlImage);
//                     }),
             