import 'dart:async';
import 'dart:convert';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;
import 'package:http_interceptor/http/intercepted_client.dart';
import '../model/authentication_model.dart';
import '../network/app_url.dart';
import '../network/interceptor.dart';
import '../utils/common.dart';

class ApiService {
  static http.Client client =
      InterceptedClient.build(interceptors: [ApiInterceptor()]);

  static Future<AuthenticationModel> userAuthentication(
      String userName, String password) async {
    // ignore: prefer_typing_uninitialized_variables
    AuthenticationModel authenticationModel = AuthenticationModel();
    try {
      EasyLoading.show(status: "Please wait...");
      var response = await client.post(Uri.parse(AppUrl.loginUrl),
          body: {"username": userName, "password": password});
      if (response.statusCode == 200 || response.statusCode == 201) {
        EasyLoading.dismiss();
        authenticationModel =
            AuthenticationModel.fromJson(jsonDecode(response.body));
      } else {
        EasyLoading.dismiss();
        Common.customToast(
            "Error fetching. \n ${response.statusCode}, ${response.body}", 1);
      }
    } catch (exception) {
      EasyLoading.dismiss();
      Common.customToast("Error occure: $exception", 1);
    }
    return authenticationModel;
  }
}
