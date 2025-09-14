import 'package:flutter/material.dart';

class Custom_textfield extends StatelessWidget {
  final TextEditingController? controller;
  final hintext;
  final int maxLines;

  Custom_textfield(
      {this.controller, this.hintext, this.maxLines = 1, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: TextFormField(
        validator: (val) {
          if (val == null || val.isEmpty) {
            return "Please enter $hintext";
          }
        },
        controller: controller,
        decoration: InputDecoration(
            contentPadding:
                EdgeInsets.symmetric(vertical: 30.0, horizontal: 15),
            filled: true,
            hintText: hintext,
            border: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black12, width: 1.8),
            ),
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black12, width: 1.8),
            )),
        maxLines: maxLines,
      ),
    );
  }
}
