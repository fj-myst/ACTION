import 'package:flutter/material.dart';

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
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(color: const Color(0xFF0F2744), borderRadius: BorderRadius.circular(12)),
              child: Column(
                children: [
                  const Text("CURRENT TIME", style: TextStyle(color: Colors.white70, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 10),
                  Text(currentTime, style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
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