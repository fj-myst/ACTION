import 'package:flutter/material.dart';

class CalendarPage extends StatefulWidget {
  final List<Map<String, dynamic>> activities;
  final List<Map<String, dynamic>> techRequests;

  const CalendarPage({
    super.key,
    required this.activities,
    required this.techRequests,
  });

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  late DateTime currentMonth;

  @override
  void initState() {
    super.initState();
    currentMonth = DateTime.now();
  }

  /// Safely get events for a day
  List<Map<String, String>> getEvents(DateTime day) {
    List<Map<String, String>> result = [];

    for (var activity in widget.activities) {
      final date = activity["date"];
      if (date == null || date is! DateTime) continue; // skip null or invalid
      if (date.year == day.year &&
          date.month == day.month &&
          date.day == day.day) {
        result.add({"title": activity["title"], "type": "activity"});
      }
    }

    for (var req in widget.techRequests) {
      final date = req["date"];
      if (date == null || date is! DateTime) continue; // skip null or invalid
      if (date.year == day.year &&
          date.month == day.month &&
          date.day == day.day) {
        result.add({
          "title": "Tech Support: ${req["activityTitle"]}",
          "type": "tech"
        });
      }
    }

    return result;
  }

  void nextMonth() {
    setState(() {
      currentMonth = DateTime(currentMonth.year, currentMonth.month + 1);
    });
  }

  void prevMonth() {
    setState(() {
      currentMonth = DateTime(currentMonth.year, currentMonth.month - 1);
    });
  }

  @override
  Widget build(BuildContext context) {
    final firstDay = DateTime(currentMonth.year, currentMonth.month, 1);
    final daysInMonth =
        DateUtils.getDaysInMonth(currentMonth.year, currentMonth.month);
    final startWeekday = firstDay.weekday % 7;
    final totalCells = daysInMonth + startWeekday;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// HEADER
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "${_monthName(currentMonth.month)} ${currentMonth.year}",
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            Row(
              children: [
                IconButton(icon: const Icon(Icons.chevron_left), onPressed: prevMonth),
                IconButton(icon: const Icon(Icons.chevron_right), onPressed: nextMonth),
              ],
            )
          ],
        ),
        const SizedBox(height: 10),

        /// WEEKDAY LABELS
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text("Sun"),
            Text("Mon"),
            Text("Tue"),
            Text("Wed"),
            Text("Thu"),
            Text("Fri"),
            Text("Sat"),
          ],
        ),
        const SizedBox(height: 10),

        /// CALENDAR GRID
        Expanded(
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 7,
              crossAxisSpacing: 6,
              mainAxisSpacing: 6,
            ),
            itemCount: totalCells,
            itemBuilder: (context, index) {
              if (index < startWeekday) return const SizedBox();

              final dayNumber = index - startWeekday + 1;
              final day = DateTime(currentMonth.year, currentMonth.month, dayNumber);
              final dayEvents = getEvents(day);

              return Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("$dayNumber",
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 4),
                    if (dayEvents.isEmpty)
                      const Text("No events", style: TextStyle(fontSize: 10, color: Colors.grey)),
                    if (dayEvents.isNotEmpty)
                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            children: dayEvents.map((event) {
                              return Container(
                                width: double.infinity,
                                margin: const EdgeInsets.only(bottom: 2),
                                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                                decoration: BoxDecoration(
                                  color: event["type"] == "tech"
                                      ? Colors.orange
                                      : const Color(0xFF0F2744),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Text(
                                  event["title"]!,
                                  style: const TextStyle(
                                    fontSize: 10,
                                    color: Colors.white,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  String _monthName(int month) {
    const months = [
      "",
      "January","February","March","April","May","June",
      "July","August","September","October","November","December"
    ];
    return months[month];
  }
}