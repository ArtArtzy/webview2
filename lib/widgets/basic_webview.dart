import 'dart:async';
import 'dart:io';
import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:webview/config/BuildConfig.dart';
import 'package:webview_flutter/webview_flutter.dart';

class BasicWebview extends StatefulWidget {
  @override
  _BasicWebviewState createState() => _BasicWebviewState();
}

class _BasicWebviewState extends State<BasicWebview> {
  WebViewController _webView;
  DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
  String _mobileVersion;

  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
    initPlatformState();
  }

  Future<void> initPlatformState() async {
    String mobileVersion = "";

    try {
      if (Platform.isAndroid) {
        mobileVersion = (await deviceInfoPlugin.androidInfo).version.release;
      } else if (Platform.isIOS) {
        mobileVersion = (await deviceInfoPlugin.iosInfo).systemVersion;
      }
    } on PlatformException {}

    if (!mounted) return;

    setState(() {
      _mobileVersion = mobileVersion;
    });
  }

  Future<bool> _handleOnBack() async {
    var value = await _webView.canGoBack();
    var currentUrl = await _webView.currentUrl();
    print(currentUrl);
    if (value) {
      _webView.goBack();
      return false;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _handleOnBack,
      child: Scaffold(
        body: SafeArea(
          child: _mobileVersion == null
              ? Container()
              : WebView(
                  onWebViewCreated: (WebViewController webViewController) {
                    _webView = webViewController;
                  },
                  javascriptMode: JavascriptMode.unrestricted,
                  initialUrl:
                      '${BuildConfig.WEBVIEW_URL}?wvAuth=${BuildConfig.PACKAGE_NAME}&key=${BuildConfig.KEY}&os=${Platform.operatingSystem}&mobileVersion=${_mobileVersion}',
                ),
        ),
      ),
    );
  }
}
