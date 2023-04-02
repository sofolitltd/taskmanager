import 'package:flutter/material.dart';

class AppButtonRowWidget extends StatelessWidget {
  const AppButtonRowWidget({
    super.key,
    required this.onPressed,
    required this.titleText,
    required this.buttonText,
  });

  final VoidCallback onPressed;
  final String titleText;
  final String buttonText;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        //
        Text(titleText),

        //
        TextButton(
          onPressed: onPressed,
          style: TextButton.styleFrom(
            padding: const EdgeInsets.all(6),
            minimumSize: Size.zero,
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          child: Text(
            buttonText,
            style: const TextStyle(
              color: Colors.green,
            ),
          ),
        ),
      ],
    );
  }
}
