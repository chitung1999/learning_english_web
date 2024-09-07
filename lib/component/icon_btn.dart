import 'package:flutter/material.dart';

class IconButtonApp extends StatefulWidget {
  const IconButtonApp(
      {super.key,
      required this.title,
      required this.icon,
      required this.width,
      required this.height,
      this.bgColor = Colors.blueGrey,
      this.outlineColor = Colors.blueGrey,
      this.textSize = 15,
      this.textColor = Colors.white,
      required this.onPressed});

  final String title;
  final IconData icon;
  final double width;
  final double height;
  final Color bgColor;
  final Color outlineColor;
  final double textSize;
  final Color textColor;
  final Function() onPressed;

  @override
  _IconButtonAppState createState() => _IconButtonAppState();
}

class _IconButtonAppState extends State<IconButtonApp> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: ElevatedButton(
          onPressed: () {
            widget.onPressed();
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: widget.bgColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
              side: BorderSide(
                color: widget.outlineColor, // Màu của outline
              ),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(widget.icon, color: widget.textColor),
              const SizedBox(width: 20),
              Text(widget.title,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: widget.textSize,
                      color: widget.textColor))
            ],
          )),
    );
  }
}
