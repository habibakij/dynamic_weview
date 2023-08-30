import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';

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
  static const splashScreen = "/splash_screen";
  static const onBoardScreen = "/onBoard_screen";
  static const signInScreen = "/signIn_screen";
  static const signupScreen = "/signup_screen";
  static const homeScreen = "/home_screen";
  static const productCategoryScreen = "/product_category_screen";
  static const productDetailsScreen = "/product_details_screen";
  static const profileScreen = "/profile_screen";
  static const profileUpdateScreen = "/profile_update_screen";

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

  static String aboutText1 =
      "Car rental agencies primarily serve people who require a temporary vehicle, for example, those who do not own their own car, travelers who are out of town, or owners of damaged or destroyed vehicles who are awaiting repair or insurance compensation. Car rental agencies may also serve the self-moving industry needs, by renting vans or trucks, and in certain markets, other types of vehicles such as motorcycles or scooters may also be offered.";
  static String aboutText2 =
      "Alongside the basic rental of a vehicle, car rental agencies typically also offer extra products such as insurance, global positioning system (GPS) navigation systems, entertainment systems, mobile phones, portable WiFi and child safety seats. Car rental companies operate by purchasing or leasing a number of fleet vehicles and renting them to their customers for a fee. Rental fleets can be structured in several ways – they can be owned outright (these are known as risk vehicles because the car rental operator is taking a risk on how much the vehicle will be sold for when it is removed from service), they can be leased, or they can be owned under a guaranteed buy-back program arranged directly through a manufacturer or manufacturer financial arm (these are known as repurchase vehicles because the manufacturer outlines the exact price of original sale and of repurchase at the end of a defined term)";
  static String aboutText3 =
      "In the UK, the registration of rental cars can be concealed by using unfamiliar initials or subsidiaries, which can increase the resale value via manufacturer or third-party dealers.[6] In North America, it is common to see rental companies with their own branded second-hand car dealers where the ex-rental stock is sold directly to the public. Alternatively, auctions are often used in the United States and with the advent of digital platforms, rental cars have increasingly sold the vehicles directly to new and used car dealers bypassing the auction channels.";
  static String aboutText4 =
      "For insurance reasons, some companies stipulate a minimum and/or maximum rental age. In some cases, the minimum age for rental can be as high as 25, even in countries where the minimum legal age to hold a driver's license is much lower, e.g. 14,15,16 or 17 in the United States. It is not uncommon for there to be a young driver surcharge for all drivers aged under 25. On average, most car rental companies will only to rent to drivers who are at least 20 or 21 depending on the company.";
  static String aboutText5 =
      "The companies Hertz, Dollar Car Rental, and Thrifty have a minimum age of 20. Alamo, Enterprise, Avis, and all other reputable companies have a minimum age of 21. Certain luxury vehicles may be restricted to those 30+. The US states of New York and Michigan are the only ones who mandate via state law that rental car companies cannot refuse service on the grounds of age if the customer is at least 18 years of age or older. In addition, some companies will rent to 18 and 19 year olds if they are military or government personnel.";

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
}
