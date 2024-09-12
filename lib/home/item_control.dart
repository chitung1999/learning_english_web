import '../component/import_app.dart';

class ItemControl extends StatefulWidget {
  const ItemControl({super.key, required this.length, required this.hintText});

  final int length;
  final List<String> hintText;

  @override
  _ItemControlState createState() => _ItemControlState();
}

class _ItemControlState extends State<ItemControl> {
  final List<TextEditingController> _controller = [];

  @override
  void initState() {
    for (int i = 0; i < widget.length; i++) {
      _controller.add(TextEditingController());
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (int i = 0; i < widget.length; i++)
          Column(
            children: [
              TextField(
                controller: _controller[i],
                style: const TextStyle(fontSize: 20),
                decoration: InputDecoration(
                    hintText:
                        i < widget.hintText.length ? widget.hintText[i] : '',
                    hintStyle: TextStyle(
                        fontSize: 20, color: Colors.grey.withOpacity(0.3)),
                    border: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black26))),
              ),
              const SizedBox(height: 10)
            ],
          ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextBoxButtonApp(
                title: 'Cancel',
                width: 170,
                height: 50,
                radius: 5,
                textSize: 15,
                outlineColor: Colors.blueGrey,
                bgColor: Colors.white,
                textColor: Colors.blueGrey,
                onPressed: () {}),
            TextBoxButtonApp(
                title: 'OK',
                width: 170,
                height: 50,
                radius: 5,
                textSize: 15,
                onPressed: () {}),
          ],
        ),
        const SizedBox(height: 10),
        const Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
                '* Please enter keywords separated by (,) and \nno special characters.',
                textAlign: TextAlign.end,
                style: TextStyle(fontSize: 12, fontStyle: FontStyle.italic)),
          ],
        )
      ],
    );
  }
}
