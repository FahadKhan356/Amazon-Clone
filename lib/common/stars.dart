import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class Stars extends StatelessWidget {
  final double ratings;
  const Stars({super.key, required this.ratings});

  @override
  Widget build(BuildContext context) {
    return RatingBarIndicator(
      itemBuilder: (context, index) => const Icon(
        Icons.star_rate_sharp,
        color: Colors.amber,
      ),
      itemCount: 5,
      rating: ratings,
      itemSize: 25,
    );
  }
}
