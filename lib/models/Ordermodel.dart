import 'dart:convert';

import 'package:amazon_clone_1/models/Product.dart';

class Ordersmodel {
  final String id;
  final List<Product> products;
  final String address;
  final List<int> quantity;
  final int totalprice;
  final String UserID;
  final String orderedAt;
  final int status;

  Ordersmodel(
      {required this.id,
      required this.products,
      required this.address,
      required this.quantity,
      required this.totalprice,
      required this.UserID,
      required this.orderedAt,
      required this.status});

//tomap
  Map<String, dynamic> tomap() {
    return {
      '_id': id,
      'products': products,
      'address': address,
      'quantity': quantity,
      'totalprice': totalprice,
      'UserID': UserID,
      'orderedAt': orderedAt,
      'status': status,
    };
  }

//frommap
  factory Ordersmodel.fromMap(Map<String, dynamic> map) => Ordersmodel(
        id: map['_id'] ?? '',
        products: List<Product>.from(
            map['products']?.map((x) => Product.fromMap(x['product']))),
        address: map['address'] ?? '',
        quantity: List<int>.from(map['products'].map((x) => x['quantity'])),
        totalprice: map['totalprice'] ?? '',
        UserID: map['UserID'] ?? '',
        orderedAt: map['orderedAt'] ?? '',
        status: map['status'].toInt() ?? 0,
      );

//tojson
  String tojson() => jsonEncode(tomap());

//fromjson
  factory Ordersmodel.fromjson(String source) =>
      Ordersmodel.fromMap(jsonDecode(source));
}
