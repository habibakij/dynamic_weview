import 'package:flutter/material.dart';
import 'package:qr_test/screen/qr_screen.dart';

import '../transition/enum.dart';
import '../transition/page_transition.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Dashboard", style: TextStyle(fontSize: 20, color: Colors.black),),
      ),
      body: Column(
        children: [

          Container(
            height: 45.0,
            width: double.infinity,
            margin: const EdgeInsets.only(top: 20.0, left: 10.0, right: 10.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                side: BorderSide.none,
                textStyle: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12), // <-- Radius
                ),
              ),
              child: const Text("Scan", style: TextStyle(fontSize: 20, color: Colors.white),),
              onPressed: () {
                Navigator.of(context, rootNavigator: true).pushReplacement(PageTransition(
                    child: const QRViewExample(), type: PageTransitionType.leftToRight));
              },
            ),
          ),



        ],
      ),
    );
  }
}
