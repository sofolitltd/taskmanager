import 'package:flutter/material.dart';

void showSnackBarMessage(BuildContext context,
    {required String title, bool? error}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: error == true ? Colors.red : null,
      content: Text(title),
    ),
  );
}
