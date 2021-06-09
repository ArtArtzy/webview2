import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: WebView(
          initialUrl: 'https://watjai.com/finnbet',
          javascriptMode: JavascriptMode.unrestricted,
        ),
      ),
    );
  }
}
