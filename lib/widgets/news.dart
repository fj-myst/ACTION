import 'package:flutter/material.dart';

class NewsCard extends StatelessWidget {
  final String title;
  final String venue;
  final String datetime;
  final String uniform;
  final bool light;

  const NewsCard({
    super.key,
    required this.title,
    required this.venue,
    required this.datetime,
    required this.uniform,
    this.light = false,
  });

  @override
  Widget build(BuildContext context) {
    Color cardColor = const Color(0xFF5F9EA0); // default color
    if (light) cardColor = const Color(0xFFAED0D6); // light variant

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(12),
        border: light ? Border.all(color: Colors.black45) : null,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 10),
          Text("VENUE: $venue"),
          Text("DATE AND TIME: $datetime"),
          Text("UNIFORM: $uniform"),
        ],
      ),
    );
  }
}