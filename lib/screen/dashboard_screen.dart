import 'package:flutter/material.dart';
import 'package:qr_test/screen/qr_screen.dart';
import 'package:hexcolor/hexcolor.dart';
import '../controller/login_controller.dart';
import '../transition/enum.dart';
import '../transition/page_transition.dart';
import 'package:get/get.dart';

import '../utils/common.dart';

class DashboardScreen extends StatefulWidget {
  DashboardScreen({Key? key}) : super(key: key);

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
      body: QRScreen(0),

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
                      PageTransition(
                          child: QRScreen(1),
                          type: PageTransitionType.leftToRight));
                } else {
                  Navigator.pop(context);
                  Common.showSnackBar(
                      context, "Please check your internet connection");
                }
              },
            ),
            const Divider(color: Colors.grey),
            ListTile(
              title: const Text('About'),
              onTap: () {
                Navigator.pop(context);
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
          ],
        ),
      ),
    );
  }
}
