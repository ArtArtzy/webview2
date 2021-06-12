import 'dart:async';
import 'dart:io';
import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:webview/config/BuildConfig.dart';

class BasicWebview extends StatefulWidget {
  @override
  _BasicWebviewState createState() => _BasicWebviewState();
}

class _BasicWebviewState extends State<BasicWebview> {
  DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
  String _mobileVersion;
  final flutterWebviewPlugin = new FlutterWebviewPlugin();
  @override
  void initState() {
    super.initState();
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
  var canGoBack = await  flutterWebviewPlugin.canGoBack();
    if (canGoBack) {
      flutterWebviewPlugin.goBack();
      return false;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
  var url =  '${BuildConfig.WEBVIEW_URL}?wvAuth=${BuildConfig.PACKAGE_NAME}&key=${BuildConfig.KEY}&os=${Platform.operatingSystem}&mobileVersion=${_mobileVersion}';
    return WillPopScope(
      onWillPop: _handleOnBack,
      child: Scaffold(
        body: SafeArea(
            child: _mobileVersion == null
                ? Container()
                : WebviewScaffold(
                    hidden: false,
                    url: url,
                  )),
      ),
    );
  }
}
