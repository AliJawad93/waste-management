import 'package:flutter/material.dart';

import '../../../../core/constants/App_colors.dart';
import '../../../widgets/custom_card_owner_bin.dart';

class CustomExpansionTile extends StatelessWidget {
  const CustomExpansionTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
          color: AppColors.background,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [BoxShadow(color: AppColors.shadow, blurRadius: 9)]),
      child: ExpansionTile(
          backgroundColor: Colors.white,
          initiallyExpanded: false,
          title: Text(
            'January : 10 bins',
          ),
          iconColor: AppColors.primary,
          textColor: AppColors.primary,
          children: [
            // CustomCardOwnerBin(),
            // CustomCardOwnerBin(),
            // CustomCardOwnerBin(),
            // CustomCardOwnerBin(),
            // CustomCardOwnerBin(),
            // CustomCardOwnerBin(),
          ]),
    );
  }
}
