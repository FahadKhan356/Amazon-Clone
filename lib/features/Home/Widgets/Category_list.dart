import 'package:amazon_clone_1/constants/GlobalVariables.dart';
import 'package:flutter/material.dart';

class CategoryList extends StatelessWidget {
  static const String Routename = '/category-deal-screen';
  const CategoryList({super.key});

  void Navigateto_CategoryDealScreen(String category, BuildContext context) {
    Navigator.pushNamed(context, Routename, arguments: category);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: GlobalVariables.categoryImages.length,
          itemExtent: 150,
          itemBuilder: (((context, index) {
            return GestureDetector(
              onTap: () => Navigateto_CategoryDealScreen(
                  GlobalVariables.categoryImages[index]['title']!, context),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: Image.asset(
                        GlobalVariables.categoryImages[index]['image']!,
                        fit: BoxFit.cover,
                        height: 50,
                        width: 50,
                      ),
                    ),
                  ),
                  Text(
                    GlobalVariables.categoryImages[index]['title']!,
                    style: const TextStyle(
                        fontSize: 15, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            );
          }))),
    );
  }
}
