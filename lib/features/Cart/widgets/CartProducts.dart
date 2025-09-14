import 'package:amazon_clone_1/features/Cart/Cartservices/CartServices.dart';
import 'package:amazon_clone_1/features/Product_details/services/ProductDetails_services.dart';
import 'package:amazon_clone_1/provider/UserProvider.dart';
import 'package:flutter/material.dart';
import 'package:amazon_clone_1/models/Product.dart';
import 'package:provider/provider.dart';

class Cartproducts extends StatefulWidget {
  final int index;

  const Cartproducts({
    super.key,
    required this.index,
  });

  @override
  State<Cartproducts> createState() => _CartproductsState();
}

class _CartproductsState extends State<Cartproducts> {
  ProductDetailServices productDetailServices = ProductDetailServices();
  Cartservice cartservice = Cartservice();

  void addtocart(Product product) {
    productDetailServices.addtocart(context: context, product: product);
  }

  void deletefromcart(Product product) async {
    cartservice.removefromcart(product, context);
  }

  @override
  Widget build(BuildContext context) {
    // double totalrating = 0;
    // for (int i = 0; i < product.ratings!.length; i++) {
    //   totalrating += product.ratings![i].rating;
    // }
    // double avgRating = 0;
    // if (totalrating != 0) {
    //   avgRating = totalrating / product.ratings!.length;
    // }

    final CartProduct =
        Provider.of<UserProvider>(context).user.cart[widget.index];
    final product = Product.fromMap(CartProduct['product']);
    final quantity = CartProduct['quantity'];
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
            ),
            Container(
              //color: Colors.red,
              margin: EdgeInsets.all(8),
              child: Row(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black12, width: 1.5),
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.black12,
                    ),
                    child: Row(
                      children: [
                        InkWell(
                          onTap: () => deletefromcart(product),
                          child: Container(
                            height: 32,
                            width: 34,
                            child: const Center(
                                child: Icon(
                              Icons.remove,
                              size: 30,
                            )),
                          ),
                        ),
                        DecoratedBox(
                          decoration: BoxDecoration(
                            border:
                                Border.all(color: Colors.black12, width: 1.5),
                          ),
                          child: Container(
                            color: Colors.white,
                            height: 32,
                            width: 35,
                            child: Center(
                              child: Text(
                                '$quantity',
                                style: const TextStyle(fontSize: 20),
                              ),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () => addtocart(product),
                          child: Container(
                            height: 32,
                            width: 34,
                            child: const Center(
                                child: Icon(
                              Icons.add,
                              size: 30,
                            )),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
