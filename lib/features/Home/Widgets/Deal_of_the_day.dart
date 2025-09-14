import 'package:amazon_clone_1/features/Product_details/screens/Productdetailscreen.dart';
import 'package:flutter/material.dart';

import '../../../models/Product.dart';

class Deal_of_the_day extends StatefulWidget {
  final Product? product;
  Deal_of_the_day({super.key, this.product});

  @override
  State<Deal_of_the_day> createState() => _Deal_of_the_dayState();
}

class _Deal_of_the_dayState extends State<Deal_of_the_day> {
  void navigatetoProductDetaiScreen() {
    Navigator.pushNamed(context, Product_Detail_Screen.routename,
        arguments: widget.product);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.topLeft,
          padding: EdgeInsets.only(top: 5, left: 10),
          child: Text(
            'Deal Of the Day',
            style: TextStyle(fontSize: 15),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        GestureDetector(
          onTap: () => navigatetoProductDetaiScreen(),
          child: Image.network(
            //'https://images.unsplash.com/photo-1498050108023-c5249f4df085?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTB8fGxhcHRvcHxlbnwwfHwwfHx8MA%3D%3D',
            widget.product!.images[0],
            fit: BoxFit.contain,
            height: 230,
            width: double.infinity,
          ),
        ),
        Container(
          padding: EdgeInsets.only(top: 5, left: 10),
          alignment: Alignment.topLeft,
          child: Text(
            '\S100',
            style: TextStyle(fontSize: 18),
          ),
        ),
        Container(
          padding: EdgeInsets.only(top: 5, left: 10),
          alignment: Alignment.topLeft,
          child: Text(
            'Rivaan',
            style: TextStyle(fontSize: 18),
          ),
        ),
      ],
    );
  }
}
