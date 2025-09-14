import 'package:flutter/material.dart';

class Single_Product extends StatelessWidget {
  final String image;
  Single_Product({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      clipBehavior: Clip.antiAlias,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        width: 320,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black, width: 1.0),
          borderRadius: BorderRadius.circular(15),
          image:
              DecorationImage(image: NetworkImage(image), fit: BoxFit.contain),
        ),
      ),
    );
  }
}
