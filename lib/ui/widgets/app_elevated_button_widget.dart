import 'package:flutter/material.dart';

class AppElevatedButtonWidget extends StatelessWidget {
  const AppElevatedButtonWidget({
    Key? key,
    required this.child,
    required this.onPressed,
  }) : super(key: key);

  final Widget child;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.green,
          minimumSize: const Size(64, 48),
        ),
        onPressed: onPressed,
        child: child,
      ),
    );
  }
}
