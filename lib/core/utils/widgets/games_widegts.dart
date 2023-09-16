import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class GamesCard extends StatelessWidget {
  GamesCard({
    super.key,
    required this.gameImage,
    required this.gameName,
  });

  String gameName;
  String gameImage;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 56,
          width: 56,
          child: CachedNetworkImage(imageUrl: gameImage, placeholder: (context, url) => CircularProgressIndicator(),),
        ),
        AutoSizeText(
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
          minFontSize: 8,
          maxFontSize: 10,
          gameName,
          style: TextStyle(fontSize: 10),
        ),
      ],
    );
  }
}
