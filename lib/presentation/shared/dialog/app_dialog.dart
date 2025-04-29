import 'package:flutter/material.dart';

Future<void> showAppDialog(
  BuildContext context, {
  required String title,
  required String message,
  required String buttonText,
  ColorType colorType = ColorType.home,
}) async {
  return showDialog<void>(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      final colorScheme = Theme.of(context).colorScheme;
      return AlertDialog(
        backgroundColor: switch (colorType) {
          ColorType.home => colorScheme.surface,
          ColorType.homeDetail => colorScheme.primaryContainer,
          ColorType.modal => colorScheme.tertiaryContainer,
        },
        title: Text(title),
        content: Text(message),
        actions: <Widget>[
          TextButton(
            child: Text(buttonText),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

enum ColorType {
  home,
  homeDetail,
  modal,
}
