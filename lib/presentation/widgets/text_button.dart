import 'package:flutter/material.dart';

enum TextButtonType { normal, outline, primary }

class TextButtonCustom extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isEnabled;
  final double width;
  final double height;
  final double radius;
  final double? textSize;
  final FontWeight? fontWeight;

  final TextButtonType type;
  final Color? bgColor;
  final Color? textColor;
  final Color? borderColor;
  final double borderWidth;

  const TextButtonCustom._({
    required this.text,
    required this.onPressed,
    required this.type,
    this.isEnabled = true,
    this.width = 0,
    this.height = 0,
    this.radius = 0,
    this.textSize,
    this.fontWeight,
    this.bgColor,
    this.textColor,
    this.borderColor,
    this.borderWidth = 1,
  });

  factory TextButtonCustom.normal({
    required String text,
    required VoidCallback onPressed,
    bool isEnabled = true,
    double? textSize,
    FontWeight? fontWeight,
    Color? textColor,
  }) {
    return TextButtonCustom._(
      text: text,
      onPressed: onPressed,
      type: TextButtonType.normal,
      isEnabled: isEnabled,
      width: 0,
      height: 0,
      radius: 0,
      textSize: textSize,
      fontWeight: fontWeight,
      textColor: textColor,
    );
  }

  factory TextButtonCustom.primary({
    required String text,
    required VoidCallback onPressed,
    bool isEnabled = true,
    double width = 0,
    double height = 0,
    double radius = 0,
    double? textSize,
    FontWeight? fontWeight,
    Color? bgColor,
    Color? textColor,
  }) {
    return TextButtonCustom._(
      text: text,
      onPressed: onPressed,
      type: TextButtonType.primary,
      isEnabled: isEnabled,
      width: width,
      height: height,
      radius: radius,
      textSize: textSize,
      fontWeight: fontWeight,
      bgColor: bgColor,
      textColor: textColor,
    );
  }

  factory TextButtonCustom.outline({
    required String text,
    required VoidCallback onPressed,
    bool isEnabled = true,
    double width = 0,
    double height = 0,
    double radius = 0,
    double? textSize,
    FontWeight? fontWeight,
    Color? borderColor,
    double borderWidth = 1,
    Color? textColor,
  }) {
    return TextButtonCustom._(
      text: text,
      onPressed: onPressed,
      type: TextButtonType.outline,
      isEnabled: isEnabled,
      width: width,
      height: height,
      radius: radius,
      textSize: textSize,
      fontWeight: fontWeight,
      borderColor: borderColor,
      borderWidth: borderWidth,
      textColor: textColor,
    );
  }

  @override
  Widget build(BuildContext context) {
    Color resolvedBgColor;
    Color resolvedTextColor;
    Color resolvedBorderColor;

    switch (type) {
      case TextButtonType.normal:
        resolvedBgColor = Colors.transparent;
        resolvedTextColor = textColor ?? Colors.black;
        resolvedBorderColor = Colors.transparent;
        break;
      case TextButtonType.primary:
        resolvedBgColor = isEnabled
            ? (bgColor ?? Colors.grey.shade300)
            : Colors.grey.shade300;
        resolvedTextColor = isEnabled
            ? (textColor ?? Colors.black)
            : Colors.white;
        resolvedBorderColor = Colors.transparent;
        break;
      case TextButtonType.outline:
        resolvedBgColor = Colors.transparent;
        resolvedTextColor = isEnabled
            ? (textColor ?? Colors.black)
            : Colors.white;
        resolvedBorderColor = isEnabled
            ? (borderColor ?? Colors.black)
            : Colors.white;
        break;
    }

    final ButtonStyle style = TextButton.styleFrom(
      backgroundColor: resolvedBgColor,
      minimumSize: Size(width, height),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radius),
        side: type == TextButtonType.outline
            ? BorderSide(color: resolvedBorderColor, width: borderWidth)
            : BorderSide.none,
      ),
      overlayColor: isEnabled ? null : Colors.transparent,
    );

    return TextButton(
      onPressed: isEnabled ? onPressed : null,
      style: style,
      child: Text(
        text,
        style: TextStyle(
          color: resolvedTextColor,
          fontSize: textSize,
          fontWeight: fontWeight,
        ),
      ),
    );
  }
}