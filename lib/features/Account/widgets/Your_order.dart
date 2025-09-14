import 'package:amazon_clone_1/constants/GlobalVariables.dart';
import 'package:flutter/material.dart';

class YourOrders extends StatelessWidget {
  const YourOrders({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            child: Text(
              'Your Order',
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 22),
            ),
          ),
          Container(
            child: Text(
              'See all',
              style: TextStyle(
                  fontSize: 20, color: GlobalVariables.selectedNavBarColor),
            ),
          ),
        ],
      ),
    );
  }
}
