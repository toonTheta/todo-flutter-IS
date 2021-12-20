import 'package:flutter/material.dart';

class Touchable extends StatelessWidget {
  final Widget child;
  final Function() onPress;
  final double? borderRadius;
  final EdgeInsets? padding;

  Touchable({
    required this.child,
    required this.onPress,
    this.borderRadius,
    this.padding
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius ?? 0),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
            child: Padding(
              padding: padding ?? EdgeInsets.all(0),
              child: child,
            ),
            onTap: this.onPress),
      ),
    );
  }
}