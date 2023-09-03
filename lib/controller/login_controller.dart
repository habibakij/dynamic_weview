import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:intl/intl.dart';
import 'dart:developer';
import 'package:qr_test/network/api_service.dart';
import 'package:qr_test/utils/common.dart';
import '../model/authentication_model.dart';
import '../screen/dashboard_screen.dart';
import '../transition/enum.dart';
import '../transition/page_transition.dart';

class LoginController extends GetxController {
  @override
  void onInit() {
    checkConnection();
    super.onInit();
  }

  Rx<AuthenticationModel> authenticationModel = AuthenticationModel().obs;
  RxString token = "".obs;

  void getUserAuthentication(BuildContext context, String userName, String password) async {
    String currentData = DateFormat("yyyy-MM-dd").format(DateTime.now());
    authenticationModel.value = await ApiService.userAuthentication(userName, password);
    if (authenticationModel.value.data != null) {
      token.value = authenticationModel.value.data!.accessToken!;
      Common.saveShareData("token", token.value);
      Common.saveShareData("currentData", currentData);
    }

    if (token.value.isEmpty) {
      Common.customToast("Login failed", 1);
    } else {
      Navigator.of(context, rootNavigator: true).pushReplacement(PageTransition(
          child: DashboardScreen(token.value), type: PageTransitionType.rightToLeft));
    }
  }

  RxBool isPageLoaded = false.obs;
  RxBool isVisibile = true.obs;

  Future<bool> checkConnection() async {
    bool isConnected = await InternetConnectionChecker().hasConnection;
    if (isConnected == true) {
      log('connection_okay');
    } else {
      log('no_connection');
    }
    return isConnected;
  }
}
