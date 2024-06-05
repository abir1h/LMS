import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms/src/core/constants/common_imports.dart';
import 'package:path_provider/path_provider.dart';

import '../../../../core/common_widgets/custom_scaffold.dart';
import '../../../../core/common_widgets/custom_toasty.dart';
import '../../../../core/constants/app_theme.dart';
import '../../../../core/routes/app_route_args.dart';
import '../services/document_screen_service.dart';

class DocumentViewScreen extends StatefulWidget {
  final Object? arguments;
  const DocumentViewScreen({Key? key, this.arguments})
      : assert(arguments != null && arguments is DocumentViewScreenArgs),
        super(key: key);

  @override
  State<DocumentViewScreen> createState() => _DocumentViewScreenState();
}

class _DocumentViewScreenState extends State<DocumentViewScreen>
    with WidgetsBindingObserver,DocumentViewScreenService {
  final Completer<PDFViewController> _controller =
      Completer<PDFViewController>();
  int? pages = 0;
  int? currentPage = 0;
  bool isReady = false;
  String errorMessage = '';



  @override
  void initState() {
    if (widget.arguments != null) {
      screenArgs = widget.arguments as DocumentViewScreenArgs;
      createFileOfPdfUrl(ApiCredential.mediaBaseUrl+screenArgs.url).then((f) {
        setState(() {
          remotePDFpath = f.path;
        });
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(screenArgs.url.split('/').last.toString()),
        actions: <Widget>[
         /* IconButton(
            icon: Icon(Icons.share),
            onPressed: () {},
          ),*/
        ],
      ),
      body: Stack(
        children: <Widget>[
        remotePDFpath.isNotEmpty?  PDFView(
          filePath:remotePDFpath,
          enableSwipe: true,
          autoSpacing: false,
          pageFling: true,
          pageSnap: true,fitEachPage: true,
          defaultPage: currentPage!,
          fitPolicy: FitPolicy.BOTH,
          preventLinkNavigation:
          false, // if set to true the link is handled in flutter
          onRender: (_pages) {
            setState(() {
              pages = _pages;
              isReady = true;
            });
          },
          onError: (error) {
            setState(() {
              errorMessage = error.toString();
            });
            print(error.toString());
          },
          onPageError: (page, error) {
            setState(() {
              errorMessage = '$page: ${error.toString()}';
            });
            print('$page: ${error.toString()}');
          },
          onViewCreated: (PDFViewController pdfViewController) {
            _controller.complete(pdfViewController);
          },
          onLinkHandler: (String? uri) {
            print('goto uri: $uri');
          },
          onPageChanged: (int? page, int? total) {
            print('page change: $page/$total');
            setState(() {
              currentPage = page;
            });
          },
        ): Column(
          children: [
            SizedBox(height: .4.sh,),
            const Center(child: CircularProgressIndicator(),),SizedBox(height: 20,),
            const Center(child: Text('Please wait While Loading',style: TextStyle(fontWeight: FontWeight.w500,fontSize: 16,color: Colors.black),),)
          ],
        ),

        ],
      ),
/*
      floatingActionButton: FutureBuilder<PDFViewController>(
        future: _controller.future,
        builder: (context, AsyncSnapshot<PDFViewController> snapshot) {
          if (snapshot.hasData) {
            return FloatingActionButton.extended(
              label: Text("Go to ${pages! ~/ 2}"),
              onPressed: () async {
                await snapshot.data!.setPage(pages! ~/ 2);
              },
            );
          }

          return Container();
        },
      ),
*/
    );
  }

  @override
  void forceClose() {
    // TODO: implement forceClose
  }

  @override
  void showSuccess(String msg) {
    // TODO: implement showSuccess
  }

  @override
  void showWarning(String msg) {
    // TODO: implement showWarning
  }
}
