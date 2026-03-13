import 'package:flutter/material.dart';

class TechSupportRequestCard extends StatelessWidget {
  final String activityTitle;
  final String venue;
  final DateTime date; // single date
  final String requestedBy;
  final bool light;

  const TechSupportRequestCard({
    super.key,
    required this.activityTitle,
    required this.venue,
    required this.date,
    required this.requestedBy,
    this.light = false,
  });

  String _formatDate(DateTime date) {
    return "${date.month}/${date.day}/${date.year}";
  }

  @override
  Widget build(BuildContext context) {
    Color cardColor = const Color(0xFF5F9EA0);
    if (light) cardColor = const Color(0xFFAED0D6);

    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(12),
        border: light ? Border.all(color: Colors.black45) : null,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start, // left-align all
        children: [
          Text(
            activityTitle, // left-aligned
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 8),
          Text("VENUE: $venue"),
          Text("DATE: ${_formatDate(date)}"),
          Text("REQUESTED BY: $requestedBy"),
        ],
      ),
    );
  }
} 