import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

Widget buildDivider() => Column(
      children: [
        SizedBox(
          height: 17,
        ),
        Row(children: [
          SizedBox(
            width: 55.0,
          ),
          Expanded(child: Divider(color: Colors.black87)),
          SizedBox(
            width: 16.0,
          ),
          Text(
            "أو",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(
            width: 16.0,
          ),
          Expanded(child: Divider(color: Colors.black87)),
          SizedBox(
            width: 55.0,
          ),
        ]),
        SizedBox(
          height: 17,
        ),
      ],
    );
