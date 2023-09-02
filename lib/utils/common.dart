import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Common {
  /// SharedPreferences key
  static const userName = "userName";
  static const userEmail = "userEmail";
  static const userPhone = "userPhone";
  static const userAddress = "userAddress";
  static const userPassword = "userPassword";
  static const userAvater = "userAvater";
  static const userType = "userType";

  /// screen name
  static const loginScreen = "/login_screen";
  static const dashboardScreen = "/dashboard_screen";
  static const qrScreen = "/qr_screen";

  /// screen dynamic size
  static var mediaQueryHeight = 0.0, mediaQueryWidth = 0.0;
  static void dynamicScreenSize(BuildContext context) {
    mediaQueryHeight = MediaQuery.of(context).size.height;
    mediaQueryWidth = MediaQuery.of(context).size.width;
  }

  /// custom toast
  static customToast(String msg, int isRed) {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: isRed == 1 ? Colors.red[200] : Colors.grey[400],
        textColor: Colors.black,
        fontSize: 14.0);
  }

  /// configure easyloading
  static void configLoading() {
    EasyLoading.instance
      ..displayDuration = const Duration(milliseconds: 2000)
      ..indicatorType = EasyLoadingIndicatorType.fadingCircle
      ..loadingStyle = EasyLoadingStyle.dark
      ..indicatorSize = 45.0
      ..radius = 10.0
      ..progressColor = Colors.yellow
      ..backgroundColor = Colors.green
      ..indicatorColor = Colors.yellow
      ..textColor = Colors.yellow
      ..maskColor = Colors.blue.withOpacity(0.5)
      ..userInteractions = true
      ..dismissOnTap = false;
  }

  static showSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(
      content: Text(message),
      duration: const Duration(seconds: 2),
      action: SnackBarAction(
        label: 'Undo',
        onPressed: () {
          // Write your code to undo the change.
        },
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  static Future<void> saveShareData(String key, String value) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString(key, value);
  }

  static Future<String> getShareData(String key) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String data = sharedPreferences.getString(key) ?? "";
    return data;
  }
}
