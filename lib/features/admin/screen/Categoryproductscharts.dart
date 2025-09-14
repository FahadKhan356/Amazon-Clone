import 'package:amazon_clone_1/features/admin/widget/Sales.dart';
import 'package:flutter/material.dart';
import 'package:community_charts_flutter/community_charts_flutter.dart'
    as charts;

class Categoryproductscharts extends StatelessWidget {
  final List<charts.Series<Sales, String>> seriesList;
  Categoryproductscharts({super.key, required this.seriesList});

  @override
  Widget build(BuildContext context) {
    return charts.BarChart(
      seriesList,
      animate: true,
    );
  }
}
