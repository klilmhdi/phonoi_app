import 'package:flutter/material.dart';

class IconColumnWidgets extends StatelessWidget {
  const IconColumnWidgets({
    required this.icon,
    required this.nameIcon,
    required this.count,
    super.key,
  });

  final Icon icon;
  final String nameIcon;
  final String count;

  @override
  Widget build(BuildContext context) {
    return Column(
      // crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: 40,
          // width: 40,
          child: IconButton(
            onPressed: () {},
            icon: icon,
            iconSize: 35,
          ),
        ),
        // SizedBox(height: 3),
        Text(
          nameIcon,
          style: TextStyle(fontSize: 8),
        ),
        Text(
          count,
          style: TextStyle(fontSize: 8),
        )
      ],
    );
  }
}
