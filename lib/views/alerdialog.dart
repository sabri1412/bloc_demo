import 'package:bloc_demo/models/constants.dart';
import 'package:flutter/material.dart';

Future<bool?> yesNoDialog(BuildContext context, String message) async {
  return showDialog<bool>(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      actionsAlignment: MainAxisAlignment.center,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(23))),
      insetPadding: const EdgeInsets.all(15),
      backgroundColor: backgroundColor,
      title: const Text(
        'Information',
        textAlign: TextAlign.center,
        style: alertTitle,
      ),
      content: Text(message, textAlign: TextAlign.center, style: alertText),
      actions: <Widget>[
        TextButton(
            child: const Text('Yes', style: alertText),
            onPressed: () => Navigator.pop(context, true)),
        TextButton(
            child: const Text('No', style: alertText),
            onPressed: () => Navigator.pop(context, false)),
      ],
    ),
  );
}
