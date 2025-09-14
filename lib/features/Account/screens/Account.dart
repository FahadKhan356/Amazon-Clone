import 'package:amazon_clone_1/constants/GlobalVariables.dart';
import 'package:amazon_clone_1/features/Account/widgets/BelowAppBar.dart';
import 'package:amazon_clone_1/features/Account/widgets/TopButtons.dart';
import 'package:amazon_clone_1/features/Account/widgets/Your_order.dart';
import 'package:amazon_clone_1/features/Account/widgets/order.dart';
import 'package:flutter/material.dart';

class Account extends StatelessWidget {
  const Account({super.key});

  // AccountServices accountServices = AccountServices();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          child: AppBar(
            flexibleSpace: Container(
              decoration: const BoxDecoration(
                gradient: GlobalVariables.appBarGradient,
              ),
            ),
            title: Padding(
              padding: const EdgeInsets.only(
                top: 30,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    alignment: Alignment.topLeft,
                    child: Image.asset(
                      'lib/assets/images/amazon_in.png',
                      width: 150,
                    ),
                  ),
                  Container(
                    child: const Row(children: [
                      Icon(
                        Icons.notifications,
                        size: 25,
                      ),
                      Icon(
                        Icons.search,
                        size: 25,
                      ),
                    ]),
                  ),
                ],
              ),
            ),
          ),
          preferredSize: Size.fromHeight(70)),
      body: const Column(
        children: [
          Belowbottombar(),
          SizedBox(height: 10),
          TopButtons(),
          SizedBox(
            height: 20,
          ),
          YourOrders(),
          SizedBox(
            height: 10,
          ),
          Orders(),
        ],
      ),
    );
  }
}
