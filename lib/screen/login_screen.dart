import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:qr_test/controller/login_controller.dart';
import 'package:get/get.dart';
import 'package:qr_test/utils/style_management.dart';

import '../transition/enum.dart';
import '../transition/page_transition.dart';
import '../utils/common.dart';
import 'dashboard_screen.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final appController = Get.put(LoginController());
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String token= "";
  @override
  void initState() {
    super.initState();
    getData();
  }

  void getData() async {
    String currentData = DateFormat("yyyy-MM-dd").format(DateTime.now());
    String token= await Common.getShareData("token");
    String oldDate= await Common.getShareData("currentData");
    log("your_token: $token oldDate: $oldDate currentData: $currentData");
    if(oldDate.compareTo(currentData) < 0){
      log("please log in");
    } else {
      Navigator.of(context, rootNavigator: true).pushReplacement(PageTransition(child: DashboardScreen(token), type: PageTransitionType.rightToLeft));
    }
  }

  @override
  Widget build(BuildContext context) {
    Common.dynamicScreenSize(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              Container(
                height: (Common.mediaQueryHeight / 2),
                margin: EdgeInsets.zero,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      height: 100,
                      alignment: Alignment.bottomCenter,
                      child: const Text(
                          "Integrated Digital Service Delivery Platform",
                          textAlign: TextAlign.center,
                          style: StyleManagement.testStyleBlackBold24),
                    ),
                    Image.asset(
                      "assets/images/nmst_logo.png",
                      height: 200,
                      width: 200,
                    ),
                  ],
                ),
              ),
              Container(
                height: 230,
                margin: EdgeInsets.zero,
                child: Card(
                  color: Colors.grey[200],
                  margin: const EdgeInsets.only(left: 20, right: 20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Container(
                    margin: const EdgeInsets.only(top: 10, bottom: 10),
                    child: Column(
                      children: [
                        Container(
                          height: 70,
                          margin: const EdgeInsets.only(left: 10, right: 10),
                          child: TextFormField(
                            controller: _emailController,
                            decoration: InputDecoration(
                              labelText: "Email",
                              filled: true,
                              fillColor: Colors.white,
                              border: InputBorder.none,
                              prefixIcon: Icon(Icons.account_circle,
                                  color: Colors.blue[800]),
                            ),
                          ),
                        ),
                        Container(
                          height: 70,
                          margin: const EdgeInsets.only(left: 10, right: 10, top: 5),
                          child: Obx(() => TextFormField(
                                controller: _passwordController,
                                obscureText: appController.isVisibile.value,
                                decoration: InputDecoration(
                                  labelText: "Password",
                                  border: InputBorder.none,
                                  filled: true,
                                  fillColor: Colors.white,
                                  prefixIcon: Icon(Icons.vpn_key, color: Colors.blue[800]),
                                  suffixIcon: IconButton(
                                    icon: appController.isVisibile.value
                                        ? const Icon(Icons.visibility_outlined)
                                        : const Icon(Icons.visibility_off_outlined),
                                    onPressed: () {
                                      appController.isVisibile.value = !appController.isVisibile.value;
                                    },
                                  ),
                                ),
                              )),
                        ),
                        Container(
                          height: 45.0,
                          width: double.infinity,
                          margin: const EdgeInsets.only(
                              top: 10.0, left: 10.0, right: 10.0),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue,
                              side: BorderSide.none,
                              textStyle: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12), // <-- Radius
                              ),
                            ),
                            child: const Text(
                              "Sign In",
                              style: TextStyle(fontSize: 20, color: Colors.white),
                            ),
                            onPressed: () async {
                              if (_emailController.text.toString().isEmpty) {
                                Common.showSnackBar(context, "Please enter email");
                              } else if (_passwordController.text
                                  .toString()
                                  .isEmpty) {
                                Common.showSnackBar(
                                    context, "Please enter password");
                              } else if (_passwordController.text.toString().length < 5) {
                                Common.showSnackBar(context, "Password at least 6 char long");
                              } else {
                                if (await appController.checkConnection()) {
                                  appController.getUserAuthentication(
                                      context,
                                      "eticket.bsrmt.operator.abdulla@yopmail.com",
                                      _passwordController.text.toString());
                                } else {
                                  Common.showSnackBar(context,
                                      "Please check your internet connection");
                                }
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    appController.dispose();
    super.dispose();
  }
}
