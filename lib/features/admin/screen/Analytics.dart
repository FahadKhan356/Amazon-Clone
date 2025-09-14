import 'package:amazon_clone_1/features/admin/screen/Categoryproductscharts.dart';
import 'package:amazon_clone_1/features/admin/services/Admin_services.dart';
import 'package:community_charts_flutter/community_charts_flutter.dart'
    as charts;

import 'package:flutter/material.dart';

import '../widget/Sales.dart';
import 'loader.dart';

class Analytics extends StatefulWidget {
  const Analytics({super.key});

  @override
  State<Analytics> createState() => _AnalyticsState();
}

class _AnalyticsState extends State<Analytics> {
  AdminServices adminServices = AdminServices();
  //alis totalearnings
  int? totalSales;
  List<Sales>? earnings;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getearnings();
  }

  getearnings() async {
    var earningData = await adminServices.getearnings(context);
    totalSales = earningData['totalearnings'];
    earnings = earningData['sales'];
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Analytics'),
      ),
      body: totalSales == null || earnings == null
          ? const Loader()
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'Total Sales: ${totalSales ?? "Loading..."}',
                    style: const TextStyle(fontSize: 26),
                  ),
                ),
                SizedBox(
                  height: 200,
                  child: Categoryproductscharts(seriesList: [
                    charts.Series(
                        id: 'Sales',
                        data: earnings!,
                        domainFn: (datum, index) => datum.label,
                        measureFn: (datum, index) => datum.earnings)
                  ]),
                ),
                // Expanded(
                //   child: ListView(
                //     padding: const EdgeInsets.all(16),
                //     children: [
                //       AspectRatio(
                //         aspectRatio: 1,
                //         child: DChartBarO(
                //           groupList: [
                //             OrdinalGroup(
                //               id: '1',
                //               data: [
                //                 OrdinalData(domain: 'Mon', measure: 2),
                //                 OrdinalData(domain: 'Tue', measure: 6),
                //                 OrdinalData(domain: 'Wed', measure: 3),
                //                 OrdinalData(domain: 'Thu', measure: 7),
                //               ],
                //             ),
                //           ],
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
              ],
            ),
    );
  }
}
