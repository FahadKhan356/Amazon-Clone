import 'package:amazon_clone_1/constants/GlobalVariables.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class CrouselImages extends StatelessWidget {
  const CrouselImages({super.key});

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
        items: GlobalVariables.carouselImages
            .map((i) => Builder(
                builder: (BuildContext context) => Image.network(
                      i,
                      fit: BoxFit.cover,
                    )))
            .toList(),
        options: CarouselOptions(
          viewportFraction: 1,
          height: 250,
        ));
  }
}
