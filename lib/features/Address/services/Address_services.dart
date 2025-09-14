import 'dart:convert';

import 'package:amazon_clone_1/constants/ErrorHandling.dart';
import 'package:amazon_clone_1/constants/Utils.dart';
import 'package:amazon_clone_1/features/auth/services/auth_services.dart';
import 'package:amazon_clone_1/provider/UserProvider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../../../models/usermodel.dart';

class AddressServices {
  void setUserAddress(String address, context) async {
    var userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      http.Response res = await http.post(
        Uri.parse(ApiConfig.getApiUrl(endpoint: '/api/address/save-address')),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
        body: jsonEncode({'address': address}),
      );
      ErrorHandling(
          context: context,
          response: res,
          onsuccess: () {
            User user = Provider.of<UserProvider>(context, listen: false)
                .user
                .copywith(address: jsonDecode(res.body)['address']);
            userProvider.setUserfromModel(user);
          });
    } catch (e) {
      showSnackbar(context, e.toString());
    }
  }

  void orderPlace({
    required BuildContext context,
    required double totalprice,
    required String address,
  }) async {
    try {
      var userProvider = Provider.of<UserProvider>(context, listen: false);
      http.Response res = await http.post(
          Uri.parse(ApiConfig.getApiUrl(endpoint: '/api/order-place')),
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token': userProvider.user.token,
          },
          body: jsonEncode({
            'cart': userProvider.user.cart,
            'totalprice': totalprice,
            'address': address
          }));
      ErrorHandling(
          context: context,
          response: res,
          onsuccess: () {
            User user = userProvider.user.copywith(cart: []);
            userProvider.setUserfromModel(user);
            showSnackbar(context, 'Order Placed Successfully! ');
          });
    } catch (e) {
      showSnackbar(context, e.toString());
    }
  }
}
