import 'package:flutter/material.dart';
import 'package:lms/src/core/common_widgets/custom_scaffold.dart';
import 'package:webview_flutter/webview_flutter.dart';

class AuthWebViewScreen extends StatefulWidget {
  final String webViewLink;
  const AuthWebViewScreen({super.key, required this.webViewLink});

  @override
  State<AuthWebViewScreen> createState() => _AuthWebViewScreenState();
}

class _AuthWebViewScreenState extends State<AuthWebViewScreen> {
  late final WebViewController _controller;
  bool isloading = false;

  @override
  void initState() {
    super.initState();
    print(widget.webViewLink);
    _controller = WebViewController(); // Initialize the WebViewController here

    _controller
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          // ... (rest of your code remains unchanged)
        ),
      )
      ..loadRequest(Uri.parse("https://103.69.149.41/SSO/Account/Login?MerchantId=000010&token=6lfF8I8GYcHn2ebdlTYjJXh6lOSASuRvAGm8vcgWpzjaL5RNSI&RETURNURL=http%3A%2F%2F103.209.40.89%3A81%2Fapi%2Fauth%2Fdev%2FauthThroughEmis"));
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      title: "EMIS Login",
      body:  WebViewWidget(controller: _controller),
    );
  }
}
