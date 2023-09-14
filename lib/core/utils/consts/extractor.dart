library extractor;

import 'dart:convert';

import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:html/dom.dart';
import 'package:html/parser.dart';

import '../../../features/02-home/01-home_webview/data/models/video_downloaded_model.dart';

class Extractor {
  static Future<VideoData?> getDirectLink({String link = '', int timeout = 6}) async {
    VideoData? res;

    HeadlessInAppWebView(
      initialUrlRequest: URLRequest(url: Uri.parse(utf8.decode(base64.decode('aHR0cHM6Ly9lbi5zYXZlZnJvbS5uZXQv')))),
      onLoadStop: (controller, url) async {
        await controller.evaluateJavascript(source: '''
document.querySelector('#sf_url').value = '$link'
document.querySelector('#sf_submit').click()
''');
        var data = await Future.delayed(const Duration(seconds: 3), () async {
          var htm = await controller.getHtml();
          var document = parse(htm);

          try {
            String? thumbnail = document.querySelector(".media-result .clip img")?.attributes['src'];

            var info = document.querySelector(".info-box");
            String? title = info?.querySelector(".title")?.text;
            String? duration = info?.querySelector(".duration")?.text;
            List<Element> linkGroup = [...info!.querySelectorAll(".link-group a")];

            List<Link> links = linkGroup.map((element) {
              String? videoFormat = element.attributes['title'];
              String? href = element.attributes['href'];
              String? text = element.text;
              return Link(videoFormat: videoFormat, href: href, text: text);
            }).toList();

            if (links.isEmpty) {
              Element? element = info.querySelector(".link-download");
              String? videoFormat = "";
              String? href = element?.attributes['href'];
              String? text = element?.text.replaceAll("Download", "").trim();
              links.add(Link(videoFormat: videoFormat, href: href, text: text));
            }

            VideoData vData = VideoData(
                status: true, message: 'Success', title: title, thumbnail: thumbnail, duration: duration, links: links);
            return vData;
          } catch (e) {
            return VideoData(status: false, message: 'Please try again');
          }
        });
        res = data;
      },
    )
      ..run()
      ..dispose();
    var result = Future.delayed(Duration(seconds: timeout), () {
      return res;
    });
    return result;
  }
}
