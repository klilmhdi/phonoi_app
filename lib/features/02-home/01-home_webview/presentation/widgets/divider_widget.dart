import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../../../../generated/l10n.dart';

Widget buildDivider(context) => Column(
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
            S.of(context).or,
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
