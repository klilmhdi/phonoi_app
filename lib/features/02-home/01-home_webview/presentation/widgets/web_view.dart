import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WebViewPage extends StatefulWidget {
  final String url;

  WebViewPage({required this.url});

  @override
  _WebViewPageState createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  bool _isAddingTab = false;

  late InAppWebViewController _webController;
  double _progress = 0;
  TextEditingController _urlController = TextEditingController();
  String? _currentUrl;

  Future<WebResourceResponse?> _shouldInterceptRequest(InAppWebViewController controller, String url) async {
    // Check if the resource being loaded is a Reels video
    if (url.contains('/reel/') && url.endsWith('.mp4')) {
      // Update the current URL to the new video URL
      setState(() {
        _currentUrl = url;
      });
      // Load the new video URL in the WebView
      controller.loadUrl(urlRequest: URLRequest(url: Uri.parse(_currentUrl!)));
    }
    return null;
  }

  @override
  void initState() {
    super.initState();
    _urlController.text = widget.url;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _urlController,
                onTap: () => {},
                onSubmitted: (value) {
                  _loadUrl();
                },
                decoration: InputDecoration(
                  constraints: BoxConstraints(
                    maxHeight: 57.h,
                    maxWidth: 360.w,
                  ),
                  fillColor: const Color(0xffEBEBEB),
                  filled: true,
                  hintText: "البحث أو كتابة عنوان الويب",
                  hintStyle: TextStyle(
                    color: const Color(0xff5D5D5D),
                    fontSize: 13.sp,
                  ),
                  prefixIcon: CircleAvatar(
                      backgroundColor: Colors.purple,
                      child: Center(
                        child: Icon(Icons.search, color: Colors.white, size: 24),
                      )),
                  suffixIcon: SizedBox(
                    width: 10.5.w,
                    height: 10.5.h,
                    child: Image.asset("assets/icons/google.png"),
                  ),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(24), borderSide: BorderSide.none),
                ),
              ),
            ),
            _progress < 1.0
                ? LinearProgressIndicator(
                    value: _progress,
                    color: Colors.blue,
                  )
                : Container(),
            Expanded(
              child: InAppWebView(
                initialUrlRequest: URLRequest(url: Uri.parse(widget.url)),
                onWebViewCreated: (InAppWebViewController controller) {
                  _webController = controller;
                },
                onLoadStart: (InAppWebViewController controller, Uri? url) {
                  setState(() {
                    _urlController.text = url?.toString() ?? '';
                  });
                },
                onLoadStop: (InAppWebViewController controller, Uri? url) async {
                  setState(
                    () {
                      _urlController.text = url?.toString() ?? '';
                      _progress = 1.0;
                    },
                  );
                },
                onProgressChanged: (InAppWebViewController controller, int progress) {
                  setState(
                    () {
                      _progress = progress / 100;
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.arrow_back_ios, color: Colors.black),
            label: 'Back',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.arrow_forward_ios, color: Colors.black),
            label: 'Forward',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.refresh, color: Colors.black),
            label: 'Reload',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home_outlined,
              color: Colors.black,
            ),
            label: 'Reload',
          ),
        ],
        onTap: (int index) {
          if (index == 0) {
            _webController.goBack();
          } else if (index == 1) {
            _webController.goForward();
          } else if (index == 2) {
            _webController.reload();
          } else if (index == 3) {
            _webController.webStorage;
          }
        },
      ),
    );
  }

  void _loadUrl() {
    String url = _urlController.text.trim();
    if (url.isEmpty) {
      return;
    }
    if (!url.startsWith('http://') && !url.startsWith('https://')) {
      url = 'https://' + url;
    }
    setState(() {
      _progress = 0; // إعادة تعيين قيمة الاكتمال إلى الصفر عند بدء التحميل الجديد
    });
    _webController.loadUrl(urlRequest: URLRequest(url: Uri.parse(url)));
  }
}
