import 'package:flutter/cupertino.dart';

void showCupertinoMessageDialog(BuildContext context, String title, String message) {
  showCupertinoDialog(
    context: context,
    builder: (_) => CupertinoAlertDialog(
      title: Text(title),
      content: Text(message),
      actions: [
        CupertinoDialogAction(
          child: Text("OK"),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ],
    ),
  );
}