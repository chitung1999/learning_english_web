import 'package:flutter/material.dart';
import 'login/login.dart';
import 'home/home.dart';

void main() {
  runApp(const MyDictionary());
}

class MyDictionary extends StatefulWidget {
  const MyDictionary({super.key});

  @override
  _MyDictionaryState createState() => _MyDictionaryState();
}

class _MyDictionaryState extends State<MyDictionary> {
  bool _isLoginScreen = true;

  void _onLogin() {
    setState(() {
      _isLoginScreen = false;
    });
  }

  void _onLogout() {
    setState(() {
      _isLoginScreen = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: _isLoginScreen
            ? Login(onLogin: _onLogin)
            : Home(
                onLogout: _onLogout,
              ),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
