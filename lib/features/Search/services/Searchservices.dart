import 'dart:convert';

import 'package:amazon_clone_1/constants/Utils.dart';
import 'package:amazon_clone_1/features/auth/services/auth_services.dart';
import 'package:amazon_clone_1/models/Product.dart';
import 'package:amazon_clone_1/provider/UserProvider.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../../../constants/ErrorHandling.dart';

class SearchServices {
  static Future<List<Product>> searchedProduct(
      {required BuildContext context, required String searchquery}) async {
    List<Product> products = [];
    try {
      var userProvider = Provider.of<UserProvider>(context, listen: false);
      http.Response res = await http.get(
          //Uri.parse('http://192.168.10.6:5000/api/products/search/$searchquery'),
          Uri.parse(ApiConfig.getApiUrl(
              endpoint: '/api/products/search/$searchquery')),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token': userProvider.user.token
          });
      ErrorHandling(
          context: context,
          response: res,
          onsuccess: () {
            for (int i = 0; i < jsonDecode(res.body).length; i++) {
              products
                  .add(Product.fromJson(jsonEncode(jsonDecode(res.body)[i])));
            }
          });
    } catch (e) {
      showSnackbar(context, e.toString());
    }
    return products;
  }
}
