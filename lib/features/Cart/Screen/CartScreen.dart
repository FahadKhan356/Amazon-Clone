import 'package:amazon_clone_1/common/Custom_button.dart';
import 'package:amazon_clone_1/constants/GlobalVariables.dart';
import 'package:amazon_clone_1/features/Address/screens/Addressscreen.dart';
import 'package:amazon_clone_1/features/Cart/widgets/CartProducts.dart';
import 'package:amazon_clone_1/features/Home/Widgets/AddressBox.dart';
import 'package:amazon_clone_1/provider/UserProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Cartscreen extends StatefulWidget {
  const Cartscreen({super.key});

  @override
  State<Cartscreen> createState() => _CartscreenState();
}

class _CartscreenState extends State<Cartscreen> {
  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserProvider>().user;
    int sum = 0;
    user.cart
        .map((e) => sum += (e['quantity'] * e['product']['price'] as int))
        .toList();

    void navigatetoAddressscreen(int sum) {
      Navigator.pushNamed(context, Addressscreen.routename, arguments: sum);
    }

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          flexibleSpace: Container(
            decoration:
                const BoxDecoration(gradient: GlobalVariables.appBarGradient),
          ),
          title: Row(
            children: [
              Expanded(
                child: Container(
                  height: 42,
                  child: Material(
                    elevation: 0,
                    borderRadius: BorderRadius.circular(7),
                    child: TextFormField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(7),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        hintText: 'Search amazon in.',
                        hintStyle: TextStyle(fontSize: 21),
                        prefixIcon: InkWell(
                          onTap: () {},
                          child: const Padding(
                            padding: EdgeInsets.only(left: 7.0),
                            child: Icon(
                              Icons.search,
                              color: Colors.black,
                              size: 24,
                            ),
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(7),
                            borderSide:
                                const BorderSide(color: Colors.black38)),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Container(
                child: const Icon(
                  Icons.mic,
                  color: Colors.white,
                  size: 25,
                ),
              )
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const AddressBox(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Row(
                children: [
                  const Text(
                    'Subtotal ',
                    style: TextStyle(
                      fontSize: 26,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    '\$$sum',
                    style: const TextStyle(
                      fontSize: 26,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Custom_button(
                text: 'Procees to buy (1 item)',
                onpress: () => navigatetoAddressscreen(sum),
                txcolor: Colors.black,
                btcolor: Colors.yellow[600],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
                height: 1,
                child: Container(
                  height: 1,
                  color: Colors.black,
                )),
            const SizedBox(
              height: 20,
            ),
            ListView.builder(
              shrinkWrap: true,
              itemCount: user.cart.length,
              itemBuilder: (BuildContext context, index) =>
                  Cartproducts(index: index),
            )
          ],
        ),
      ),
    );
  }
}
