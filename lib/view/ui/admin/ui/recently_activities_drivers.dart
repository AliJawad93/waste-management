import 'package:app/view/ui/driver/ui/activities_driver.dart';
import 'package:app/view/widgets/activities.dart';
import 'package:app/view/widgets/custom_scafold.dart';
import 'package:flutter/material.dart';

import '../../../../data/firebase_activities.dart';
import '../../../../model/activities_model.dart';
import '../../../widgets/card.dart';

class RecentlyActivtiesDrivers extends StatelessWidget {
  const RecentlyActivtiesDrivers({super.key});

  Widget build(BuildContext context) {
    return StreamBuilder<List<ActivitiesModel>>(
      stream: FirebaseActivities.getRecentlyActivities(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        return ListView.builder(
            itemCount: snapshot.data!.length,
            // shrinkWrap:
            //     true, // show all items in same screen with out scroll but need  NeverScrollableScrollPhysics()
            // physics: const NeverScrollableScrollPhysics(),
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
