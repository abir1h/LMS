import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../../core/common_widgets/custom_scaffold.dart';
import '../../../../core/network/api_service.dart';
import '../../data/models/login_response_model.dart';
import '../../../../core/routes/app_routes.dart';

class EMISWebViewScreen extends StatefulWidget {
  final String webViewLink;
  const EMISWebViewScreen({super.key, required this.webViewLink});

  @override
  State<EMISWebViewScreen> createState() => _EMISWebViewScreenState();
}

class _EMISWebViewScreenState extends State<EMISWebViewScreen> {
  late final WebViewController _controller;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController() // Initialize the WebViewController here
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onUrlChange: (UrlChange urlChange) {},
          onProgress: (int progress) {
            if (progress == 100) {
              setState(() {
                isLoading = false;
              });
            }
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith("http://103.69.149.41/SSO/")) {
              isLoading = true;
              print(isLoading);
            } else if (request.url.startsWith(
                "http://103.209.40.89:81/api/auth/dev/authThroughEmis?")) {
              isLoading = true;

              ApiService()
                  .getRequest(request.url
                      .replaceAll("http://103.209.40.89:81/api", "")
                      .replaceAll("authThroughEmis", "token"))
                  .then((value) {
                LoginResponse loginResponse =
                    LoginResponse.fromJson(json.decode(value));
                print("access token ${loginResponse.data?.accessToken}");
              });
              Get.offAndToNamed(AppRoutes.landing);
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
            // if (request.url.startsWith(widget.webViewLink)) {
            //   return NavigationDecision.prevent;
            // }
            // return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.webViewLink));
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      title: "EMIS Login",
      body: isLoading == false
          ? WebViewWidget(controller: _controller)
          : const Center(child: CircularProgressIndicator()),
    );
  }
}
