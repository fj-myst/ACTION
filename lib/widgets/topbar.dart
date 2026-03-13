import 'package:flutter/material.dart';

class TopBar extends StatelessWidget {
  final VoidCallback? onMenuPressed;
  final VoidCallback? onLogoutPressed;

  const TopBar({
    super.key,
    this.onMenuPressed,
    this.onLogoutPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      color: const Color(0xFFC6E1E6),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.menu),
            onPressed: onMenuPressed,
          ),

          const SizedBox(width: 20),

          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: "Filter...",
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),

          const SizedBox(width: 20),
          const Icon(Icons.notifications),

          const SizedBox(width: 20),

          GestureDetector(
            onTap: onLogoutPressed,
            child: const CircleAvatar(
              backgroundColor: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}