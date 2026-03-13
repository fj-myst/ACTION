import 'dart:async';
import 'package:flutter/material.dart';
import '../../widgets/news.dart';
import '../../widgets/sidebar.dart';
import '../../widgets/topbar.dart';
import '../../widgets/recents.dart';
import '../../widgets/create.dart';
import '../../widgets/tech_support.dart';

class HomeWeb extends StatefulWidget {
  const HomeWeb({super.key});

  @override
  State<HomeWeb> createState() => _HomeWebState();
}

class _HomeWebState extends State<HomeWeb> {

  late Timer _timer;
  String _currentTime = "";

  int selectedPage = 0;
  bool sidebarVisible = true;

  /// NEWS DATA
  final List<Map<String, String>> activities = [
    {"title": "Flag Ceremony", "venue": "Camp Vicente Lim", "datetime": "Monday 8:00 AM", "uniform": "Class B"},
    {"title": "Cybersecurity Workshop", "venue": "RITO Office", "datetime": "Tuesday 1:00 PM", "uniform": "Business Casual"},
    {"title": "Team Meeting", "venue": "Conference Room", "datetime": "Wednesday 9:00 AM", "uniform": "Class B"},
    {"title": "Training Session", "venue": "RITO Hall", "datetime": "Thursday 10:00 AM", "uniform": "Class B"},
    {"title": "Equipment Check", "venue": "IT Storage", "datetime": "Friday 2:00 PM", "uniform": "Class B"},
  ];

  /// TECH SUPPORT DATA
  final List<Map<String, dynamic>> techSupportRequests = [
    {
      'activityTitle': 'Annual Meeting',
      'venue': 'Conference Room',
      'date': DateTime(2026, 3, 15),
      'requestedBy': 'John Nash Fama',
    },
    {
      'activityTitle': 'IT Training',
      'venue': 'Camp Vicente Lim',
      'date': DateTime(2026, 3, 20),
      'requestedBy': 'Jane Doe',
    },
  ];

  @override
  void initState() {
    super.initState();
    _updateTime();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) => _updateTime());
  }

  void _updateTime() {
    final now = DateTime.now();

    final hour = now.hour.toString().padLeft(2, '0');
    final minute = now.minute.toString().padLeft(2, '0');
    final second = now.second.toString().padLeft(2, '0');
    final ampm = now.hour >= 12 ? "PM" : "AM";

    setState(() {
      _currentTime = "$hour:$minute:$second $ampm (UTC+8)";
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  /// PAGE SWITCHER
  Widget _buildMainContent() {
    switch (selectedPage) {

      case 0:
        return NewsFeed(activities: activities);

      case 1:
        return const RecentsWidget();

      case 2:
        return const CreateAnnouncementPage();

      case 4:
        return ListView.builder(
          padding: const EdgeInsets.all(8),
          itemCount: techSupportRequests.length,
          itemBuilder: (context, index) {

            final req = techSupportRequests[index];

            return TechSupportRequestCard(
              activityTitle: req['activityTitle'],
              venue: req['venue'],
              date: req['date'],
              requestedBy: req['requestedBy'],
              light: true,
            );
          },
        );

      default:
        return const Center(child: Text("Page not implemented"));
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body: Row(
        children: [

          /// SIDEBAR
          if (sidebarVisible)
            Sidebar(
              onMenuTap: (index) {
                setState(() {
                  selectedPage = index;
                });
              },
            ),

          /// MAIN CONTENT
          Expanded(
            child: Column(
              children: [

                /// TOPBAR
                TopBar(
                  onMenuPressed: () {
                    setState(() {
                      sidebarVisible = !sidebarVisible;
                    });
                  },
                ),

                /// PAGE BODY
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(30),

                    child: LayoutBuilder(
                      builder: (context, constraints) {

                        /// SMALL SCREENS
                        if (constraints.maxWidth < 1200) {
                          return Column(
                            children: [

                              Expanded(child: _buildMainContent()),

                              const SizedBox(height: 20),

                              RightPanel(currentTime: _currentTime),

                            ],
                          );
                        }

                        /// LARGE SCREENS
                        else {
                          return Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [

                              Expanded(
                                flex: 3,
                                child: _buildMainContent(),
                              ),

                              const SizedBox(width: 30),

                              RightPanel(currentTime: _currentTime),

                            ],
                          );
                        }

                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
/// NEWS FEED WIDGET
class NewsFeed extends StatelessWidget {
  final List<Map<String, String>> activities;
  const NewsFeed({super.key, required this.activities});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "NEWS FEED",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 20),
        Expanded(
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20,
              childAspectRatio: 2.8,
            ),
            itemCount: activities.length,
            itemBuilder: (context, index) {
              final activity = activities[index];
              return NewsCard(
                title: activity["title"]!,
                venue: activity["venue"]!,
                datetime: activity["datetime"]!,
                uniform: activity["uniform"]!,
                light: true,
              );
            },
          ),
        ),
      ],
    );
  }
}

/// RIGHT PANEL WIDGET
class RightPanel extends StatelessWidget {
  final String currentTime;
  const RightPanel({super.key, required this.currentTime});

  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: 1,
      child: SingleChildScrollView(
        child: Column(
          children: [
            // Clock Panel
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF0F2744),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  const Text(
                    "CURRENT TIME",
                    style: TextStyle(color: Colors.white70, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    currentTime,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Announcements Panel
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("ANNOUNCEMENTS", style: TextStyle(fontWeight: FontWeight.bold)),
                  SizedBox(height: 10),
                  Text("- Meeting at 3 PM"),
                  Text("- New IT policy updates"),
                  Text("- Cybersecurity training next week"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}