import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:learning_english_web/data/data_app.dart';
import 'package:learning_english_web/presentation/page/login_page/login_page.dart';
import 'package:learning_english_web/server/appwrite_helper.dart';
import 'package:provider/provider.dart';

void main() async {
  await server.initialize();
  runApp(
    ChangeNotifierProvider(
      create: (_) => DataApp(),
      child: const TheApp(),
    ),
  );
}

class TheApp extends StatelessWidget {
  const TheApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Learning English',
      scrollBehavior: const MaterialScrollBehavior().copyWith(
        dragDevices: {
          PointerDeviceKind.touch,
          PointerDeviceKind.mouse,
        },
      ),
      home: LoginPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}