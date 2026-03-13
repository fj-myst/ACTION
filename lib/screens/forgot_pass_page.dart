import 'package:flutter/material.dart';
import 'mobile/forgot_pass_mobile.dart';
import 'web/forgot_pass_web.dart';

class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    if (width < 800) {
      return const ForgotPasswordMobile();
    } else {
      return const ForgotPasswordWeb();
    }
  }
}