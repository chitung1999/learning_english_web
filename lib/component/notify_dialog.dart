import 'import_app.dart';

class NotifyDialog extends StatefulWidget {
  const NotifyDialog({super.key, required this.message});

  final MessageApp message;

  @override
  _NotifyDialogState createState() => _NotifyDialogState();
}

class _NotifyDialogState extends State<NotifyDialog> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
        child: Container(
      padding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 30.0),
      child: IntrinsicHeight(
          child: Column(children: [
        const SizedBox(height: 10),
        Text(ConfigApp.message(widget.message),
            style: const TextStyle(fontSize: 20), textAlign: TextAlign.center),
        const SizedBox(height: 30),
        TextBoxButtonApp(
            title: 'OK',
            width: 150,
            height: 40,
            textSize: 15,
            onPressed: () {
              Navigator.of(context).pop();
            })
      ])),
    ));
  }
}
