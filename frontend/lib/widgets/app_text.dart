import 'package:flutter/material.dart';

class AppText extends StatelessWidget {
  const AppText({
    super.key,
    required this.text,
    this.color,
    this.fontWeight = FontWeight.normal,
    this.fontSize,
    this.backgroundColor,
    this.height,
    this.alignment,
    this.overflow,
    this.maxLines,
  });

  final String text;
  final Color? color;
  final FontWeight fontWeight;
  final double? fontSize;
  final Color? backgroundColor;
  final double? height;
  final TextAlign? alignment;
  final TextOverflow? overflow;
  final int? maxLines;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: color,
        fontSize: fontSize,
        fontWeight: fontWeight,
        height: height,
      ),
      textAlign: alignment,
      overflow: overflow,
      maxLines: maxLines,
    );
  }
}
