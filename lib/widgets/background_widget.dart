import 'package:flutter/material.dart';

class BackgrounPicturedWidget extends StatelessWidget {
  final Widget child;
  const BackgrounPicturedWidget({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/bg.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: child,
    );
  }
}
