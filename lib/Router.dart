import 'package:amazon_clone_1/common/BottomBar.dart';
import 'package:amazon_clone_1/features/Address/screens/Addressscreen.dart';
import 'package:amazon_clone_1/features/Home/HomeScreen.dart';
import 'package:amazon_clone_1/features/Home/Widgets/Category_list.dart';
import 'package:amazon_clone_1/features/Home/category_deal_screen.dart';
import 'package:amazon_clone_1/features/OrderDetails/screens/Orderdetails.dart';
import 'package:amazon_clone_1/features/Product_details/screens/Productdetailscreen.dart';
import 'package:amazon_clone_1/features/Search/Screens/SearchScreen.dart';
import 'package:amazon_clone_1/features/admin/screen/add_product_screen.dart';
import 'package:amazon_clone_1/features/auth/screens/AuthScreen.dart';
import 'package:amazon_clone_1/models/Ordermodel.dart';
import 'package:amazon_clone_1/models/Product.dart';
import 'package:flutter/material.dart';

Route<dynamic> GenerateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case Auth_Screen.routename:
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => Auth_Screen());
    case Add_Products_Screen.routname:
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => Add_Products_Screen());

    case Product_Detail_Screen.routename:
      var product = routeSettings.arguments as Product;
      return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => Product_Detail_Screen(product: product));

    case CategoryList.Routename:
      var category = routeSettings.arguments as String;
      return MaterialPageRoute(
          builder: (_) => Category_Deal_screen(category: category));

    case SearchScreen.routename:
      var Searchquery = routeSettings.arguments as String;
      return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => SearchScreen(Searchquery: Searchquery));

    case Addressscreen.routename:
      var totalamount = routeSettings.arguments as int;
      return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => Addressscreen(
                totalamount: totalamount,
              ));

    case Ordersdetails.routname:
      var orders = routeSettings.arguments as Ordersmodel;
      return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => Ordersdetails(order: orders));

    case HomeScreen.routename:
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => HomeScreen());
    case BottomBar.routename:
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => BottomBar());
    default:
      return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => Scaffold(
                body: Text('error 404'),
              ));
  }
}
