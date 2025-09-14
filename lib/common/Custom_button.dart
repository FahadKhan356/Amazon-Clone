import 'package:amazon_clone_1/constants/GlobalVariables.dart';
import 'package:flutter/material.dart';

class Custom_button extends StatelessWidget {
  final text;
  final VoidCallback onpress;
  final Color? btcolor;
  final Color? txcolor;

  const Custom_button(
      {required this.text,
      required this.onpress,
      this.btcolor,
      this.txcolor,
      super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onpress,
      style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0),
          ),
          minimumSize: const Size(
            double.infinity,
            50,
          ),
          backgroundColor: GlobalVariables.secondaryColor),
      child: Text(
        text,
        style: const TextStyle(color: Colors.white),
      ),
    );
  }
}
