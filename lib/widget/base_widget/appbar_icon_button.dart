import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class AppBarIconButton extends StatelessWidget {
  const AppBarIconButton({
    Key? key,
    required this.icon,
    required this.onPressed,
  }) : super(key: key);

  final Widget icon;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      hoverColor: Colors.transparent,
      focusColor: Colors.transparent,
      icon: icon,
      onPressed: onPressed,
    );
  }
}
