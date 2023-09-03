import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:qr_test/screen/dashboard_screen.dart';
import 'package:qr_test/screen/login_screen.dart';
import 'package:qr_test/screen/qr_screen.dart';
import 'package:get/get.dart';
import 'package:qr_test/utils/common.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Most QR',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      //home: const HomeScreen(),
      initialRoute: Common.loginScreen,
      getPages: [
        GetPage(name: Common.loginScreen, page: () => LoginScreen()),
        GetPage(name: Common.dashboardScreen, page: () => DashboardScreen("")),
        GetPage(name: Common.qrScreen, page: () => QRScreen(0,"")),
      ],
      builder: EasyLoading.init(),
    );
  }
}
