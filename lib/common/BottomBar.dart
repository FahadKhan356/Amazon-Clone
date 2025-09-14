import 'package:amazon_clone_1/constants/GlobalVariables.dart';
import 'package:amazon_clone_1/features/Account/screens/Account.dart';
import 'package:amazon_clone_1/features/Cart/Screen/CartScreen.dart';
import 'package:amazon_clone_1/features/Home/HomeScreen.dart';
import 'package:amazon_clone_1/provider/UserProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:badges/badges.dart' as badges;

class BottomBar extends StatefulWidget {
  static const String routename = "/actual-home";

  const BottomBar({Key? key}) : super(key: key);

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  //int currentnavindex = 0;

  int _page = 0;
  double borderwidth = 1;

  // List<int> badgeData = [0, 0, 2];
  var pages = [
    const HomeScreen(),
    const Account(),
    const Cartscreen(),
  ];
  void updatepage(pageindex) {
    setState(() {
      _page = pageindex;
    });
  }

  @override
  Widget build(BuildContext context) {
    int cartLength = context.watch<UserProvider>().user.cart.length;

    //Provider.of<UserProvider>(context, listen: false).user.cart.length;
    // var cartlength = Provider.of<UserProvider>(context).user.cart.length;
    //badgeData = [0, 0, cartlength];
    // var cartlength = Provider.of<UserProvider>(context).user.cart.length;
    // void updatebadge() {
    //   setState(() {
    //     badgeData;
    //   });
    // }

    //badgeData = [0, 0, cartlength];
    // List<BottomNavigationBarItem> navigationbar = [
    //   bottomNavigationBarItemWidget(
    //       pageIndex: 0, icon: Icons.home_outlined, badge: false),
    //   bottomNavigationBarItemWidget(
    //       pageIndex: 1, icon: Icons.person_2_outlined, badge: false),
    //   bottomNavigationBarItemWidget(
    //       pageIndex: 2, icon: Icons.shopping_cart_outlined, badge: true),
    // ];
    return SafeArea(
      child: Scaffold(
        body: pages[_page],
        bottomNavigationBar: BottomNavigationBar(
            iconSize: 39,
            elevation: 0,
            onTap: updatepage,
            currentIndex: _page,
            selectedItemColor: GlobalVariables.selectedNavBarColor,
            unselectedItemColor: GlobalVariables.unselectedNavBarColor,
            items: [
              BottomNavigationBarItem(
                icon: Container(
                  width: 50,
                  child: Icon(
                    Icons.home_outlined,
                  ),
                  decoration: BoxDecoration(
                      border: Border(
                          top: BorderSide(
                    color: _page == 0
                        ? GlobalVariables.selectedNavBarColor
                        : GlobalVariables.backgroundColor,
                    width: 8,
                  ))),
                ),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Container(
                  width: 50,
                  child: Icon(
                    Icons.person_2_outlined,
                  ),
                  decoration: BoxDecoration(
                      border: Border(
                          top: BorderSide(
                              color: _page == 1
                                  ? GlobalVariables.selectedNavBarColor
                                  : GlobalVariables.backgroundColor,
                              width: 8))),
                ),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Container(
                  width: 50,
                  child: badges.Badge(
                    badgeContent: Text(
                      cartLength.toString(),
                      style: TextStyle(fontSize: 20),
                    ),
                    badgeStyle: badges.BadgeStyle(badgeColor: Colors.white),
                    child: Icon(
                      Icons.shopping_cart_outlined,
                    ),
                  ),
                  decoration: BoxDecoration(
                      border: Border(
                          top: BorderSide(
                              color: _page == 2
                                  ? GlobalVariables.selectedNavBarColor
                                  : GlobalVariables.backgroundColor,
                              width: 8))),
                ),
                label: '',
              )
            ]),
        // Column(
        //   children: [
        //     Expanded(
        //       child: navbody.elementAt(currentnavindex),
        //     ),
        //   ],
        // ),
        // bottomNavigationBar: BottomNavigationBar(
        //   iconSize: 35,
        //   currentIndex: currentnavindex,
        //   onTap: (index) {
        //     setState(() {
        //       currentnavindex = index;
        //     });
        //   },
        //   items: [],

        // ),
      ),
    );
  }

//   BottomNavigationBarItem bottomNavigationBarItemWidget({
//     required int pageIndex,
//     required IconData icon,
//     required bool badge,
//   }) {
//     return BottomNavigationBarItem(
//       icon: GestureDetector(
//         onTap: () {
//           setState(() => currentnavindex = pageIndex);
//         },
//         child: Stack(
//           children: [
//             Container(
//               width: 50,
//               height: 100,
//               padding: EdgeInsets.all(8),
//               decoration: BoxDecoration(
//                 // color: Colors.blue,
//                 border: Border(
//                   top: BorderSide(
//                     color: pageIndex == currentnavindex
//                         ? GlobalVariables.selectedNavBarColor
//                         : GlobalVariables
//                             .unselectedNavBarColor, // Initially transparent
//                     width: 3,
//                   ),
//                 ),
//               ),
//               child: Icon(
//                 icon,
//                 color: pageIndex == currentnavindex ? Colors.blue : Colors.grey,
//               ),
//             ),
//             // Show badge if badge value is greater than 0
//              Badge()
//           ],
//         ),
//       ),
//       label: '',
//     );
//   }
// }
}
