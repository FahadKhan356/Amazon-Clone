import 'package:amazon_clone_1/common/Custom_button.dart';
import 'package:amazon_clone_1/constants/GlobalVariables.dart';
import 'package:amazon_clone_1/features/admin/services/Admin_services.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;
import 'package:provider/provider.dart';

import '../../../provider/UserProvider.dart';

class Ordersdetails extends StatefulWidget {
  static const String routname = '/orders-screen';
  final dynamic order;
  Ordersdetails({super.key, required this.order});

  @override
  State<Ordersdetails> createState() => _OrdersdetailsState();
}

class _OrdersdetailsState extends State<Ordersdetails> {
  AdminServices adminServices = AdminServices();
  int currentStep = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(
        '${widget.order.products[0].quantity} and ${widget.order.products[1].quantity}');
    currentStep = widget.order.status;
  }

  void changeOrderStatus(int status) {
    adminServices.changeOrderStatus(
        context: context,
        status: status + 1,
        order: widget.order,
        onsuccess: () {
          setState(() {
            currentStep += 1;
          });
        });
  }

  @override
  Widget build(BuildContext context) {
    var user = Provider.of<UserProvider>(context).user;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          flexibleSpace: Container(
            decoration:
                const BoxDecoration(gradient: GlobalVariables.appBarGradient),
          ),
          title: Row(
            children: [
              const SizedBox(
                width: 20,
              ),
              Expanded(
                child: Container(
                  height: 45,
                  child: Material(
                    elevation: 1,
                    borderRadius: BorderRadius.circular(5),
                    child: TextFormField(
                      decoration: InputDecoration(
                        prefixIcon: Container(
                          child: const Icon(
                            Icons.search,
                            size: 25,
                            color: Colors.black,
                          ),
                        ),
                        hintText: 'Search Amazon in',
                        hintStyle: const TextStyle(
                            fontSize: 20, color: Colors.black38),
                        filled: true,
                        fillColor: Colors.white,
                        border: InputBorder.none,
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: BorderSide.none),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                width: 100,
                height: 100,
                child: const Icon(
                  Icons.mic,
                  color: Colors.black,
                  size: 28,
                ),
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(10.0),
            child: Text(
              'View order details',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            margin: const EdgeInsets.all(5),
            width: double.infinity,
            decoration: BoxDecoration(
                border: Border.all(color: Colors.black12, width: 2)),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Order Date:  ${intl.DateFormat().format(DateTime.fromMillisecondsSinceEpoch(int.parse(widget.order.orderedAt)))}',
                    style: const TextStyle(fontSize: 22),
                  ),
                  Text(
                    'Order Id: ${widget.order.id}',
                    style: const TextStyle(fontSize: 22),
                  ),
                  Text(
                    'Order Total: ${widget.order.totalprice.toDouble()} ',
                    style: const TextStyle(fontSize: 22),
                  ),
                ],
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(10.0),
            child: Text(
              'Purchase Details',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            margin: const EdgeInsets.all(5),
            width: double.infinity,
            decoration: BoxDecoration(
                border: Border.all(color: Colors.black12, width: 2)),
            child: Column(
              children: [
                for (int i = 0; i < widget.order.products.length; i++)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.network(
                          widget.order.products[i].images[0],
                          fit: BoxFit.contain,
                          height: 140,
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${widget.order.products[i].name}',
                              style: const TextStyle(
                                  fontSize: 23, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              'Qty: ${widget.order.quantity[i]}',
                              style: const TextStyle(fontSize: 23),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(10.0),
            child: Text(
              'Tracking',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            margin: const EdgeInsets.all(5),
            width: double.infinity,
            decoration: BoxDecoration(
                border: Border.all(color: Colors.black12, width: 2)),
            child: Column(
              children: [
                Stepper(
                    currentStep: currentStep,
                    controlsBuilder: (context, details) {
                      if (user.type == 'admin') {
                        return Custom_button(
                            text: 'Done',
                            onpress: () {
                              changeOrderStatus(details.currentStep);
                            });
                      }
                      return SizedBox();
                    },
                    steps: [
                      Step(
                        state: currentStep >= 0
                            ? StepState.complete
                            : StepState.indexed,
                        isActive: currentStep > 0,
                        title: const Text('Pending'),
                        content:
                            const Text('Your order is yet to be delievered'),
                      ),
                      Step(
                          state: currentStep > 1
                              ? StepState.complete
                              : StepState.indexed,
                          isActive: currentStep > 1,
                          title: const Text('Completed'),
                          content: const Text(
                              'Your order has been delievered,you are yet to sign.')),
                      Step(
                          state: currentStep > 2
                              ? StepState.complete
                              : StepState.indexed,
                          isActive: currentStep > 2,
                          title: const Text('Recieved'),
                          content: const Text(
                              'Your order has been delievered and signed by you.')),
                      Step(
                          state: currentStep >= 3
                              ? StepState.complete
                              : StepState.indexed,
                          isActive: currentStep >= 3,
                          title: const Text('Delievered'),
                          content: const Text(
                              'Your order has been delievered and signed by you.')),
                    ]),
              ],
            ),
          ),
        ],
      )),
    );
  }
}
