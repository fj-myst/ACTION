import 'dart:async';
import 'package:flutter/material.dart';
import '../../widgets/news.dart';
import '../../widgets/logout_dialog.dart'; // your reusable logout dialog

class HomeMobile extends StatefulWidget {
  const HomeMobile({super.key});

  @override
  State<HomeMobile> createState() => _HomeMobileState();
}

class _HomeMobileState extends State<HomeMobile> {
  late Timer _timer;
  String _currentTime = "";

  // Sample activities
  final List<Map<String, String>> activities = [
    {
      "title": "Flag Ceremony",
      "venue": "Camp Vicente Lim",
      "datetime": "Monday 8:00 AM",
      "uniform": "Class B",
    },
    {
      "title": "Cybersecurity Workshop",
      "venue": "RITO Office",
      "datetime": "Tuesday 1:00 PM",
      "uniform": "Business Casual",
    },
    {
      "title": "Team Meeting",
      "venue": "Conference Room",
      "datetime": "Wednesday 9:00 AM",
      "uniform": "Class B",
    },
  ];

  @override
  void initState() {
    super.initState();
    _updateTime();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _updateTime();
    });
  }

  void _updateTime() {
    final now = DateTime.now();
    final hour = now.hour > 12 ? now.hour - 12 : (now.hour == 0 ? 12 : now.hour);
    final minute = now.minute.toString().padLeft(2, '0');
    final ampm = now.hour >= 12 ? "PM" : "AM";

    setState(() {
      _currentTime = "$hour:$minute $ampm (UTC+8)";
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE9ECEF),
      body: SafeArea(
        child: Column(
          children: [
            /// HEADER
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                color: Color(0xFF1D3557),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
              child: Row(
                children: [
                  /// LOGO
                  Container(
                    width: 50,
                    height: 50,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/images/laguna.png"),
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),

                  /// USER INFO
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "PAT JUAN DELA CRUZ",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "Regional Information Technology Office",
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 12,
                          ),
                        ),
                        Text(
                          "PRO 4A",
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),

                  /// LOGOUT ICON
                  IconButton(
                    icon: const Icon(Icons.logout, color: Colors.white),
                    onPressed: () {
                      showLogoutDialog(context);
                    },
                  ),
                ],
              ),
            ),

            /// NEWS HEADER
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    "NEWS FEED",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Icon(Icons.notifications)
                ],
              ),
            ),

            /// NEWS LIST
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                itemCount: activities.length,
                separatorBuilder: (_, __) => const SizedBox(height: 15),
                itemBuilder: (context, index) {
                  final activity = activities[index];
                  return NewsCard(
                    title: activity['title']!,
                    venue: activity['venue']!,
                    datetime: activity['datetime']!,
                    uniform: activity['uniform']!,
                    light: true,
                  );
                },
              ),
            ),

            /// TIME
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Text(
                _currentTime,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),

      /// CALENDAR BUTTON
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        onPressed: () {},
        child: const Icon(
          Icons.calendar_month,
          color: Colors.black,
        ),
      ),
    );
  }
}