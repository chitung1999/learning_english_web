import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:learning_english_web/presentation/widgets/text_button.dart';
import 'package:web/web.dart' as web;

class ReviewPage extends StatefulWidget {
  const ReviewPage({super.key, required this.works});
  final List<String> works;

  @override
  ReviewPageState createState() => ReviewPageState();
}

class ReviewPageState extends State<ReviewPage> {
  late PageController _pageController;
  final FocusNode _focusNode = FocusNode();
  final List<String> _works = [];
  int _currentPage = 0;


  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _works.addAll(widget.works);
    _works.shuffle();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _onChangedPage(bool isNext) {
    if ((!isNext && _currentPage == 0) || (isNext && _currentPage == _works.length - 1)) {
      return;
    }

    setState(() {
      isNext ? _currentPage++ : _currentPage--;
    });

    _pageController.animateToPage(
      _currentPage,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _handleKey(KeyEvent event) {
    if (event is KeyDownEvent) {
      if (event.logicalKey == LogicalKeyboardKey.arrowRight) {
        _onChangedPage(true);
      } else if (event.logicalKey == LogicalKeyboardKey.arrowLeft) {
        _onChangedPage(false);
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        spacing: 40,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            height: 300,
            child: KeyboardListener(
              focusNode: _focusNode,
              autofocus: true,
              onKeyEvent: _handleKey,
              child: PageView(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
                children: [
                  for(int i = 0; i < _works.length; i++)
                    TextButtonCustom.outline(
                      text: _works[i],
                      textSize: 25,
                      radius: 5,
                      textColor: Colors.black,
                      borderColor: Color(0xFF071B35),
                      onPressed: () {
                        web.window.open('https://translate.google.com/?sl=en&tl=vi&text=${_works[i]}&op=translate', '_blank');
                      }
                    ),
                ],
              ),
            ),
          ),
          TextButtonCustom.primary(
              text: 'Back',
              width: 150,
              height: 50,
              textSize: 17,
              radius: 5,
              textColor: Colors.white,
              bgColor: Color(0xFF071B35),
              onPressed: () => Navigator.of(context).pop()
          ),
        ],
      ),
    );
  }
}