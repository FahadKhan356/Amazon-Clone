import 'dart:convert';

import 'package:amazon_clone_1/constants/Utils.dart';
import 'package:amazon_clone_1/features/auth/services/auth_services.dart';
import 'package:amazon_clone_1/models/Product.dart';
import 'package:amazon_clone_1/provider/UserProvider.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../../../constants/ErrorHandling.dart';

class HomeServices {
  static Future<List<Product>> fetchCategories(
      {required BuildContext context, required String category}) async {
    List<Product> products = [];
    try {
      var userProvider = Provider.of<UserProvider>(context, listen: false);
      http.Response res = await http.get(
          //Uri.parse('http://192.168.10.6:5000/api/pro-categories?category=$category'),
          Uri.parse(ApiConfig.getApiUrl(
              endpoint: '/api/pro-categories?category=$category')),
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

  Future<Product> fetchDealOfTheDay(BuildContext context) async {
    Product product = Product(
      name: '',
      description: '',
      quantity: 0,
      images: [],
      category: '',
      price: 0,
    );

    try {
      var userProvider = Provider.of<UserProvider>(context, listen: false);
      http.Response res = await http.get(
          Uri.parse(
            ApiConfig.getApiUrl(endpoint: '/api/fetch_deal-of-the-day'),
          ),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token': userProvider.user.token
          });
      ErrorHandling(
          context: context,
          response: res,
          onsuccess: () {
            product = Product.fromJson(res.body);
          });
    } catch (e) {
      showSnackbar(context, e.toString());
    }
    return product;
  }
}
