import 'dart:convert';

import 'package:amazon_clone_1/constants/ErrorHandling.dart';
import 'package:amazon_clone_1/constants/Utils.dart';
import 'package:amazon_clone_1/features/auth/services/auth_services.dart';
import 'package:amazon_clone_1/models/Product.dart';
import 'package:amazon_clone_1/provider/UserProvider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../../../models/usermodel.dart';

class Cartservice {
  void removefromcart(Product product, BuildContext context) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      http.Response res = await http.delete(
          Uri.parse(ApiConfig.getApiUrl(
              endpoint: '/api/delete-from-cart/${product.id}')),
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token': userProvider.user.token,
          });
      ErrorHandling(
          context: context,
          response: res,
          onsuccess: () {
            User user =
                userProvider.user.copywith(cart: jsonDecode(res.body)['cart']);
            userProvider.setUserfromModel(user);
          });
    } catch (e) {
      showSnackbar(context, e.toString());
    }
  }
}
