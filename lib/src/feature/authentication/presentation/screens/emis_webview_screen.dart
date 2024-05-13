import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../../core/common_widgets/custom_scaffold.dart';
import '../../../../core/common_widgets/custom_toasty.dart';
import '../../../../core/constants/common_imports.dart';
import '../../../../core/routes/app_route.dart';
import '../../../../core/routes/app_route_args.dart';
import '../../domain/entities/auth_data_entity.dart';
import '../services/auth_service.dart';

class EMISWebViewScreen extends StatefulWidget {
  final Object? arguments;
  const EMISWebViewScreen({super.key, this.arguments});

  @override
  State<EMISWebViewScreen> createState() => _EMISWebViewScreenState();
}

class _EMISWebViewScreenState extends State<EMISWebViewScreen> {
  late EMISWebViewScreenArgs _screenArgs;
  late final WebViewController _controller;
  bool isLoading = true;
  String username = "";
  String token = "";

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
            } else if (request.url.startsWith(ApiCredential.getToken)) {
              isLoading = true;

              getUsernameToken(request.url);

              AuthService.getToken(username, token).then((responseEntity) {
                AuthDataEntity authData = responseEntity.data!;
                print(authData.accessToken);
              });
              CustomToasty.of(context).showSuccess("Login Successfully");
              Navigator.of(context).pushNamedAndRemoveUntil(
                  AppRoute.rootScreen, (x) => false,
                  arguments: RootScreenArgs(index: 0));
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(_screenArgs.webViewLink));
  }

  void getUsernameToken(String url) {
    Uri uri = Uri.parse(url);
    Map<String, String> queryParams = uri.queryParameters;

    username = queryParams['username'] ?? "";
    token = queryParams['token'] ?? "";
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
