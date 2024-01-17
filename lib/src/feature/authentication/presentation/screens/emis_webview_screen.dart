import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../../core/common_widgets/custom_scaffold.dart';
import '../../../../core/config/local_storage_services.dart';
import '../../../../core/constants/common_imports.dart';
import '../../../../core/network/api_service.dart';
import '../../../../core/routes/app_route.dart';
import '../../../../core/routes/app_route_args.dart';
import '../../data/models/login_response_model.dart';

class EMISWebViewScreen extends StatefulWidget {
  final Object? arguments;
  // final String webViewLink;
  const EMISWebViewScreen({super.key, this.arguments});

  @override
  State<EMISWebViewScreen> createState() => _EMISWebViewScreenState();
}

class _EMISWebViewScreenState extends State<EMISWebViewScreen> {
  late EMISWebViewScreenArgs _screenArgs;
  late final WebViewController _controller;
  bool isLoading = true;
  final localStorage = Get.find<LocalStorageService>();

  @override
  void initState() {
    super.initState();
    _screenArgs = widget.arguments as EMISWebViewScreenArgs;
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
                localStorage.storeStringValue(StringData.accessTokenKey,
                    loginResponse.data!.accessToken!);
                localStorage.storeStringValue(StringData.refreshTokenKey,
                    loginResponse.data!.refreshToken!);
                localStorage.storeStringValue(StringData.expiresAt,
                    loginResponse.data!.expiresAt.toString());
              });
              // Get.offAndToNamed(AppRoutes.landing);
              Navigator.of(context).pushNamedAndRemoveUntil(
                  AppRoute.landingScreen, (x) => false);
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
      ..loadRequest(Uri.parse(_screenArgs.webViewLink));
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
