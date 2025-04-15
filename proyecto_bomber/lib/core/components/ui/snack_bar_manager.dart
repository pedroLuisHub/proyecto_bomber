import 'package:flutter/material.dart';

mixin SnackbarManager<T extends StatefulWidget> on State<T> {
  static const String defaultMessage = 'Sin Descripcion';
  static const int defaultDuration = 2500;

  void showSuccess(String? text,
      {bool behaviorFloating = false,
      int durationMilliSecond = defaultDuration}) {
    _show(
      text ?? defaultMessage,
      const Color.fromARGB(255, 72, 170, 72),
      behaviorFloating,
      durationMilliSecond,
    );
  }

  void showError(String? text,
      {bool behaviorFloating = false,
      int durationMilliSecond = defaultDuration}) {
    _show(
      text ?? defaultMessage,
      const Color(0xFFBB2124),
      behaviorFloating,
      durationMilliSecond,
    );
  }

  void showInfo(String? text,
      {bool behaviorFloating = false,
      int durationMilliSecond = defaultDuration}) {
    _show(
      text ?? defaultMessage,
      const Color(0xFF5bc0de),
      behaviorFloating,
      durationMilliSecond,
    );
  }

  void showWarning(String? text,
      {bool behaviorFloating = false,
      int durationMilliSecond = defaultDuration}) {
    _show(
      text ?? defaultMessage,
      const Color(0xFFF0AD4E),
      behaviorFloating,
      durationMilliSecond,
    );
  }

  void _show(String text, Color backgroundColor, bool behaviorFloating,
      int durationMilliSecond) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    final snackBar = SnackBar(
      behavior:
          behaviorFloating ? SnackBarBehavior.floating : SnackBarBehavior.fixed,
      content: Text(
        text,
        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
      ),
      duration: Duration(milliseconds: durationMilliSecond),
      dismissDirection: DismissDirection.up,
      backgroundColor: backgroundColor,
      showCloseIcon: true,
      closeIconColor: Colors.white,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
