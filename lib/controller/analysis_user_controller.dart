import 'package:app/view/ui/admin/ui/drivers_analysis.dart';
import 'package:app/view/ui/admin/ui/recenly_payment.dart';
import 'package:app/view/ui/admin/ui/recently_activities_drivers.dart';
import 'package:app/view/ui/admin/ui/users_analysis.dart';
import 'package:app/view/ui/app/p1.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../view/ui/user/ui/payment.dart';
import '../view/widgets/activities_user.dart';

class AnalysisController extends GetxController {
  int _indexPage = 0;
  final List _pagesUser = [
    ActivitiesUser(idUser: '1'),
    HistoryPaymentUser(
      idUser: null,
    ),
  ];

  final List _pagesAdmin = [
    DriversAnalysisAdmin(),
    RecentlyActivtiesDrivers(),
    UsersPaymnetAnalysisAdmin(),
    RecentlyPayment(),
  ];

  final PageController _pageController = PageController();

  bool isAdmin;
  AnalysisController({required this.isAdmin});
  void changeIndexPage(int index) {
    _indexPage = index;
    update();
  }

  List get getPages => isAdmin ? _pagesAdmin : _pagesUser;
  int get getIndexPage => _indexPage;
  PageController get getPageController => _pageController;
}
