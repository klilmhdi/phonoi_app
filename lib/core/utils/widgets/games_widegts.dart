import 'package:flutter/material.dart';

class Games extends StatelessWidget {
  const Games({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 56,
          width: 56,
          child: Image.asset('assets/icons/Mask.png'),
        ),
        Text("Galaxy\nAttack",style: TextStyle(fontSize: 13),),
      ],
    );
  }
}
