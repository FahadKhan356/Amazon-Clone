import 'dart:io';

import 'package:amazon_clone_1/common/Custom_textfield.dart';
import 'package:amazon_clone_1/constants/GlobalVariables.dart';
import 'package:amazon_clone_1/constants/Utils.dart';
import 'package:amazon_clone_1/features/Address/screens/paymentconfig.dart';
import 'package:amazon_clone_1/features/Address/services/Address_services.dart';
import 'package:amazon_clone_1/provider/UserProvider.dart';
import 'package:flutter/material.dart';
import 'package:pay/pay.dart';
import 'package:provider/provider.dart';

class Addressscreen extends StatefulWidget {
  static const String routename = '/Address-screen';
  final int totalamount;
  Addressscreen({super.key, required this.totalamount});

  @override
  State<Addressscreen> createState() => _AddressscreenState();
}

class _AddressscreenState extends State<Addressscreen> {
  final _formkey = GlobalKey<FormState>();
  final TextEditingController _flatController = TextEditingController();
  final TextEditingController _areaController = TextEditingController();
  final TextEditingController _pincodeController = TextEditingController();
  final TextEditingController _townController = TextEditingController();

  AddressServices addressServices = AddressServices();
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _flatController.dispose();
    _areaController.dispose();
    _pincodeController.dispose();
    _townController.dispose();
  }

  void applepayresults(res) {}
  void googlepayresults(res) {}

  List<PaymentItem> paymentitem = [];
  String os = Platform.operatingSystem;
  //paymentConfiguration;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    paymentitem.add(PaymentItem(
        amount: widget.totalamount.toString(),
        status: PaymentItemStatus.final_price,
        label: 'Total Price'));
  }

  @override
  Widget build(BuildContext context) {
    String addressToBeUsed = '';
    var address = context.watch<UserProvider>().user.address;
    void onPressed(String addressfromprovider) {
      addressToBeUsed = '';

      bool isForm = _flatController.text.isNotEmpty ||
          _areaController.text.isNotEmpty ||
          _townController.text.isNotEmpty ||
          _pincodeController.text.isNotEmpty;
      if (isForm) {
        if (_formkey.currentState!.validate()) {
          addressToBeUsed =
              '${_flatController.text}, ${_areaController.text},${_townController.text},${_pincodeController.text}';
        }
        //else {
        //   throw Exception('Please fill all the fields');
        // }
      } else if (addressfromprovider.isNotEmpty) {
        addressToBeUsed = addressfromprovider;
      } else {
        showSnackbar(context, 'Error');
      }
      print('$addressToBeUsed' + " and " + '$address');
    }

    var applePayButton = ApplePayButton(
      paymentConfiguration:
          PaymentConfiguration.fromJsonString(defaultApplePay),
      paymentItems: paymentitem,
      style: ApplePayButtonStyle.black,
      width: double.infinity,
      height: 50,
      type: ApplePayButtonType.buy,
      margin: const EdgeInsets.only(top: 15.0),
      onPaymentResult: applepayresults,
      loadingIndicator: const Center(
        child: CircularProgressIndicator(),
      ),
    );

    var googlePayButton = GooglePayButton(
      onPressed: () => onPressed(address),
      paymentConfiguration:
          PaymentConfiguration.fromJsonString(defaultGooglePay),
      paymentItems: paymentitem,
      type: GooglePayButtonType.pay,
      margin: const EdgeInsets.only(top: 15.0),
      onPaymentResult: googlepayresults,
      loadingIndicator: const Center(
        child: CircularProgressIndicator(),
      ),
      width: double.infinity,
    );

    // var applePlayButton = ApplePayButton(
    //     onPaymentResult: (result) => applepayresult,
    //     paymentItems: paymentitem,
    //     paymentConfiguration:
    //         PaymentConfiguration.fromJsonString(defaultApplePay),
    //     style: ApplePayButtonStyle.automatic,
    //     type: ApplePayButtonType.buy,
    //     width: double.infinity,
    //     height: 50,
    //     margin: const EdgeInsets.all(5));

    // var address = context.watch<UserProvider>().user.address;

    return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: AppBar(
            flexibleSpace: Container(
              decoration:
                  const BoxDecoration(gradient: GlobalVariables.appBarGradient),
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              children: [
                if (address.isNotEmpty)
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          width: double.infinity,
                          height: 60,
                          decoration: BoxDecoration(
                            border:
                                Border.all(color: Colors.black12, width: 2.5),
                            color: Colors.white,
                          ),
                          child: Text(
                            address,
                            style: const TextStyle(
                                fontSize: 20, color: Colors.black),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        'OR',
                        style: TextStyle(
                            fontSize: 25, color: Colors.black.withOpacity(0.7)),
                      )
                    ],
                  ),
                const SizedBox(
                  height: 20,
                ),
                Form(
                  key: _formkey,
                  child: Column(
                    children: [
                      const SizedBox(height: 20),
                      Custom_textfield(
                        controller: _flatController,
                        hintext: 'Flat,House no,Building',
                      ),
                      const SizedBox(height: 20),
                      Custom_textfield(
                        controller: _areaController,
                        hintext: 'Area, Street',
                      ),
                      const SizedBox(height: 20),
                      Custom_textfield(
                        controller: _pincodeController,
                        hintext: 'Pincode',
                      ),
                      const SizedBox(height: 20),
                      Custom_textfield(
                        controller: _townController,
                        hintext: 'Town/City',
                      )
                    ],
                  ),
                ),
                Platform.isIOS ? applePayButton : googlePayButton,
                ElevatedButton(
                  onPressed: () {
                    onPressed(address);
                    addressServices.setUserAddress(addressToBeUsed, context);
                    addressServices.orderPlace(
                        context: context,
                        totalprice: widget.totalamount.toDouble(),
                        address: address);
                  },
                  style:
                      ElevatedButton.styleFrom(backgroundColor: Colors.amber),
                  child: const Text('sdsds'),
                ),
              ],
            ),
          ),
        ));
  }
}
