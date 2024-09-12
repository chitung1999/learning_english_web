import 'package:flutter/material.dart';
import '../../model/data_model.dart';
import '../item_control.dart';
import 'word_item.dart';

class WordTab extends StatefulWidget {
  const WordTab({super.key});

  @override
  _WordTabState createState() => _WordTabState();
}

class _WordTabState extends State<WordTab> {
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Container(),
      Scrollbar(
        thumbVisibility: true,
        trackVisibility: true,
        thickness: 12,
        radius: const Radius.circular(0),
        controller: _scrollController,
        child: SingleChildScrollView(
          controller: _scrollController,
          scrollDirection: Axis.vertical,
          child: Center(
            child: Wrap(
              direction: Axis.vertical,
              children: List.generate(dataModel.word.length,
                  (index) => WordElement(index: index)),
            ),
          ),
        ),
      ),
      if (MediaQuery.of(context).size.width > 1440)
        Positioned(
          top: 50,
          left: ((MediaQuery.of(context).size.width - 640) / 2 - 360) / 2,
          child: const SizedBox(
            width: 360,
            child: ItemControl(
              length: 3,
              hintText: ['Enter key', 'Enter mean', 'Enter note'],
            ),
          ),
        ),
      if (MediaQuery.of(context).size.width > 1440)
        Positioned(
          top: 50,
          right: ((MediaQuery.of(context).size.width - 640) / 2 - 360) / 2,
          child: Container(
            width: 360,
            color: Colors.blue,
          ),
        )
    ]);
  }
}
