import 'package:flutter/material.dart';
import 'login_page.dart';
import 'signup_page.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> main() async {
  await dotenv.load();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CoopLoto',
      theme: ThemeData(primarySwatch: Colors.green),
      initialRoute: '/',
      routes: {
        '/': (_) => const LoginPage(),
        '/signup': (_) => const SignUpPage(),
      },
    );
  }
}
