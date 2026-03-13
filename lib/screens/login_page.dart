import 'package:flutter/material.dart';
import 'mobile/login_mobile.dart';
import 'web/login_web.dart';


class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final bool isMobile = screenWidth < 800;

    return isMobile ? const LoginMobile() : const LoginWeb();
  }
}