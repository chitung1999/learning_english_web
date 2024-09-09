import 'package:flutter/material.dart';

class WaitingProgress extends StatefulWidget {
  const WaitingProgress(
      {super.key, this.title = 'Waiting...'});

  final String title;

  @override
  _WaitingProgressState createState() => _WaitingProgressState();
}

class _WaitingProgressState extends State<WaitingProgress> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: SizedBox(
        height: 150,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircularProgressIndicator(),
            const SizedBox(height: 30),
            Text(widget.title, style: const TextStyle(fontSize: 20))
          ],
        ),
      ),
    );
  }
}