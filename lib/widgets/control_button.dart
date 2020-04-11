import 'package:flutter/material.dart';

class ControlButton extends StatelessWidget {
  final VoidCallback onTap;
  final IconData iconData;

  ControlButton({this.iconData, this.onTap});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onTap,
      iconSize: 50.0,
      icon: Icon(iconData),
      color: Theme.of(context).buttonColor,
    );
  }
}
