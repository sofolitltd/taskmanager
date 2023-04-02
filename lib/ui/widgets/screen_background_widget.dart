import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class BackgroundWidget extends StatelessWidget {
  const BackgroundWidget({Key? key, required this.child}) : super(key: key);
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Stack(
      children: [
        //bg
        SvgPicture.asset(
          'assets/images/background.svg',
          height: size.height,
          width: size.width,
          fit: BoxFit.cover,
        ),

        //child
        child,
      ],
    );
  }
}
