import 'package:flutter/material.dart';
import 'package:qr_test/screen/dashboard.dart';
import 'package:qr_test/transition/enum.dart';
import 'package:qr_test/transition/page_transition.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MOST',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  final TextEditingController _emailController= TextEditingController();
  final TextEditingController _passwordController= TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     appBar: AppBar(),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("images/login_bg.png"),
                fit: BoxFit.cover
            )
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [

              Container(
                child: Image.network(
                  "https://pbs.twimg.com/profile_images/1310923325166804993/Oi2z5PFJ_400x400.jpg",
                  height: 150,
                  width: 200,
                ),
              ),

              Card(
                color: Colors.grey[100],
                margin: const EdgeInsets.only(left: 20, right: 20),
                child: Container(
                  margin: const EdgeInsets.only(top: 10, bottom: 10),
                  child: Column(
                    children: [

                      ///Email text form field container
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
                            prefixIcon: Icon(
                                Icons.account_circle,
                                color: Colors.blue[800]
                            ),
                          ),
                        ),
                      ),

                      ///Password text form field container
                      Container(
                        height: 70,
                        margin: const EdgeInsets.only(left: 10, right: 10, top: 5),
                        child: TextFormField(
                          controller: _passwordController,
                          decoration: InputDecoration(
                            labelText: "Password",
                            border: InputBorder.none,
                            filled: true,
                            fillColor: Colors.white,
                            prefixIcon:
                            Icon(Icons.vpn_key, color: Colors.blue[800]),
                          ),
                        ),
                      ),

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
                          child: const Text("Sign In", style: TextStyle(fontSize: 20, color: Colors.white),),
                          onPressed: () {
                            Navigator.of(context, rootNavigator: true).pushReplacement(PageTransition(
                                child: const Dashboard(), type: PageTransitionType.leftToRight));
                          },
                        ),
                      ),

                    ],
                  ),
                ),
              ),

            ],
          ),
        ),

      ),
    );
  }
}
