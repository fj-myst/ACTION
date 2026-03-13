import 'package:flutter/material.dart';
import 'mobile/home_mobile.dart';
import 'web/home_web.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
Widget build(BuildContext context) {
  final isWeb = MediaQuery.of(context).size.width > 800;

  return isWeb ? HomeWeb() : HomeMobile();
}

  }
