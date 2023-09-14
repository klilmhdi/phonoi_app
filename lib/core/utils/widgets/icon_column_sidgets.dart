import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';

class IconColumnWidgets extends StatelessWidget {
  const IconColumnWidgets({
    required this.icon,
    required this.nameIcon,
    required this.count,
    required this.onPressed,
    super.key,
  });

  final FaIcon icon;
  final String nameIcon;
  final String count;
  final Callback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      // crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding:  EdgeInsetsDirectional.only(top: 8),
          child: SizedBox(
            height: 40,
            // width: 40,
            child: IconButton(
              onPressed: onPressed,
              icon: icon,
              padding: EdgeInsets.zero,
              iconSize: 38,
            ),
          ),
        ),
        SizedBox(height: 5),
        Text(
          nameIcon,
          style: TextStyle(fontSize: 8,fontWeight: FontWeight.w500),
        ),
        Text(
          count,
          style: TextStyle(fontSize: 8,fontWeight: FontWeight.w500),
        )
      ],
    );
  }
}
