import 'package:amazon_clone_1/features/Account/widgets/Account_button.dart';
import 'package:flutter/material.dart';

class TopButtons extends StatefulWidget {
  const TopButtons({super.key});

  @override
  State<TopButtons> createState() => _TopButtonsState();
}

class _TopButtonsState extends State<TopButtons> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Account_button(text: 'Your Orders', ontap: () {}),
            Account_button(text: 'Turn Seller', ontap: () {}),
          ],
        ),
        SizedBox(
          height: 20,
        ),
        Row(
          children: [
            Account_button(text: 'Log Out', ontap: () {}),
            Account_button(text: 'Your Wish List', ontap: () {}),
          ],
        ),
      ],
    );
  }
}
