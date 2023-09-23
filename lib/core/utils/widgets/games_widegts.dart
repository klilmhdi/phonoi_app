import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

class GamesCard extends StatelessWidget {
  GamesCard({required this.gameName, required this.gameImage, required this.gameLink});

  final String gameName;
  final String gameImage;
  final String gameLink;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () async {
            if (await canLaunchUrlString(gameLink)) {
              await launchUrlString(gameLink);
            } else {
              throw 'Could not launch $gameLink';
            }
          },
          child: SizedBox(
            height: 56,
            width: 56,
            child: CachedNetworkImage(
              imageUrl: gameImage,
              placeholder: (context, url) => CircularProgressIndicator(),
            ),
          ),
        ),
        Center(
          child: AutoSizeText(
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            minFontSize: 8,
            maxFontSize: 10,
            gameName,
            style: TextStyle(fontSize: 10),
          ),
        ),
      ],
    );
  }
}
