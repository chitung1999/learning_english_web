import 'package:flutter/material.dart';

class ImageButtonApp extends StatefulWidget {
  const ImageButtonApp(
      {super.key,
      required this.url,
      required this.size,
      required this.onPressed});

  final String url;
  final double size;
  final Function() onPressed;

  @override
  _ImageButtonAppState createState() => _ImageButtonAppState();
}

class _ImageButtonAppState extends State<ImageButtonApp> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.size,
      height: widget.size,
      child: IconButton(
        icon: Image.asset(widget.url),
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
        hoverColor: Colors.transparent,
        onPressed: () {
          widget.onPressed();
        },
      ),
    );
  }
}
