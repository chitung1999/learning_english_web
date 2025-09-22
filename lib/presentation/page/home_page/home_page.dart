import 'package:flutter/material.dart';
import 'package:learning_english_web/constants/status_app.dart';
import 'package:learning_english_web/data/data_app.dart';
import 'package:learning_english_web/presentation/page/home_page/widgets/review_page.dart';
import 'package:learning_english_web/presentation/widgets/confirm_dialog.dart';
import 'package:learning_english_web/presentation/widgets/text_button.dart';
import 'package:learning_english_web/presentation/widgets/toast_message.dart';
import 'package:provider/provider.dart';
import '../../../server/appwrite_helper.dart';
import 'widgets/data_list.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  final TextEditingController _controller = TextEditingController();

  void onAddWord(DataApp content) {
    String text = _controller.text.trim().split(RegExp(r'\s+')).join(' ');

    if (text.isEmpty) {
      ToastMessage.show(context, StatusApp.newWordBlank);
      return;
    }
    if (content.checkExist(text)) {
      ToastMessage.show(context, StatusApp.newWordExist);
      return;
    }
    if (!RegExp(r'^[a-zA-Z ]+$').hasMatch(text)) {
      ToastMessage.show(context, StatusApp.newWordInvalid);
      return;
    }

    content.addWord(text);
    _controller.text = '';
  }

  Future<void> onUpdateData(DataApp content) async {
    if (true !=
      await showDialog<bool>(
        context: context,
        builder: (BuildContext context) {return ConfirmDialog();}
      )
    ) {
      return;
    }

    List<String> dataSever = [];
    if(!await server.getData(dataSever) && mounted) {
      ToastMessage.show(context, StatusApp.error);
      return;
    }

    List<Data> dataLocal = content.getData();
    for(var item in dataLocal) {
      switch (item.type) {
        case TypeWord.add:
          if(!dataSever.contains(item.word)) {
            dataSever.add(item.word);
          }
          break;
        case TypeWord.remove:
          if(dataSever.contains(item.word)) {
            dataSever.remove(item.word);
          }
          break;
        default:
          break;
      }
    }
    dataSever.sort();

    if(!await server.setData(dataSever) && mounted) {
      ToastMessage.show(context, StatusApp.updateFail);
      return;
    }

    content.initData(dataSever);
  }

  @override
  Widget build(BuildContext context) {
    double wScreen = MediaQuery.of(context).size.width;
    double wContent = 450;
    return Scaffold(
      body: Center(child: Container(
        padding: EdgeInsets.all(20),
        width: wScreen > wContent ? wContent : wScreen,
        child: Consumer<DataApp>(
          builder: (context, content, child){
            return Column(
              spacing: 20,
              children: [
                Row(
                  spacing: 10,
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _controller,
                        style: const TextStyle(fontSize: 17),
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(borderSide: BorderSide(color: Colors.blueAccent)),
                            contentPadding: EdgeInsets.only(left: 10, right: 10, bottom: 10)
                        ),
                        onSubmitted: (_) => onAddWord(content),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.add_box, color: Color(0xFF071B35)),
                      iconSize: 40,
                      onPressed: () => onAddWord(content)
                    )
                  ]
                ),
                Expanded(child: DataList()),
                Row(
                  spacing: 10,
                  children: [
                    Expanded(
                      child: TextButtonCustom.primary(
                        text: 'Review',
                        width: double.infinity,
                        height: 50,
                        textSize: 17,
                        radius: 5,
                        textColor: Colors.white,
                        bgColor: Color(0xFF071B35),
                        onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute<void>(builder: (context) => ReviewPage(works: content.getListStringData())),
                        )
                      ),
                    ),
                    Expanded(
                      child: TextButtonCustom.primary(
                        text: 'Update',
                        height: 50,
                        textSize: 17,
                        radius: 5,
                        textColor: Colors.white,
                        bgColor: Color(0xFF071B35),
                        onPressed: () async {
                          await onUpdateData(content);
                        }
                      ),
                    ),
                  ],
                )
              ]
            );
          }
        )
      ))
    );
  }
}
