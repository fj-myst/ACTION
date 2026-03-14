import 'dart:async';
import 'package:flutter/material.dart';

import '../../widgets/news_feed.dart';
import '../../widgets/right_panel.dart';
import '../../widgets/sidebar.dart';
import '../../widgets/topbar.dart';
import '../../widgets/recents.dart';
import '../../widgets/create.dart';
import '../../widgets/tech_support.dart';
import '../../widgets/calendar_page.dart';

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

  /// DATA
  final List<Map<String, dynamic>> activities = [
    {"title": "Flag Ceremony", "venue": "Camp Vicente Lim", "date": DateTime(2026, 3, 2, 8, 0), "uniform": "Class B"},
    {"title": "Cybersecurity Workshop", "venue": "RITO Office", "date": DateTime(2026, 3, 3, 13, 0), "uniform": "Business Casual"},
    {"title": "Team Meeting", "venue": "Conference Room", "date": DateTime(2026, 3, 4, 9, 0), "uniform": "Class B"},
    {"title": "Extra Event", "venue": "Lobby", "date": DateTime.now(), "uniform": "Class B"},
  ];

  final List<Map<String, dynamic>> techSupportRequests = [
    {'activityTitle': 'Annual Meeting', 'venue': 'Conference Room', 'date': DateTime(2026, 3, 15), 'requestedBy': 'John Nash Fama'},
    {'activityTitle': 'IT Training', 'venue': 'Camp Vicente Lim', 'date': DateTime(2026, 3, 20), 'requestedBy': 'Jane Doe'},
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

    setState(() => _currentTime = "$hour:$minute:$second $ampm (UTC+8)");
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  Widget _buildMainContent() {
    switch (selectedPage) {
      case 0: return NewsFeed(activities: activities);
      case 1: return const RecentsWidget();
      case 2: return const CreateAnnouncementPage();
      case 3: return CalendarPage(activities: activities, techRequests: techSupportRequests);
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
      default: return const Center(child: Text("Page not implemented"));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          if (sidebarVisible)
            Sidebar(onMenuTap: (index) => setState(() => selectedPage = index)),
          Expanded(
            child: Column(
              children: [
                TopBar(onMenuPressed: () => setState(() => sidebarVisible = !sidebarVisible)),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(30),
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        if (constraints.maxWidth < 1200) {
                          return Column(
                            children: [
                              Expanded(child: _buildMainContent()),
                              const SizedBox(height: 20),
                              RightPanel(currentTime: _currentTime),
                            ],
                          );
                        } else {
                          return Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(flex: 3, child: _buildMainContent()),
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