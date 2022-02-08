import 'package:flutter/material.dart';

class Circle extends StatelessWidget {
  final bool filled;

  const Circle({
    Key? key,
    this.filled = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      width: 30,
      decoration: BoxDecoration(
        color: filled ? Colors.green : Colors.transparent,
        shape: BoxShape.circle,
        border: Border.all(
          color: Colors.grey,
          width: 1,
        ),
      ),
    );
  }
}
