import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../../generated/l10n.dart';

class CompressedFiles extends StatefulWidget {
  const CompressedFiles({super.key});

  @override
  State<CompressedFiles> createState() => _CompressedFilesState();
}

class _CompressedFilesState extends State<CompressedFiles> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.search,
              size: 36,
            ),
          ),
        ],
        title: Text(
          S.of(context).compreseds,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
        ),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: IconButton(
              onPressed: () {},
              padding: EdgeInsets.zero,
              icon: FaIcon(
                FontAwesomeIcons.fileLines,
                size: 82,
                color: Colors.purple.shade400,
              ),
            ),
          ),
          SizedBox(height: 60),
          Center(
            child: Text(
              S.of(context).no_compressed,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
          )
        ],
      ),
    );
  }
}
