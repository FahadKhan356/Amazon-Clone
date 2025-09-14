import 'package:flutter/material.dart';

BottomNavigationBarItem BottomNavigationBarItemWidget({
  BuildContext? context,
  int? bottomBarWidth,
  int? bottomBarBorderWidth,
  int? pageIndex,
  required IconData icon,
  String? label,
}) {
  return BottomNavigationBarItem(
    icon: Container(
        width: bottomBarWidth?.toDouble() ?? 42,
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
              color: pageIndex == 0
                  ? Colors.blue // Change the color based on your condition
                  : Colors.red,
              width: bottomBarBorderWidth?.toDouble() ?? 5,
            ),
          ),
        ),
        child: Icon(icon)),
    label: label ?? '',
  );
}
