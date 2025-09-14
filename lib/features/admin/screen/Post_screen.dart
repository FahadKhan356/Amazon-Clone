import 'package:amazon_clone_1/features/Account/widgets/single_product.dart';
import 'package:amazon_clone_1/features/admin/screen/add_product_screen.dart';
import 'package:amazon_clone_1/features/admin/screen/loader.dart';
import 'package:amazon_clone_1/features/admin/services/Admin_services.dart';
import 'package:amazon_clone_1/models/Product.dart';
import 'package:flutter/material.dart';

class Post_screen extends StatefulWidget {
  const Post_screen({super.key});

  @override
  State<Post_screen> createState() => _Post_screenState();
}

class _Post_screenState extends State<Post_screen> {
  void navigateToAdd_product_screen() {
    Navigator.pushNamed(context, Add_Products_Screen.routname);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchAllProducts2();
  }

  AdminServices adminServices = AdminServices();
  List<Product> products = [];

  fetchAllProducts2() async {
    products = await adminServices.fetchAllProducts(context);
    setState(() {});
  }

  deleteProduct(Product product, int index) {
    adminServices.deleteProduct(
        product: product,
        context: context,
        onSuccess: () {
          products.removeAt(index);
          setState(() {});
        });
  }

  @override
  Widget build(BuildContext context) {
    return products.isEmpty
        ? Loader()
        : Scaffold(
            body: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                itemCount: products.length,
                itemBuilder: ((context, index) {
                  final Productdata = products[index];
                  return Column(
                    children: [
                      SizedBox(
                        height: 200,
                        child: Single_Product(image: Productdata.images[0]),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                Productdata.name,
                                style: const TextStyle(fontSize: 25),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                deleteProduct(Productdata, index);
                              },
                              child: const Icon(
                                Icons.delete_outline_outlined,
                                size: 30,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                })),
            floatingActionButton: FloatingActionButton(
              tooltip: 'Add Products',
              onPressed: () {
                navigateToAdd_product_screen();
              },
              child: const Icon(Icons.add_outlined),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
          );
  }
}
