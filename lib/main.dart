import 'package:flutter/material.dart';
import 'screens/login_page.dart'; // adjust the path if necessary

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My App',
      home: const LoginPage(),
    );
  }
}