import 'package:amazon_clone_1/constants/GlobalVariables.dart';
import 'package:amazon_clone_1/provider/UserProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Belowbottombar extends StatelessWidget {
  const Belowbottombar({super.key});

  @override
  Widget build(BuildContext context) {
    String name = Provider.of<UserProvider>(context).user.name;
    return Container(
      padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
      decoration: BoxDecoration(
        gradient: GlobalVariables.appBarGradient,
      ),
      child: Row(
        children: [
          RichText(
            text: TextSpan(
                text: 'Hello, ',
                style: TextStyle(fontSize: 30, color: Colors.black),
                children: [
                  TextSpan(
                    text: name,
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
                  ),
                ]),
          ),
        ],
      ),
    );
  }
}
