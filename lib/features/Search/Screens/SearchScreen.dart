import 'package:amazon_clone_1/features/Product_details/screens/Productdetailscreen.dart';
import 'package:amazon_clone_1/features/Search/services/Searchservices.dart';
import 'package:amazon_clone_1/features/Search/widget/Search_products.dart';
import 'package:amazon_clone_1/features/admin/screen/loader.dart';
import 'package:flutter/material.dart';

import '../../../models/Product.dart';

class SearchScreen extends StatefulWidget {
  final String Searchquery;
  static const String routename = '/search-screen';
  SearchScreen({super.key, required this.Searchquery});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final SearchServices searchSearvice = SearchServices();
  List<Product>? products;
  void fetchSearchedproducts() async {
    products = await SearchServices.searchedProduct(
        context: context, searchquery: widget.Searchquery);
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchSearchedproducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: products == null
          ? const Loader()
          : SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height,
                    child: ListView.builder(
                        itemCount: products!.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(
                                    context, Product_Detail_Screen.routename,
                                    arguments: products![index]);
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child:
                                    Searchproducts(product: products![index]),
                              ));
                        }),
                  )
                ],
              ),
            ),
    );
  }
}
