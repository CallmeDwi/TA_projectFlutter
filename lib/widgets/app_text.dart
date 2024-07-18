import 'package:flutter/material.dart';

class AppText extends StatelessWidget {
  final double size;
  final String text;
  final Color color;

  AppText({
    super.key,
    this.size = 30,
    required this.text,
    Color? color,
  }) : color = color ??
            Colors.black.withOpacity(0.9); // Default color with opacity

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: color,
        fontSize: size,
        // fontWeight: FontWeight.bold,
        // fontFamily: 'StoryOfNature'
      ),
    );
  }
}
