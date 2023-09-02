// navigate and finish pervious screen
import 'package:flutter/material.dart';

navAndFinish(context, Widget) =>
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => Widget), (route) {
      return false;
    });

// just navigate for screen
navTo(context, Widget) => Navigator.push(context, MaterialPageRoute(builder: (context) => Widget));
