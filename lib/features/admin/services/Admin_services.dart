import 'dart:convert';
import 'dart:io';

import 'package:amazon_clone_1/constants/ErrorHandling.dart';
import 'package:amazon_clone_1/constants/Utils.dart';
import 'package:amazon_clone_1/features/auth/services/auth_services.dart';
import 'package:amazon_clone_1/models/Ordermodel.dart';
import 'package:amazon_clone_1/models/Product.dart';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../../../provider/UserProvider.dart';
import '../widget/Sales.dart';

class AdminServices {
  void SellProducts({
    required BuildContext context,
    required String name,
    required String description,
    required double price,
    required double quantity,
    required String category,
    required List<File> images,
  }) async {
    try {
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      final cloudinary = CloudinaryPublic('dweri3kjb', 'pi4q3yfx');
      List<String> imagesUrl = [];
      for (int i = 0; i < images.length; i++) {
        CloudinaryResponse res = await cloudinary
            .uploadFile(CloudinaryFile.fromFile(images[i].path, folder: name));
        imagesUrl.add(res.secureUrl);
      }
      Product product = Product(
        name: name,
        description: description,
        quantity: quantity,
        images: imagesUrl,
        category: category,
        price: price,
      );

      http.Response res = await http.post(
        //Uri.parse('http://192.168.10.6:5000/admin/add-products'),
        Uri.parse(ApiConfig.getApiUrl(endpoint: '/admin/add-products')),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
        body: product.toJson(),
      );
      ErrorHandling(
          context: context,
          response: res,
          onsuccess: () {
            showSnackbar(context, 'Product Added Successfully!');
            Navigator.pop(context);
          });
    } catch (e) {
      showSnackbar(context, e.toString());
    }
  }

  Future<List<Product>> fetchAllProducts(BuildContext context) async {
    List<Product> products = [];
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      http.Response res = await http.get(
          //Uri.parse('http://192.168.10.6:5000/admin/get-products'),
          Uri.parse(ApiConfig.getApiUrl(endpoint: '/admin/get-products')),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token': userProvider.user.token,
          });

      ErrorHandling(
          context: context,
          response: res,
          onsuccess: () {
            for (int i = 0; i < jsonEncode(jsonDecode(res.body)).length; i++) {
              products
                  .add(Product.fromJson(jsonEncode(jsonDecode(res.body)[i])));
            }
          });
    } catch (e) {
      showSnackbar(context, e.toString());
    }
    return products;
  }

//delete products
  void deleteProduct(
      {required Product product,
      required BuildContext context,
      required VoidCallback onSuccess}) async {
    try {
      final userProvider = Provider.of<UserProvider>(context, listen: false);

      http.Response res = await http.post(
        // Uri.parse('http://192.168.10.6:5000/admin/delete-products'),
        Uri.parse(ApiConfig.getApiUrl(endpoint: '/admin/delete-products')),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token
        },
        body: jsonEncode({'id': product.id}),
      );

      ErrorHandling(context: context, response: res, onsuccess: onSuccess);
    } catch (e) {
      showSnackbar(
        context,
        e.toString(),
      );
    }
  }

  Future<List<Ordersmodel>> fetchorders(BuildContext context) async {
    List<Ordersmodel> orders = [];
    try {
      var userProvider = Provider.of<UserProvider>(context, listen: false);
      http.Response res = await http.get(
        Uri.parse(ApiConfig.getApiUrl(endpoint: '/admin/get-orders')),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token
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

  void changeOrderStatus({
    required BuildContext context,
    required int status,
    required Ordersmodel order,
    required VoidCallback onsuccess,
  }) async {
    try {
      var userProvider = Provider.of<UserProvider>(context, listen: false);
      http.Response res = await http.post(
        Uri.parse(ApiConfig.getApiUrl(endpoint: "/admin/changeOrderStatus")),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token
        },
        body: jsonEncode({
          'id': order.id,
          'status': status,
        }),
      );

      ErrorHandling(context: context, response: res, onsuccess: onsuccess);
    } catch (e) {
      showSnackbar(context, e.toString());
    }
  }

  Future<Map<String, dynamic>> getearnings(context) async {
    int totalearnings = 0;
    List<Sales> sales = [];
    try {
      var userProvider = Provider.of<UserProvider>(context, listen: false);
      http.Response res = await http.get(
          Uri.parse(ApiConfig.getApiUrl(endpoint: '/admin/analytics')),
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token': userProvider.user.token
          });
      ErrorHandling(
          context: context,
          response: res,
          onsuccess: () {
            var response = jsonDecode(res.body);
            totalearnings = response['totalearnings'];
            sales = [
              Sales('Mobiles', response['MobilesEarnings']),
              Sales('Essentials', response['EssentialsEarnings']),
              Sales('Appliances', response['AppliancesEarnings']),
              Sales('Book', response['BooksEarnings']),
              Sales('Fashion', response['FashionEarnings']),
            ];
          });
    } catch (e) {
      showSnackbar(context, e.toString());
    }
    return {
      'totalearnings': totalearnings,
      'sales': sales,
    };
  }
}
