import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ChangeFontSizeScreen extends StatefulWidget {
  const ChangeFontSizeScreen({super.key});

  @override
  State<ChangeFontSizeScreen> createState() => _ChangeFontSizeScreenState();
}

class _ChangeFontSizeScreenState extends State<ChangeFontSizeScreen> {
  double _fontSize = 16.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("حجم الخط"),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "هنا منطقة العرض، اسحب الشريط لاختيار الخط الأنسب",
                style: TextStyle(
                  fontSize: _fontSize,
                ),
              ),
              SizedBox(
                width: double.infinity,
                height: 150,
                child: Slider(
                  value: _fontSize,
                  activeColor: Colors.black,
                  inactiveColor: Colors.grey,
                  min: 10.0,
                  max: 40.0,
                  onChanged: (value) => setState(() {
                    _fontSize = value;
                  }),
                ),
              )
            ]),
      ),
    );
  }
}
