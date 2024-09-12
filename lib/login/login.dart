import '../component/import_app.dart';
import '../model/database.dart';

class Login extends StatefulWidget {
  const Login({super.key, required this.onLogin});

  final Function() onLogin;

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _username = TextEditingController();
  final TextEditingController _password = TextEditingController();
  bool _isHidePassword = true;

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.grey[400],
        child: Center(
            child: Container(
                width: 500,
                height: 600,
                padding:
                    const EdgeInsets.symmetric(vertical: 30, horizontal: 50),
                color: Colors.white,
                child: Column(
                  children: [
                    const Text('My Dictionary',
                        style: TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                            color: Colors.blueGrey)),
                    const SizedBox(height: 50),
                    TextField(
                      controller: _username,
                      style: const TextStyle(fontSize: 20),
                      decoration: InputDecoration(
                          hintText: 'User name',
                          hintStyle: TextStyle(
                              fontSize: 20,
                              color: Colors.grey.withOpacity(0.3)),
                          icon: const Icon(Icons.person)),
                    ),
                    const SizedBox(height: 30),
                    TextField(
                      controller: _password,
                      obscureText: _isHidePassword,
                      style: const TextStyle(fontSize: 20),
                      decoration: InputDecoration(
                          hintText: 'Password',
                          hintStyle: TextStyle(
                              fontSize: 20,
                              color: Colors.grey.withOpacity(0.3)),
                          icon: const Icon(Icons.lock),
                          suffixIcon: IconButton(
                              icon: const Icon(Icons.visibility),
                              onPressed: () {
                                setState(() {
                                  _isHidePassword = !_isHidePassword;
                                });
                              })),
                    ),
                    const SizedBox(height: 30),
                    Row(
                      children: [
                        const Text("Don't have an account? Forgot password?",
                            style: TextStyle(fontSize: 15)),
                        TextButtonApp(
                          title: 'Contact',
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return const NotifyDialog(message: StatusApp.contactAccount);
                              }
                            );
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),
                    TextBoxButtonApp(
                        title: 'Login',
                        width: 300,
                        height: 50,
                        textSize: 25,
                        radius: 25,
                        onPressed: () async {
                          // if(_username.text.isEmpty || _password.text.isEmpty) {
                          //   ConfigApp.showNotify(context, MessageType.notice, StatusApp.blankAccount);
                          //   return;
                          // }
                          //
                          // showDialog(
                          //     context: context,
                          //     barrierDismissible: false,
                          //     builder: (BuildContext context) {
                          //       return const WaitingProgress();
                          //     }
                          // );
                          //
                          // StatusApp ret = await database.login(_username.text, _password.text);
                          // if(ret == StatusApp.success) {
                          //   widget.onLogin();
                          // } else {
                          //   ConfigApp.showNotify(context, MessageType.notice, ret);
                          // }
                          //
                          // Navigator.of(context).pop();
                          widget.onLogin();
                        }),
                    const SizedBox(height: 50),
                    const Text('or login with',
                        style: TextStyle(fontSize: 15, color: Colors.black54)),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ImageButtonApp(
                            url: 'data/icon/facebook.png',
                            size: 70,
                            onPressed: () {
                              ConfigApp.showNotify(context, MessageType.notice,
                                  StatusApp.newFeaturePornhub);
                            }),
                        const SizedBox(height: 30),
                        ImageButtonApp(
                            url: 'data/icon/facebook.png',
                            size: 70,
                            onPressed: () {
                              ConfigApp.showNotify(context, MessageType.notice,
                                  StatusApp.newFeature);
                            }),
                        const SizedBox(height: 30),
                        ImageButtonApp(
                            url: 'data/icon/facebook.png',
                            size: 70,
                            onPressed: () {
                              ConfigApp.showNotify(context, MessageType.notice,
                                  StatusApp.newFeature);
                            }),
                        const SizedBox(height: 30)
                      ],
                    ),
                  ],
                ))));
  }
}
