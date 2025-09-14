import 'package:amazon_clone_1/features/Account/widgets/single_product.dart';
import 'package:amazon_clone_1/features/OrderDetails/screens/Orderdetails.dart';
import 'package:amazon_clone_1/features/admin/screen/loader.dart';
import 'package:amazon_clone_1/features/admin/services/Admin_services.dart';
import 'package:amazon_clone_1/models/Ordermodel.dart';
import 'package:flutter/material.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  AdminServices adminServices = AdminServices();
  List<Ordersmodel>? orders;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchorders();
  }

  fetchorders() async {
    orders = await adminServices.fetchorders(context);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return orders == null
        ? Loader()
        : GridView.builder(
            itemCount: orders!.length,
            gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
            itemBuilder: (context, index) {
              final orderData = orders![index];
              return GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, Ordersdetails.routname,
                      arguments: orderData);
                },
                child: SizedBox(
                  height: 140,
                  child: Single_Product(
                    image: orderData.products[0].images[0],
                  ),
                ),
              );
            });
  }
}
