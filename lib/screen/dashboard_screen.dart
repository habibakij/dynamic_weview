import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qr_test/screen/login_screen.dart';
import 'package:qr_test/screen/qr_screen.dart';
import 'package:hexcolor/hexcolor.dart';
import '../controller/login_controller.dart';
import '../transition/enum.dart';
import '../transition/page_transition.dart';
import 'package:get/get.dart';

import '../utils/common.dart';
import '../utils/style_management.dart';

class DashboardScreen extends StatefulWidget {
  String token;
  DashboardScreen(this.token, {Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final loginController = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Dashboard",
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
      ),
      body: QRScreen(0, widget.token),

      /*Column(
        children: [
          Center(
              child: Image.asset(
            'assets/images/novo_theatre.png',
            height: 300,
            width: 300,
            fit: BoxFit.contain,
          )),
        ],
      ),*/
      drawer: Drawer(
        backgroundColor: Colors.grey[200],
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              margin: EdgeInsets.zero,
              padding: EdgeInsets.zero,
              decoration: BoxDecoration(
                color: HexColor("#ffffff"),
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(25.0),
                  bottomRight: Radius.circular(25.0),
                ),
              ),
              child: Center(
                  child: Image.asset(
                'assets/images/novo_theatre.png',
                height: 200,
                fit: BoxFit.contain,
              )),
            ),
            const Divider(color: Colors.grey),
            ListTile(
              title: const Text('QR Scan'),
              onTap: () async {
                if (await loginController.checkConnection()) {
                  Navigator.pop(context);
                  Navigator.of(context, rootNavigator: true).pushReplacement(
                      PageTransition(child: QRScreen(1, widget.token), type: PageTransitionType.leftToRight));
                } else {
                  Navigator.pop(context);
                  Common.showSnackBar(context, "Please check your internet connection");
                }
              },
            ),
            const Divider(color: Colors.grey),
            ListTile(
              title: const Text('Share'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            const Divider(color: Colors.grey),
            ListTile(
              title: const Text('Logout'),
              onTap: () {
                Navigator.pop(context);
                _logoutDialog(context);
              },
            ),
            const Divider(color: Colors.grey),
          ],
        ),
      ),
    );
  }
  void _logoutDialog(BuildContext context) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return DelayedDisplay(
            delay: const Duration(microseconds: 500),
            child: CupertinoAlertDialog(
              title: const Column(
                children:  <Widget>[
                  Text("Log out", style: StyleManagement.testStyleBlackBold18),
                  SizedBox(height: 10)
                ],
              ),
              content: const Text("Are you sure ?", style: StyleManagement.testStyleBlack14),

              actions: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                      child: Container(
                        height: 30.0,
                        width: 50.0,
                        alignment: Alignment.center,
                        child: const Text("NO", style: StyleManagement.testStyleBlueBold14),
                      ),
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                    Container(
                      height: 50.0,
                      width: 1.0,
                      color: Colors.grey,
                    ),
                    InkWell(
                      child: Container(
                        height: 30.0,
                        width: 50.0,
                        alignment: Alignment.center,
                        child: const Text("YES", style: StyleManagement.testStyleBlueBold14),
                      ),
                      onTap: () {
                        Navigator.pop(context);
                        Common.clearSharedData();
                        Navigator.of(context, rootNavigator: true).pushReplacement(
                            PageTransition(child: LoginScreen(), type: PageTransitionType.rightToLeft));
                      },
                    ),
                  ],
                ),
              ],
            ),
          );
        });
  }
}
