import 'package:flutter/material.dart';
import 'login_page.dart';
import 'signup_page.dart';

void main() {
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
