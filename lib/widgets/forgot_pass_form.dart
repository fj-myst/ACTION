import 'package:flutter/material.dart';

class ForgotPasswordForm extends StatelessWidget {
  const ForgotPasswordForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Forgot Password",
          style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 5),
        const Text(
          "Enter your email to reset your password",
          style: TextStyle(fontSize: 16, color: Colors.black54),
        ),

        const SizedBox(height: 30),

        const Text("Email Address"),
        const SizedBox(height: 10),

        const TextField(
          decoration: InputDecoration(
            hintText: "Enter your email address...",
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(12)),
            ),
          ),
        ),

        const SizedBox(height: 30),

        SizedBox(
          width: double.infinity,
          height: 50,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF1D3557),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            onPressed: () {},
            child: const Text(
              "SEND RESET LINK",
              style: TextStyle(fontSize: 16, letterSpacing: 1.2),
            ),
          ),
        ),

        const SizedBox(height: 15),

        Center(
          child: TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text("Back to Login"),
          ),
        )
      ],
    );
  }
}