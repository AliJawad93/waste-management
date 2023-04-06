import 'package:app/view/widgets/card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/constants/App_colors.dart';
import '../../data/firebase_activities.dart';
import '../../model/activities_model.dart';
import 'custom_card_owner_bin.dart';

class ActivitiesUser extends StatelessWidget {
  ActivitiesUser({required this.idUser, Key? key}) : super(key: key);
  String idUser;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<ActivitiesModel>>(
      stream: FirebaseActivities.getActivities(idUser, false),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const SizedBox();
        }

        return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: MyCard(
                      activitiesModel: snapshot.data![index], isDriver: false));
            });
      },
    );
  }
}
