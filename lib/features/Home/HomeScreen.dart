import 'package:amazon_clone_1/constants/GlobalVariables.dart';
import 'package:amazon_clone_1/features/Home/Widgets/AddressBox.dart';
import 'package:amazon_clone_1/features/Home/Widgets/Category_list.dart';
import 'package:amazon_clone_1/features/Home/Widgets/Crousel_imgaes.dart';
import 'package:amazon_clone_1/features/Home/Widgets/Deal_of_the_day.dart';
import 'package:amazon_clone_1/features/Home/services/Home_services.dart';
import 'package:amazon_clone_1/features/Search/Screens/SearchScreen.dart';
import 'package:amazon_clone_1/models/Product.dart';
import 'package:flutter/material.dart';

import '../admin/screen/loader.dart';

class HomeScreen extends StatefulWidget {
  static const String routename = '/home-screen';

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeServices homeServices = HomeServices();
  Product? product;
  void fetchDealOfTheDay() async {
    product = await homeServices.fetchDealOfTheDay(context);
    setState(() {});
  }

  @override
  void initState() {
    fetchDealOfTheDay();
    super.initState();
  }

  void navigatetoSearchScreen(String query) {
    Navigator.pushNamed(context, SearchScreen.routename, arguments: query);
  }

  @override
  Widget build(BuildContext context) {
    //final user = Provider.of<UserProvider>(context).user;

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
                    height: 42,
                    margin: const EdgeInsets.only(left: 15),
                    child: Material(
                      elevation: 0,
                      borderRadius: BorderRadius.circular(7),
                      child: TextFormField(
                        onFieldSubmitted: navigatetoSearchScreen,
                        decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(7),
                              borderSide: BorderSide.none,
                            ),
                            prefixIcon: InkWell(
                              onTap: () {},
                              child: const Padding(
                                padding: EdgeInsets.only(left: 7),
                                child: Icon(
                                  Icons.search,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(7),
                              borderSide: const BorderSide(
                                  color: Colors.black38, width: 1),
                            ),
                            hintText: 'Search Amazon.in',
                            hintStyle: const TextStyle(
                                fontSize: 17, fontWeight: FontWeight.w500)),
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 42,
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  child: const Icon(Icons.mic),
                ),
              ],
            ),
          ),
        ),
        body: product == null
            ? const Loader()
            : product!.name.isEmpty
                ? const SizedBox(
                    child: Text('sdsdsdsdsds'),
                  )
                : SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                      children: [
                        const AddressBox(),
                        const SizedBox(
                          height: 10,
                        ),
                        const CategoryList(),
                        const SizedBox(
                          height: 10,
                        ),
                        const CrouselImages(),
                        const SizedBox(
                          height: 10,
                        ),
                        Deal_of_the_day(
                          product: product,
                        ),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: product!.images
                                .map(
                                  (e) => Image.network(
                                    //"https://images.unsplash.com/photo-1525966222134-fcfa99b8ae77?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NHx8c2hvZXN8ZW58MHx8MHx8fDA%3D",

                                    e,
                                    fit: BoxFit.contain,
                                    height: 150,
                                    width: 150,
                                  ),
                                )
                                .toList(),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(vertical: 18)
                              .copyWith(left: 10),
                          alignment: Alignment.topLeft,
                          child: Text(
                            "See All Deals",
                            style: TextStyle(
                                color: Colors.cyan[800], fontSize: 20),
                          ),
                        ),
                      ],
                    ),
                  ));
  }
}
