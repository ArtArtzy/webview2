import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:webview/widgets/basic_webview.dart';

class SplashPage extends StatefulWidget {
  SplashPage({Key key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF02082F),
      body: SafeArea(
        child: SplashScreen(
          seconds: 5,

          navigateAfterSeconds: BasicWebview(),
          image: Image.asset('assets/images/app_logo.png'),
          backgroundColor: Color(0xFF02082F),
          photoSize: 90,
          loaderColor: Color(0xFFFCDC0C),
        ),
      ),
    );
  }
}
