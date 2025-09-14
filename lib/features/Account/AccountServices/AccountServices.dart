import 'dart:convert';

import 'package:amazon_clone_1/constants/ErrorHandling.dart';
import 'package:amazon_clone_1/constants/Utils.dart';
import 'package:amazon_clone_1/features/auth/services/auth_services.dart';
import 'package:amazon_clone_1/models/Ordermodel.dart';
import 'package:amazon_clone_1/provider/UserProvider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class AccountServices {
  Future<List<Ordersmodel>> fetchOrder({required BuildContext context}) async {
    List<Ordersmodel> orders = [];
    var userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      http.Response res = await http.get(
        Uri.parse(ApiConfig.getApiUrl(endpoint: '/api/view-orders')),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
      );

      ErrorHandling(
          context: context,
          response: res,
          onsuccess: () {
            for (int i = 0; i < jsonDecode(res.body).length; i++) {
              orders.add(
                  Ordersmodel.fromjson(jsonEncode(jsonDecode(res.body)[i])));
            }
          });
    } catch (e) {
      showSnackbar(context, e.toString());
    }
    return orders;
  }
}
