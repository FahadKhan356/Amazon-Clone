import 'package:amazon_clone_1/constants/GlobalVariables.dart';
import 'package:amazon_clone_1/features/admin/screen/Analytics.dart';
import 'package:amazon_clone_1/features/admin/screen/ordersScreen.dart';
import 'package:flutter/material.dart';

import 'Post_screen.dart';

class Admin_Screen extends StatefulWidget {
  const Admin_Screen({super.key});

  @override
  State<Admin_Screen> createState() => _Admin_ScreenState();
}

class _Admin_ScreenState extends State<Admin_Screen> {
  int currentIndex = 0;

  BottomNavigationBarItem bottonItems({
    required pageindex,
    required IconData icon,
  }) {
    return BottomNavigationBarItem(
      icon: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
            border: Border(
                top: BorderSide(
          width: 5,
          color: pageindex == currentIndex
              ? GlobalVariables.selectedNavBarColor
              : GlobalVariables.unselectedNavBarColor,
        ))),
        child: Icon(
          icon,
          color: pageindex == currentIndex
              ? GlobalVariables.selectedNavBarColor
              : GlobalVariables.unselectedNavBarColor,
        ),
      ),
      label: '',
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> screens = [
      const Post_screen(),
      const OrderScreen(),
      const Analytics(),
    ];

    List<BottomNavigationBarItem> itemslist = [
      bottonItems(pageindex: 0, icon: Icons.home_outlined),
      bottonItems(pageindex: 1, icon: Icons.analytics_outlined),
      bottonItems(pageindex: 2, icon: Icons.all_inbox_outlined),
    ];

    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: itemslist,
        iconSize: 35,
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
      ),
      appBar: PreferredSize(
          child: AppBar(
            flexibleSpace: Container(
              decoration:
                  BoxDecoration(gradient: GlobalVariables.appBarGradient),
              child: Padding(
                padding: const EdgeInsets.only(top: 30.0, left: 10, right: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset(
                      'lib/assets/images/amazon_in.png',
                      width: 150,
                    ),
                    Text(
                      'Admin',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 25),
                    )
                  ],
                ),
              ),
            ),
          ),
          preferredSize: Size.fromHeight(50)),
      body: Column(
        children: [
          Expanded(child: screens.elementAt(currentIndex)),
        ],
      ),
    );
  }
}
