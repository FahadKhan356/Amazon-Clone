import 'dart:io';

import 'package:amazon_clone_1/common/Custom_button.dart';
import 'package:amazon_clone_1/common/Custom_textfield.dart';
import 'package:amazon_clone_1/constants/GlobalVariables.dart';
import 'package:amazon_clone_1/constants/Utils.dart';
import 'package:amazon_clone_1/features/admin/services/Admin_services.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

class Add_Products_Screen extends StatefulWidget {
  static const routname = '/add-produtcs';

  const Add_Products_Screen({super.key});

  @override
  State<Add_Products_Screen> createState() => _Add_Products_ScreenState();
}

class _Add_Products_ScreenState extends State<Add_Products_Screen> {
  final NameController = TextEditingController();
  final DescriptionController = TextEditingController();
  final PriceController = TextEditingController();
  final QuantityController = TextEditingController();
  AdminServices adminServices = AdminServices();

  List<String> Productcategories = [
    'Mobiles',
    'Essentials',
    'Appliances',
    'Books',
    'Fashion',
  ];
  String category = 'Mobiles';

  List<File> Images = [];

  void selecImages() async {
    var res = await PickImages();
    setState(() {
      Images = res;
    });
  }

  final _addProductFormKey = GlobalKey<FormState>();
  void sellproducts() {
    if (_addProductFormKey.currentState!.validate() && Images.isNotEmpty) {
      adminServices.SellProducts(
          context: context,
          name: NameController.text,
          description: DescriptionController.text,
          price: double.parse(PriceController.text),
          quantity: double.parse(QuantityController.text),
          category: category,
          images: Images);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          child: AppBar(
            flexibleSpace: Container(
              decoration:
                  BoxDecoration(gradient: GlobalVariables.appBarGradient),
            ),
            title: Center(
              child: const Text(
                "Add Products",
                style: TextStyle(fontSize: 25, color: Colors.black),
              ),
            ),
          ),
          preferredSize: Size.fromHeight(50)),
      body: SingleChildScrollView(
        child: Form(
            key: _addProductFormKey,
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Images.isNotEmpty
                      ? CarouselSlider(
                          items: Images.map((e) {
                            return Builder(
                              builder: (BuildContext context) => Image.file(
                                e,
                                fit: BoxFit.contain,
                              ),
                            );
                          }).toList(),
                          options: CarouselOptions(
                            viewportFraction: 1,
                          ))
                      : GestureDetector(
                          onTap: selecImages,
                          child: DottedBorder(
                            strokeCap: StrokeCap.round,
                            radius: Radius.circular(10),
                            borderType: BorderType.RRect,
                            dashPattern: [10, 8],
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10)),
                              width: double.infinity,
                              height: 180,
                              child: Column(
                                children: [
                                  Icon(
                                    Icons.folder_open,
                                    size: 60,
                                  ),
                                  SizedBox(height: 10),
                                  Text(
                                    "Select Product Image",
                                    style: TextStyle(
                                        fontSize: 25, color: Colors.grey[400]),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                ),
                SizedBox(
                  height: 20,
                ),
                Custom_textfield(
                    controller: NameController, hintext: 'Product name'),
                SizedBox(
                  height: 10,
                ),
                Custom_textfield(
                  controller: DescriptionController,
                  hintext: 'Description',
                  maxLines: 7,
                ),
                SizedBox(
                  height: 10,
                ),
                Custom_textfield(controller: PriceController, hintext: 'Price'),
                SizedBox(
                  height: 10,
                ),
                Custom_textfield(
                    controller: QuantityController, hintext: 'quantity'),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: SizedBox(
                    width: double.infinity,
                    child: DropdownButton(
                      icon: Icon(Icons.arrow_drop_down),
                      value: category,
                      items: Productcategories.map((String items) {
                        return DropdownMenuItem(
                          value: items,
                          child: Text(items),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          category = value!;
                        });
                      },
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Custom_button(
                  text: 'Sell',
                  onpress: sellproducts,
                ),
              ],
            )),
      ),
    );
  }
}
