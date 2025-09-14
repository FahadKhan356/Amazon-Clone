import 'package:amazon_clone_1/common/Custom_button.dart';
import 'package:amazon_clone_1/common/stars.dart';
import 'package:amazon_clone_1/constants/GlobalVariables.dart';
import 'package:amazon_clone_1/features/Product_details/services/ProductDetails_services.dart';
import 'package:amazon_clone_1/features/Search/Screens/SearchScreen.dart';
import 'package:amazon_clone_1/models/Product.dart';
import 'package:amazon_clone_1/provider/UserProvider.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

// ignore: camel_case_types
class Product_Detail_Screen extends StatefulWidget {
  static const String routename = '/Products-details';
  final Product product;
  const Product_Detail_Screen({super.key, required this.product});

  @override
  State<Product_Detail_Screen> createState() => _Product_Detail_ScreenState();
}

// ignore: camel_case_types
class _Product_Detail_ScreenState extends State<Product_Detail_Screen> {
  double avgRatings = 0;
  double myRatings = 0;

  @override
  void initState() {
    double totalRatings = 0;
    for (int i = 0; i < widget.product.ratings!.length; i++) {
      totalRatings += widget.product.ratings![i].rating;
      if (widget.product.ratings![i].UserId ==
          Provider.of<UserProvider>(context, listen: false).user.id) {
        myRatings = widget.product.ratings![i].rating;
      }
    }
    if (totalRatings != 0) {
      avgRatings = totalRatings / widget.product.ratings!.length;
    }
    print(avgRatings);
    // TODO: implement initState

    super.initState();
  }

  void navigatetoSearchScreen(String Searchquery) {
    Navigator.pushNamed(context, SearchScreen.routename,
        arguments: Searchquery);
  }

  ProductDetailServices productDetailServices = new ProductDetailServices();
  void addto_cart() {
    productDetailServices.addtocart(context: context, product: widget.product);

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: GlobalVariables.appBarGradient,
            ),
          ),
          title: Row(
            children: [
              Expanded(
                child: Container(
                  height: 40,
                  child: Material(
                    elevation: 1,
                    borderRadius: BorderRadius.circular(7),
                    child: TextFormField(
                      onFieldSubmitted: navigatetoSearchScreen,
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          prefixIcon: Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: InkWell(
                              onTap: () {},
                              child: const Icon(
                                Icons.search,
                                size: 25,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(7),
                              borderSide: BorderSide.none),
                          hintText: 'Search Amazon.in',
                          hintStyle: const TextStyle(fontSize: 20)),
                    ),
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Icon(Icons.mic, size: 30, color: Colors.black),
              )
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${widget.product.id}',
                    style: const TextStyle(fontSize: 23),
                  ),
                  Stars(ratings: avgRatings),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              child: Text(
                '${widget.product.name}',
                style: TextStyle(fontSize: 23),
              ),
            ),
            CarouselSlider(
                items: widget.product.images
                    .map((e) => Builder(
                        builder: (BuildContext context) => Image.network(
                              e,
                              fit: BoxFit.cover,
                              height: 200,
                            )))
                    .toList(),
                options: CarouselOptions(viewportFraction: 1)),
            Container(
              color: Colors.black12,
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: RichText(
                  text: TextSpan(children: [
                const TextSpan(
                    text: 'Deal Price:',
                    style: TextStyle(
                        fontSize: 21,
                        fontWeight: FontWeight.bold,
                        color: Colors.black)),
                TextSpan(
                    text: ' \$${widget.product.price}',
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w500,
                        color: Colors.red)),
              ])),
            ),
            Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  '${widget.product.description}',
                  style: TextStyle(color: Colors.black, fontSize: 22),
                  maxLines: 10,
                )),
            Container(
              color: Colors.black12,
              height: 10,
            ),
            Padding(
              padding: EdgeInsets.all(8),
              child: Custom_button(text: 'Buy Now', onpress: () {}),
            ),
            SizedBox(
              height: 5,
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: Custom_button(
                text: 'Add to cart',
                onpress: () => addto_cart(),
                btcolor: Colors.yellow,
                txcolor: Colors.black,
              ),
            ),
            Container(
              height: 10,
              color: Colors.black12,
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Rate this Product',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 25,
                    fontWeight: FontWeight.bold),
              ),
            ),
            RatingBar.builder(
              itemBuilder: ((context, _) => const Icon(
                    Icons.star,
                    size: 20,
                    color: GlobalVariables.secondaryColor,
                  )),
              onRatingUpdate: (rating) {
                productDetailServices.rateProduct(
                    context: context,
                    productid: widget.product,
                    rating: rating);
              },
              initialRating: myRatings,
              allowHalfRating: true,
              minRating: 1,
              direction: Axis.horizontal,
            ),
          ],
        ),
      ),
    );
  }
}
