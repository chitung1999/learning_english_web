import 'package:flutter/material.dart';

class TextButtonApp extends StatefulWidget {
  const TextButtonApp(
      {super.key,
        required this.title,
        this.size = 15,
        this.color = Colors.blueGrey,
        required this.onPressed});

  final String title;
  final double size;
  final Color color;
  final Function() onPressed;

  @override
  _TextButtonAppState createState() => _TextButtonAppState();
}

class _TextButtonAppState extends State<TextButtonApp> {
  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: ButtonStyle(
        overlayColor: MaterialStateProperty.all(Colors.transparent),
        splashFactory: NoSplash.splashFactory,
      ),
      onPressed: () {
        widget.onPressed();
      },
      child: Text(widget.title,
          style: TextStyle(
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.bold,
              fontSize: widget.size,
              color: widget.color)),
    );
  }
}