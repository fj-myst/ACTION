import 'package:flutter/material.dart';
import '../../widgets/login_form.dart';

class LoginWeb extends StatelessWidget {
  const LoginWeb({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          // LEFT MAP SECTION
          Expanded(
            flex: 6,
            child: Container(
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 0, 29, 71),
                image: DecorationImage(
                  image: AssetImage("assets/images/calabrz.png"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),

          // RIGHT LOGIN PANEL
          Expanded(
            flex: 4,
            child: Container(
              color: const Color(0xFFE6E8EB),
              padding: const EdgeInsets.symmetric(horizontal: 60),
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        "ACTION",
                        style: TextStyle(
                          fontSize: 50,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1D3557),
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        "Activity, Conference & Task Information Operations Network",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black54,
                        ),
                      ),
                      SizedBox(height: 40),
                      LoginForm(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}