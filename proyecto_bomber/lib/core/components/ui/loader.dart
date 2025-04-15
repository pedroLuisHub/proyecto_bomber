import 'dart:async';

import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

mixin Loader<T extends StatefulWidget> on State<T> {
  var isOpen = false;
  Completer<void> _loaderCompleter = Completer<void>();

  void showLoader() {
    if (!isOpen && mounted) {
      isOpen = true;
      _loaderCompleter = Completer<void>();
      showDialog(
        barrierDismissible: false,
        context: context,
        builder:
            (_) => PopScope(
              canPop: false,
              child: LoadingAnimationWidget.threeArchedCircle(
                color: Colors.red,
                size: 60,
              ),
            ),
      ).then((_) {
        if (!_loaderCompleter.isCompleted) {
          _loaderCompleter.complete();
        }
      });
    }
  }

  void hideLoader() {
    if (isOpen && mounted) {
      isOpen = false;
      if (!_loaderCompleter.isCompleted) {
        Navigator.of(context, rootNavigator: true).pop();
        _loaderCompleter.complete();
      }
    }
  }

  @override
  void dispose() {
    hideLoader();
    super.dispose();
  }
}
