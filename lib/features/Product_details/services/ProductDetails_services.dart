import 'dart:convert';

import 'package:amazon_clone_1/models/Product.dart';
import 'package:amazon_clone_1/models/usermodel.dart';
import 'package:amazon_clone_1/provider/UserProvider.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../../../constants/ErrorHandling.dart';
import '../../../constants/Utils.dart';
import '../../auth/services/auth_services.dart';

class ProductDetailServices {
  void rateProduct({
    required BuildContext context,
    required productid,
    required double rating,
  }) async {
    try {
      var userProvider = Provider.of<UserProvider>(context, listen: false);
      http.Response res = await http.post(
          // Uri.parse('http://192.168.10.6:5000/api/rate-product'),
          Uri.parse(ApiConfig.getApiUrl(endpoint: '/api/rate-product')),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token': userProvider.user.token,
          },
          body: jsonEncode({'id': productid.id, 'rating': rating}));
      ErrorHandling(
          context: context,
          response: res,
          onsuccess: () {
            showSnackbar(context, '${rating} Rated');
            Navigator.pop(context);
          });
    } catch (e) {
      showSnackbar(context, e.toString());
    }
  }

  void addtocart(
      {required BuildContext context, required Product product}) async {
    var userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      http.Response res = await http.post(
        Uri.parse(ApiConfig.getApiUrl(endpoint: '/api/add-to-cart')),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
        body: jsonEncode({'id': product.id}),
      );
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

  // void addtocart(
  //   BuildContext context,
  //   Product product,
  // ) async {
  //   var userProvider = Provider.of<UserProvider>(context, listen: false);
  //   try {
  //     http.Response res = await http.post(
  //         Uri.parse(ApiConfig.getApiUrl(endpoint: '/api/add-to-cart')),
  //         headers: {
  //           'Content-Type': 'application/json; charset=UTF-8',
  //           'x-auth-token': userProvider.user.token,
  //         },
  //         body: jsonEncode({'id': product.id}));

  //     ErrorHandling(
  //         context: context,
  //         response: res,
  //         onsuccess: () {
  //           User user =
  //               userProvider.user.copywith(cart: jsonDecode(res.body)['cart']);
  //           userProvider.setUserbymodel(user);
  //         });
  //   } catch (e) {
  //     showSnackbar(context, e.toString());
  //   }
  // }
}
