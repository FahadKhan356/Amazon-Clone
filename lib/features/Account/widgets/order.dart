import 'package:amazon_clone_1/features/Account/AccountServices/AccountServices.dart';
import 'package:amazon_clone_1/features/Account/widgets/single_product.dart';
import 'package:amazon_clone_1/features/OrderDetails/screens/Orderdetails.dart';
import 'package:amazon_clone_1/features/admin/screen/loader.dart';
import 'package:amazon_clone_1/models/Ordermodel.dart';
import 'package:flutter/material.dart';

class Orders extends StatefulWidget {
  const Orders({super.key});

  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  // List images = [
  //   'https://images.unsplash.com/photo-1519389950473-47ba0277781c?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8N3x8dGVjaG5vbG9neXxlbnwwfHwwfHx8MA%3D%3D',
  //   'https://images.unsplash.com/photo-1519389950473-47ba0277781c?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8N3x8dGVjaG5vbG9neXxlbnwwfHwwfHx8MA%3D%3D',
  //   'https://images.unsplash.com/photo-1519389950473-47ba0277781c?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8N3x8dGVjaG5vbG9neXxlbnwwfHwwfHx8MA%3D%3D',
  //   'https://images.unsplash.com/photo-1519389950473-47ba0277781c?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8N3x8dGVjaG5vbG9neXxlbnwwfHwwfHx8MA%3D%3D',
  // ];

  AccountServices accountServices = AccountServices();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchorders();
  }

  List<Ordersmodel>? allorders;
  void fetchorders() async {
    allorders = await accountServices.fetchOrder(context: context);
    setState(() {});
    print(allorders);
  }

  @override
  Widget build(BuildContext context) {
    return allorders == null
        ? const Loader()
        : Column(
            children: [
              Container(
                padding: const EdgeInsets.only(left: 10, right: 10),
                height: 200,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: ListView.builder(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10), // Add horizontal padding
                    scrollDirection: Axis.horizontal,
                    itemCount: allorders!.length,
                    itemBuilder: ((context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, Ordersdetails.routname,
                                arguments: allorders![index]);
                          },
                          child: Single_Product(
                              image: allorders![index].products[0].images[0]),
                        ),
                      );
                    })),
              ),
            ],
          );
  }
}
