import 'package:flutter/material.dart';
import '../../model/data_model.dart';

class WordElement extends StatefulWidget {
  const WordElement({super.key, required this.index});

  final int index;

  @override
  _WordElementState createState() => _WordElementState();
}

class _WordElementState extends State<WordElement> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 10),
        Container(
          width: 640,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            gradient: const LinearGradient(
              colors: [Colors.white70, Colors.white30],
              stops: [0.5, 1],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 1,
                blurRadius: 1,
                offset: const Offset(-1, 1),
              ),
            ],
          ),
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(dataModel.word[widget.index].keysToString(),
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.blueGrey[800],
                            fontWeight: FontWeight.bold)),
                    Text(dataModel.word[widget.index].meansToString(),
                        style: TextStyle(
                            fontSize: 20, color: Colors.blueGrey[800])),
                    if (dataModel.word[widget.index].note.isNotEmpty)
                      Text('Note:\n${dataModel.word[widget.index].note}',
                          style: TextStyle(
                              fontSize: 15,
                              color: Colors.blueGrey[900],
                              fontStyle: FontStyle.italic)),
                  ],
                ),
              ),
              MouseRegion(
                onEnter: (_) => setState(() => _isHovered = true),
                onExit: (_) => setState(() => _isHovered = false),
                child: IconButton(
                  icon: Icon(Icons.edit,
                      color: Colors.blueGrey.withOpacity(_isHovered ? 1 : 0)),
                  onPressed: () {},
                ),
                //child: Icon(Icons.add)
              ),
              MouseRegion(
                onEnter: (_) => setState(() => _isHovered = true),
                onExit: (_) => setState(() => _isHovered = false),
                child: IconButton(
                  icon: Icon(Icons.delete,
                      color: Colors.red[400]!.withOpacity(_isHovered ? 1 : 0)),
                  onPressed: () {},
                ),
              )
            ],
          ),
        ),
        if (widget.index == dataModel.word.length - 1)
          const SizedBox(height: 100)
      ],
    );
  }
}
