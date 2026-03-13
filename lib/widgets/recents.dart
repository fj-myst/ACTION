import 'package:flutter/material.dart';

class RecentsWidget extends StatelessWidget {
  const RecentsWidget({super.key});

  Widget placeholderCard() {
    return Container(
      width: 120,
      height: 150,
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        const Text(
          "DRAFTS",
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 20),

        Wrap(
          spacing: 20,
          runSpacing: 20,
          children: List.generate(4, (index) => placeholderCard()),
        ),

        const SizedBox(height: 40),

        const Text(
          "POSTED",
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 20),

        Wrap(
          spacing: 20,
          runSpacing: 20,
          children: List.generate(4, (index) => placeholderCard()),
        ),
      ],
    );
  }
}