import 'package:amazon_clone_1/common/stars.dart';
import 'package:amazon_clone_1/models/Product.dart';
import 'package:flutter/material.dart';

class Searchproducts extends StatelessWidget {
  final Product product;

  const Searchproducts({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    double totalrating = 0;
    for (int i = 0; i < product.ratings!.length; i++) {
      totalrating += product.ratings![i].rating;
    }
    double avgRating = 0;
    if (totalrating != 0) {
      avgRating = totalrating / product.ratings!.length;
    }

    return Container(
      decoration: const BoxDecoration(
          border: Border(top: BorderSide(color: Colors.black12, width: 10))),
      child: Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: Column(
          children: [
            Container(
              height: 160,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  children: [
                    Image.network(
                      product.images[0],
                      width: 150,
                      height: 150,
                      fit: BoxFit.contain,
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            product.name,
                            style: const TextStyle(
                              fontSize: 23,
                            ),
                            maxLines: 2,
                          ),
                          const SizedBox(height: 5),
                          //Ratings
                          Stars(ratings: avgRating),
                          const SizedBox(height: 5),
                          Text(
                            '\$${product.price}',
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 5),
                          const Text(
                            'Eligible for Free Shipping',
                            style: TextStyle(
                              fontSize: 24,
                            ),
                          ),
                          const SizedBox(height: 5),
                          const Text(
                            'In Stock',
                            style: TextStyle(fontSize: 24, color: Colors.teal),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
