import 'dart:convert';

class Rating {
  String UserId;
  double rating;

  Rating({required this.UserId, required this.rating});

//toMap
  Map<String, dynamic> toMap() {
    return {
      'UserId': UserId,
      'rating': rating,
    };
  }
//fromMap

  factory Rating.fromMap(Map<String, dynamic> map) => Rating(
      UserId: map['UserId'] ?? '', rating: map['rating']?.toDouble() ?? 0.0);

//tojson
  String toJson() => jsonEncode(toMap());

//fromjson
  factory Rating.fromjson(String source) => Rating.fromMap(jsonDecode(source));
}
