import 'dart:convert';

class User {
  final String id;
  final String name;
  final String email;
  final String password;
  final String address;
  final String type;
  final String token;
  final List<dynamic> cart;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.password,
    required this.address,
    required this.type,
    required this.token,
    required this.cart,
  });

//creating tomap method to make map type to give tojson method to send object to backen as userobject in json format
  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      'name': name,
      'email': email,
      'password': password,
      'address': address,
      'type': type,
      'token': token,
      //'cart': cart,
    };
  }

//tojson
  String toJson() => json.encode(toMap());

//creating frommap to store or mirror data in user model from beckend json format to map so we can use the data
  factory User.fromMap(Map<String, dynamic> map) => User(
      id: map['_id'] ?? "",
      name: map['name'] ?? "",
      email: map['email'] ?? "",
      password: map['pasword'] ?? "",
      address: map['address'] ?? "",
      type: map['type'] ?? "",
      token: map['token'] ?? "",
      cart: List<Map<String, dynamic>>.from(
          map['cart'].map((x) => Map<String, dynamic>.from(x)))

      // cart: List<Map<String, dynamic>>.from(
      //     map['cart']?.map((x) => Map<String, dynamic>.from(x))),
      );

//fromjson
  factory User.fromjson(String source) => User.fromMap(jsonDecode(source));

  User copywith({
    final String? id,
    final String? name,
    final String? email,
    final String? password,
    final String? address,
    final String? type,
    final String? token,
    final List<dynamic>? cart,
  }) {
    return User(
        id: id ?? this.id,
        name: name ?? this.name,
        email: email ?? this.email,
        password: password ?? this.password,
        address: address ?? this.address,
        type: type ?? this.type,
        token: token ?? this.token,
        cart: cart ?? this.cart);
  }
}
