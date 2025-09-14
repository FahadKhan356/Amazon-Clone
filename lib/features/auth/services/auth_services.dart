// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'package:amazon_clone_1/constants/ErrorHandling.dart';
import 'package:amazon_clone_1/constants/Utils.dart';
import 'package:amazon_clone_1/models/usermodel.dart';
import 'package:amazon_clone_1/provider/UserProvider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiConfig {
  static const String ApiBaseUrl = 'http://192.168.10.8:5000';

  static String getApiUrl({String? endpoint}) {
    return '$ApiBaseUrl$endpoint';
  }
}

class Auth_Services {
  void Signup({
    required String email,
    required String password,
    required String name,
    required BuildContext context,
  }) async {
    try {
      User user = User(
        id: '',
        name: name,
        email: email,
        password: password,
        address: '',
        type: '',
        token: '',
        cart: [],
      );

      http.Response res = await http.post(
          // Uri.parse("http://192.168.10.6:5000/api/signup"),
          Uri.parse(ApiConfig.getApiUrl(endpoint: '/api/signup')),
          body: user.toJson(),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          });
      ErrorHandling(
          context: context,
          response: res,
          onsuccess: () {
            showSnackbar(
                context, "created account! let sign in with same cradentials");
          });
    } catch (e) {
      showSnackbar(
        context,
        e.toString(),
      );
    }
  }

//http request for sign in
  void signInUser(
      {required String email,
      required String password,
      required BuildContext context}) async {
    try {
      http.Response res = await http.post(
          //Uri.parse("http://192.168.10.6:5000/api/signin"),
          Uri.parse(ApiConfig.getApiUrl(endpoint: '/api/signin')),
          body: jsonEncode({"email": email, "password": password}),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          });

      ErrorHandling(
          context: context,
          response: res,
          onsuccess: () async {
            showSnackbar(context, "login");
                  print("error $context");

            SharedPreferences prefs = await SharedPreferences.getInstance();
            await prefs.setString(
                'x-auth-token', jsonDecode(res.body)['token']);
            Provider.of<UserProvider>(context, listen: false).setUser(res.body);
            // print(" value of token  ${prefs.getString('x-auth-token')}");
            /* Navigator.pushNamedAndRemoveUntil(
                context, BottomBar.routeName, (route) => false);*/
          });
    } catch (e) {
      print("error $e");
      showSnackbar(context, e.toString());
    }
  }

  void getuserData(BuildContext context) async {
    try {
      SharedPreferences pref = await SharedPreferences.getInstance();
      String? token = pref.getString('x-auth-token');

      if (token == null) {
        pref.setString("x-auth-token", "");
        print(" value of token when null  ${pref.getString('x-auth-token')}");
      }
      print(" token when  $token");

      //validation api
      var tokenRes = await http.post(
          //Uri.parse('http://192.168.10.6:5000/validtoken'),
          Uri.parse(ApiConfig.getApiUrl(endpoint: '/validtoken')),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token': token!,
          });

      var response = await jsonDecode(tokenRes.body);
      print("response from validoken api ${response}");

      //now getuser data api
      if (response == true) {
        http.Response userRes = await http.get(
            // Uri.parse("http://192.168.10.6:5000/"),
            Uri.parse(ApiConfig.getApiUrl(endpoint: '/')),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
              'x-auth-token': token,
            });

        var userProvider = Provider.of<UserProvider>(context, listen: false);
        userProvider.setUser(userRes.body);
      }
    } catch (e) {
      print(" kia error hai ${e.toString()}");
    }
  }
}
