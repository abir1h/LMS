import 'package:flutter/material.dart';

abstract class _ViewModel {
  void showWarning(String message);
  void navigateToCircularDetailsScreen();
}

mixin CircularScreenService<T extends StatefulWidget> on State<T>
    implements _ViewModel {
  late _ViewModel _view;

  ///Service configurations
  @override
  void initState() {
    _view = this;
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void onTapCircular() {
    _view.navigateToCircularDetailsScreen();
  }
}
