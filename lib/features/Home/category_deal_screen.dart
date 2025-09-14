import 'package:amazon_clone_1/constants/GlobalVariables.dart';
import 'package:amazon_clone_1/features/Home/services/Home_services.dart';
import 'package:amazon_clone_1/features/Product_details/screens/Productdetailscreen.dart';
import 'package:amazon_clone_1/features/admin/screen/loader.dart';
import 'package:amazon_clone_1/models/Product.dart';
import 'package:flutter/material.dart';

class Category_Deal_screen extends StatefulWidget {
  final String category;
  final HomeServices homeServices = HomeServices();

  Category_Deal_screen({
    required this.category,
    super.key,
  });

  @override
  State<Category_Deal_screen> createState() => _Category_Deal_screenState();
}

class _Category_Deal_screenState extends State<Category_Deal_screen> {
  List<Product>? productList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    setState(() {
      fetchCategories();
    });
  }

  fetchCategories() async {
    productList = await HomeServices.fetchCategories(
        context: context, category: widget.category);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBar(
          title: Center(
            child: Text(
              '${widget.category}',
              style: const TextStyle(fontSize: 25),
            ),
          ),
          flexibleSpace: Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            decoration: const BoxDecoration(
              gradient: GlobalVariables.appBarGradient,
            ),
          ),
        ),
      ),
      body: productList == null
          ? const Loader()
          : SingleChildScrollView(
              child: Column(
                children: [
                  GridView.builder(
                      shrinkWrap: true,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 1,
                      ),
                      itemCount: productList!.length,
                      itemBuilder: (context, index) {
                        final product = productList![index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(
                                context, Product_Detail_Screen.routename,
                                arguments: product);
                          },
                          child: Column(
                            children: [
                              DecoratedBox(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.black12,
                                    width: 0.5,
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Image.network(
                                    product.images[0],
                                    fit: BoxFit.fitHeight,
                                    height: 120,
                                  ),
                                ),
                              ),
                              Text(product.name),
                            ],
                          ),
                        );
                      }),
                ],
              ),
            ),
    );
  }
}
