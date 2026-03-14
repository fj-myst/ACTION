import 'package:flutter/material.dart';
import 'news.dart';

class NewsFeed extends StatelessWidget {
  final List<Map<String, dynamic>> activities;
  const NewsFeed({super.key, required this.activities});

  String formatDate(dynamic date) {
    if (date == null) return "No date";
    if (date is! DateTime) return "Invalid date";

    final months = ["", "January","February","March","April","May","June","July","August","September","October","November","December"];
    int hour = date.hour;
    final ampm = hour >= 12 ? "PM" : "AM";
    if (hour > 12) hour -= 12;
    if (hour == 0) hour = 12;
    final minute = date.minute.toString().padLeft(2, '0');
    return "${months[date.month]} ${date.day}, ${date.year} $hour:$minute $ampm";
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("NEWS FEED", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        const SizedBox(height: 20),
        Expanded(
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, crossAxisSpacing: 20, mainAxisSpacing: 20, childAspectRatio: 2.8,
            ),
            itemCount: activities.length,
            itemBuilder: (context, index) {
              final activity = activities[index];
              return NewsCard(
                title: activity["title"]?.toString() ?? "No title",
                venue: activity["venue"]?.toString() ?? "No venue",
                datetime: formatDate(activity["date"]),
                uniform: activity["uniform"]?.toString() ?? "No uniform",
                light: true,
              );
            },
          ),
        ),
      ],
    );
  }
}