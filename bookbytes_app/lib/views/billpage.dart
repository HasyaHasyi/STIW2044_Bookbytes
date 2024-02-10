import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
// Import for Android features.
import 'package:webview_flutter_android/webview_flutter_android.dart';


import '../models/user.dart';

class BillScreen extends StatefulWidget {
  final User user;
  final double totalprice;
  const BillScreen({super.key, required this.user, required this.totalprice});

  @override
  State<BillScreen> createState() => _BillScreenState();
}

class _BillScreenState extends State<BillScreen> {
   var loadingPercentage = 0;
  late WebViewController controller;

  @override
  void initState() {
    super.initState();
    print(widget.user.useremail);
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(
        Uri.parse(
            'https://pestarakyatuum.my.id/bookbyte/php/payment.php?&userid=${widget.user.userid}&email=${widget.user.useremail}&phone=+60149502395&name=${widget.user.username}&amount=${widget.totalprice}'),
      );
      // print('https://pestarakyatuum.my.id/bookbyte/php/payment.php?&userid=${widget.user.userid}&email=${widget.user.useremail}&phone=+60149502395&name=${widget.user.username}&amount=${widget.totalprice}');
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: WebViewWidget(
          controller: controller,
        ),
      ),
    );
  }
}