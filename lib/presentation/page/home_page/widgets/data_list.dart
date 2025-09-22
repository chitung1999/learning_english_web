import 'package:web/web.dart' as web;
import 'package:flutter/material.dart';
import 'package:learning_english_web/data/data_app.dart';
import 'package:provider/provider.dart';

class DataList extends StatefulWidget {
  const DataList({super.key});

  @override
  DataListState createState() => DataListState();
}

class DataListState extends State<DataList> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(),
          borderRadius: BorderRadius.circular(3),
      ),

      child: Consumer<DataApp>(
        builder: (context, content, child){
          List<Data> data = content.getData();
          return  ListView.separated(
            itemCount: data.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              Color bgColor = Colors.transparent;
              switch (data[index].type) {
                case TypeWord.normal:
                  break;
                case TypeWord.add:
                  bgColor = Colors.green.shade100;
                  break;
                case TypeWord.remove:
                  bgColor = Colors.red.shade100;
                  break;
              }

              return ListTile(
                onTap: () {
                  web.window.open('https://translate.google.com/?sl=en&tl=vi&text=${data[index].word}&op=translate', '_blank');
                },
                tileColor: bgColor,
                onLongPress: () {
                  if (data[index].type == TypeWord.remove) {
                    content.unRemoveWord(index);
                  } else {
                    content.removeWord(index);
                  }
                },
                title: Center(child: Text(
                    data[index].word,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)
                )),
              );
            },
            separatorBuilder: (context, index) {
              return const Divider(
                color: Colors.black87,
                height: 1,
                thickness: 1,
              );
            },
          );
      }),
    );
  }
}
