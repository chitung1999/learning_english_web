import 'package:flutter/material.dart';
import 'package:learning_english_web/constants/env_app.dart';
import 'package:learning_english_web/constants/status_app.dart';
import 'package:learning_english_web/data/data_app.dart';
import 'package:learning_english_web/model/account.dart';
import 'package:learning_english_web/presentation/page/home_page/home_page.dart';
import 'package:learning_english_web/presentation/widgets/text_button.dart';
import 'package:learning_english_web/presentation/widgets/toast_message.dart';
import 'package:provider/provider.dart';
import '../../../server/appwrite_helper.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  final TextEditingController _username = TextEditingController();
  final TextEditingController _password = TextEditingController();
  bool _isHidePassword = true;

  Future onLogin() async {
    if(_username.text.isEmpty || _password.text.isEmpty) {
      ToastMessage.show(context, StatusApp.loginBlank);
      return;
    }

    List<AccountApp> accounts = [];
    if(!await server.getAllAccount(accounts) && mounted) {
      ToastMessage.show(context, StatusApp.loginError);
      return;
    }

    for (AccountApp item in accounts) {
      if (item.user == _username.text && item.pw == _password.text) {
        EnvApp.rowID = item.id;
        EnvApp.userName = item.user;
        ToastMessage.show(context, StatusApp.loginSuccess, delay: 1000);

        List<String> data = [];
        if(!await server.getData(data) && mounted) {
          ToastMessage.show(context, StatusApp.loginError);
          return;
        }

        Provider.of<DataApp>(context, listen: false).initData(data);

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomePage()),
        );
        return;
      }
    }

    ToastMessage.show(context, StatusApp.loginWrongPassword);
  }

  @override
  void initState() {
    _username.text = 'admin';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double wScreen = MediaQuery.of(context).size.width;
    double hScreen = MediaQuery.of(context).size.height;
    double wDialog = 400;
    double hDialog = 380;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          color: Colors.grey.shade50,
          padding: EdgeInsets.symmetric(
            horizontal: wScreen > wDialog ? (wScreen-wDialog)/2 : 0,
            vertical: hScreen > hDialog ? (hScreen-hDialog)/2 : 0,
          ),
          child: Container(
            width: wDialog,
            height: hDialog,
            padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 50),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.grey.shade100, width: 2),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              spacing: 30,
              children: [
                const Text(
                  'Learning English',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Color(0xFF071B35))
                ),
                TextField(
                  controller: _username,
                  style: const TextStyle(fontSize: 20),
                  decoration: InputDecoration(
                      hintText: 'User name',
                      hintStyle: TextStyle(fontSize: 20, color: Colors.grey.withValues(alpha: 0.3)
                      ),
                      icon: const Icon(Icons.person)
                  ),
                ),
                TextField(
                  controller: _password,
                  obscureText: _isHidePassword,
                  style: const TextStyle(fontSize: 20),
                  decoration: InputDecoration(
                      hintText: 'Password',
                      hintStyle: TextStyle(fontSize: 20, color: Colors.grey.withValues(alpha: 0.3)
                      ),
                      icon: const Icon(Icons.lock),
                      suffixIcon: IconButton(
                          icon: const Icon(Icons.visibility),
                          onPressed: () {
                            setState(() {_isHidePassword = !_isHidePassword;});
                          }
                      )
                  ),
                ),
                const SizedBox(),
                TextButtonCustom.primary(
                    text: 'Login',
                    width: double.infinity,
                    height: 50,
                    textSize: 17,
                    radius: 5,
                    textColor: Colors.white,
                    bgColor: Color(0xFF071B35),
                    onPressed: onLogin
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
