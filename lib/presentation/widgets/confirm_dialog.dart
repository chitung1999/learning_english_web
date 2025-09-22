import 'package:flutter/material.dart';
import 'package:learning_english_web/presentation/widgets/text_button.dart';

class ConfirmDialog extends StatelessWidget {
  const ConfirmDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Do you want to update data?', style: TextStyle(fontSize: 20)),
      content: SizedBox(),
      actions: [
        Row(
          spacing: 10,
          children: [
            Expanded(
              child: TextButtonCustom.outline(
                text: 'No',
                height: 50,
                textSize: 17,
                radius: 5,
                textColor: Colors.black,
                borderColor: Color(0xFF071B35),
                onPressed: () => Navigator.of(context).pop(false)
              ),
            ),
            Expanded(
              child: TextButtonCustom.primary(
                text: 'Yes',
                height: 50,
                textSize: 17,
                radius: 5,
                textColor: Colors.white,
                bgColor: Color(0xFF071B35),
                onPressed: () => Navigator.of(context).pop(true)
              ),
            ),
          ],
        ),
      ],
    );
  }

}