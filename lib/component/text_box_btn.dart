import 'package:flutter/material.dart';

class TextBoxButtonApp extends StatefulWidget {
  const TextBoxButtonApp(
      {super.key,
      required this.title,
      required this.width,
      required this.height,
      this.bgColor = Colors.blueGrey,
      this.textSize = 15,
      this.textColor = Colors.white,
      required this.onPressed});

  final String title;
  final double width;
  final double height;
  final Color bgColor;
  final double textSize;
  final Color textColor;
  final Function() onPressed;

  @override
  _TextBoxButtonAppState createState() => _TextBoxButtonAppState();
}

class _TextBoxButtonAppState extends State<TextBoxButtonApp> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: ElevatedButton(
          onPressed: () {
            widget.onPressed();
          },
          style: ElevatedButton.styleFrom(backgroundColor: widget.bgColor),
          child: Text(widget.title,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: widget.textSize,
                  color: widget.textColor))),
    );
  }
}
